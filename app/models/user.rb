class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :profile_images, dependent: :destroy
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

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

end
