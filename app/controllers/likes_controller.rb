class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    redirect_to posts_path, success: '成功'
  end

  def destroy
    post = current_user.likes.find(params[:id]).post
    current_user.unlike(post)
    redirect_to posts_path, success: '成功', status: :see_other
  end

  private
    def like_params
      params.permit(:post_id)
    end
end
