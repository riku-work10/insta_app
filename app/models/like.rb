class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }  #投稿１に関してAさんがいいねを押せる回数を一回とする　user_idとpost_idの組み合わせが重複しないこと
end
