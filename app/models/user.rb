class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_one :profile_image, dependent: :destroy
  has_one :watson_req, dependent: :destroy
  has_many :chatmembers, dependent: :destroy

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

end
