class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_one :profile_image, dependent: :destroy
  has_one :watson_req, dependent: :destroy
  has_many :chatmembers, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { maximum: 20 }
  validates :name, length: { minimum: 2 }
  validates :introduction, length: { maximum: 200 }

  # Paranoia
  acts_as_paranoid

  # フォロー関係
  # 自分がフォローする側
  has_many :active_relationships, class_name:  "Relationship",
                  foreign_key: "follower_id",
                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  # 自分がフォローされる側
  has_many :passive_relationships, class_name:  "Relationship",
                  foreign_key: "followed_id",
                  dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  # 友達申請関係
  # 自分が友達申請する側
  has_many :active_friendships, class_name:  "Friendship",
                  foreign_key: "from_user_id",
                  dependent:   :destroy
  has_many :to_users, through: :active_friendships
  # 自分が申請される側
  has_many :passive_friendships, class_name:  "Friendship",
                  foreign_key: "to_user_id",
                  dependent:   :destroy
  has_many :from_users, through: :passive_friendships

  # enum関係
  enum degree: { secret_degree: 0, e1: 1, e2: 2, e3: 3, e4: 4, e5: 5, e6: 6, jh1: 7, jh2: 8, jh3: 9, h1: 10, h2: 11, h3: 12, bachelor: 13, master: 14}
  enum location: {secret_location: 0, l1: 1, l2: 2, l3: 3, l4: 4, l5: 5, l6: 6, l7: 7, l8: 8, l9: 9, l10: 10, l11: 11, l12: 12, l13: 13, l14: 14, l15: 15, l16: 16, l17: 17, l18: 18, l19: 19, l20: 20, l21: 21, l22: 22, l23: 23, l24: 24, l25: 25, l26: 26, l27: 27, l28: 28, l29: 29, l30: 30, l31: 31, l32: 32, l33: 33, l34: 34, l35: 35, l36: 36, l37: 37, l38: 38, l39: 39, l40: 40, l41: 41, l42: 42, l43: 43, l44: 44, l45: 45, l46: 46, l47: 47}
  enum sex: {secret_sex: 0, male: 1, female: 2, LGBT: 3}

  # device カウンセラー申請したら承認がないとログインできない機能
    def active_for_authentication?
      super && approved != 1
    end

    def inactive_message
      approved != 1 ? super : :not_approved
    end

  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーをアンフォローする(論理削除になるように書き換える)
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # ユーザーに友達申請する
  def request(other_user)
    active_friendships.create(to_user_id: other_user.id)
  end

  # ユーザーの友達申請を許可する
  def approve_friend(other_user)
    # passive_friendships.find_by(to_user_id: current_user.id, from_user_id: other_user.id).update(friendstatus: 1)
    passive_friendships.find_by(from_user_id: other_user.id).update(friendstatus: 1)
  end

  # ユーザーの友達申請を拒否する
  def reject_friend(other_user)
    passive_friendships.find_by(from_user_id: other_user.id).update(friendstatus: 2)
  end

  # current_userの友達を全員取得する
  def all_friends(current_user)
    @friends1 = Friendship.where(friendstatus: 1, to_user_id: current_user.id)
    @friends2 = Friendship.where(friendstatus: 1, from_user_id: current_user.id)
      if @friends2 != []
        # binding.pry
          active_friends = @friends2.map {|friend|
                                    if friend.to_user.approved != 2
                                      friend.to_user
                                    end }
          active_friends = active_friends.compact
      end
      if @friends1 != []
        # binding.pry
          passfriends = @friends1.map {|friend|
                                    if friend.to_user.approved != 2
                                      friend.from_user
                                    end }
          passfriends = passfriends.compact
      end
          if (passfriends == [nil] || passfriends == nil) && (active_friends == [nil] || active_friends == nil)
            # binding.pry
               return false
          elsif (passfriends == [nil] || passfriends == nil) && (active_friends != [nil] || active_friends != nil)
            # binding.pry
               return active_friends
          elsif (passfriends != [nil] || passfriends != nil) && (active_friends == [nil] || active_friends == nil)
            # binding.pry
               return passfriends
          else
            # binding.pry
               return passfriends + active_friends
          end
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 現在のユーザーが、detail_view上のユーザーに友達申請してたらtrueを返す
  def requested?(other_user)
    to_users.include?(other_user)
  end

  # chatroomのidを検索
  def chatroom_number(current_user, other_user)
    array1 = Chatmember.where(user_id: current_user.id).map {|member| member.chatroom_id}
    array2 = Chatmember.where(user_id: other_user.id).map {|member| member.chatroom_id}
    array = array1 & array2
    return room_number = array[0].to_i
  end

  # Watson変数
  def watson_chart(user, gon)
      if WatsonReq.with_deleted.find_by(user_id: user.id)
        wa = WatsonReq.with_deleted.find_by(user_id: user.id)
      # if user.watson_req
            # 五大個性(ラベル)
            gon.big5_title = "５大個性"
            # 五大個性(数値)
            # @big5_openness = user.watson_req.big5_openness * 100
            # @big5_conscientiousness = user.watson_req.big5_conscientiousness * 100
            # @big5_extraversion = user.watson_req.big5_extraversion * 100
            # @big5_agreeableness = user.watson_req.big5_agreeableness * 100
            # @big5_neuroticism = user.watson_req.big5_neuroticism * 100
            @big5_openness = wa.big5_openness * 100
            @big5_conscientiousness = wa.big5_conscientiousness * 100
            @big5_extraversion = wa.big5_extraversion * 100
            @big5_agreeableness = wa.big5_agreeableness * 100
            @big5_neuroticism = wa.big5_neuroticism * 100
              gon.big5_values = [@big5_openness, @big5_conscientiousness, @big5_extraversion, @big5_agreeableness, @big5_neuroticism]
            # 五大個性(名前)
            # @big5_openness_name = user.watson_req.big5_openness_name
            # @big5_conscientiousness_name = user.watson_req.big5_conscientiousness_name
            # @big5_extraversion_name = user.watson_req.big5_extraversion_name
            # @big5_agreeableness_name = user.watson_req.big5_agreeableness_name
            # @big5_neuroticism_name = user.watson_req.big5_neuroticism_name
            @big5_openness_name = wa.big5_openness_name
            @big5_conscientiousness_name = wa.big5_conscientiousness_name
            @big5_extraversion_name = wa.big5_extraversion_name
            @big5_agreeableness_name = wa.big5_agreeableness_name
            @big5_neuroticism_name = wa.big5_neuroticism_name
              gon.big5_labels = [@big5_openness_name, @big5_conscientiousness_name, @big5_extraversion_name, @big5_agreeableness_name, @big5_neuroticism_name]
            # 12欲求(ラベル)
            gon.need_title = "深層欲求"
            # 12欲求(数値)
            # @need_challenge = user.watson_req.need_challenge * 100
            # @need_closeness = user.watson_req.need_closeness * 100
            # @need_curiosity = user.watson_req.need_curiosity * 100
            # @need_excitement = user.watson_req.need_excitement * 100
            # @need_harmony = user.watson_req.need_harmony * 100
            # @need_ideal = user.watson_req.need_ideal * 100
            # @need_liberty = user.watson_req.need_liberty * 100
            # @need_love = user.watson_req.need_love * 100
            # @need_practicality = user.watson_req.need_practicality * 100
            # @need_self_expression = user.watson_req.need_self_expression * 100
            # @need_stability = user.watson_req.need_stability * 100
            # @need_structure = user.watson_req.need_structure * 100
            @need_challenge = wa.need_challenge * 100
            @need_closeness = wa.need_closeness * 100
            @need_curiosity = wa.need_curiosity * 100
            @need_excitement = wa.need_excitement * 100
            @need_harmony = wa.need_harmony * 100
            @need_ideal = wa.need_ideal * 100
            @need_liberty = wa.need_liberty * 100
            @need_love = wa.need_love * 100
            @need_practicality = wa.need_practicality * 100
            @need_self_expression = wa.need_self_expression * 100
            @need_stability = wa.need_stability * 100
            @need_structure = wa.need_structure * 100
              gon.need_values = [@need_challenge, @need_closeness, @need_curiosity, @need_excitement, @need_harmony, @need_ideal, @need_liberty, @need_love, @need_practicality, @need_self_expression, @need_stability, @need_structure]
            # 12欲求(名前)
            # @need_challenge_name = user.watson_req.need_challenge_name
            # @need_closeness_name = user.watson_req.need_closeness_name
            # @need_curiosity_name = user.watson_req.need_curiosity_name
            # @need_excitement_name = user.watson_req.need_excitement_name
            # @need_harmony_name = user.watson_req.need_harmony_name
            # @need_ideal_name = user.watson_req.need_ideal_name
            # @need_liberty_name = user.watson_req.need_liberty_name
            # @need_love_name = user.watson_req.need_love_name
            # @need_practicality_name = user.watson_req.need_practicality_name
            # @need_self_expression_name = user.watson_req.need_self_expression_name
            # @need_stability_name = user.watson_req.need_stability_name
            # @need_structure_name = user.watson_req.need_structure_name
            @need_challenge_name = wa.need_challenge_name
            @need_closeness_name = wa.need_closeness_name
            @need_curiosity_name = wa.need_curiosity_name
            @need_excitement_name = wa.need_excitement_name
            @need_harmony_name = wa.need_harmony_name
            @need_ideal_name = wa.need_ideal_name
            @need_liberty_name = wa.need_liberty_name
            @need_love_name = wa.need_love_name
            @need_practicality_name = wa.need_practicality_name
            @need_self_expression_name = wa.need_self_expression_name
            @need_stability_name = wa.need_stability_name
            @need_structure_name = wa.need_structure_name
              gon.need_labels = [@need_challenge_name, @need_closeness_name, @need_curiosity_name, @need_excitement_name, @need_harmony_name, @need_ideal_name, @need_liberty_name, @need_love_name, @need_practicality_name, @need_self_expression_name, @need_stability_name, @need_structure_name]
            # 五大価値観(ラベル)
            gon.value_title = "５大価値観"
            # 五大価値観(数値)
            # @value_conservation = user.watson_req.value_conservation * 100
            # @value_openness_to_change = user.watson_req.value_openness_to_change * 100
            # @value_hedonism = user.watson_req.value_hedonism * 100
            # @value_self_enhancement = user.watson_req.value_self_enhancement * 100
            # @value_self_transcendence = user.watson_req.value_self_transcendence * 100
            @value_conservation = wa.value_conservation * 100
            @value_openness_to_change = wa.value_openness_to_change * 100
            @value_hedonism = wa.value_hedonism * 100
            @value_self_enhancement = wa.value_self_enhancement * 100
            @value_self_transcendence = wa.value_self_transcendence * 100
              gon.value_values = [@value_conservation, @value_openness_to_change, @value_hedonism, @value_self_enhancement, @value_self_transcendence]
            # 五大価値観(名前)
            # @value_conservation_name = user.watson_req.value_conservation_name
            # @value_openness_to_change_name = user.watson_req.value_openness_to_change_name
            # @value_hedonism_name = user.watson_req.value_hedonism_name
            # @value_self_enhancement_name = user.watson_req.value_self_enhancement_name
            # @value_self_transcendence_name = user.watson_req.value_self_transcendence_name
            @value_conservation_name = wa.value_conservation_name
            @value_openness_to_change_name = wa.value_openness_to_change_name
            @value_hedonism_name = wa.value_hedonism_name
            @value_self_enhancement_name = wa.value_self_enhancement_name
            @value_self_transcendence_name = wa.value_self_transcendence_name
              gon.value_labels = [@value_conservation_name, @value_openness_to_change_name, @value_hedonism_name, @value_self_enhancement_name, @value_self_transcendence_name]
      end
  end

  def appear(data)
    puts data
    User.find(data[:on]).update!(online: true)
    # current_user.update(online: true)
    ActionCable.server.broadcast 'appearance_channel', {event: 'appear', on: data[:on]}
  end

  def away(data)
    User.find(data).update!(online: false)
    puts User.find(data[:on])
    ActionCable.server.broadcast "appearance_channel", {event: 'away', on: data[:on]}
  end

end
