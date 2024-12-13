class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }

  def update_without_current_password(params, *options)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :like_posts, through: :likes, source: :post

  def like(post)
    like_posts << post
  end

  def unlike(post)
    like_posts.destroy(post)
  end

  def like?(post)  #条件分岐で使うかも
    like_posts.include?(post) #include？はexistsに置き換えても問題はない！
  end
end
