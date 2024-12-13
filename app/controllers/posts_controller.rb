class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.limit(10).includes(:photos, :user).order("created_at DESC") #includesでN＋１問題を解決　#limitで１０個まで取得　#orderで並び替え
  end

  def new
    @post = Post.new
    @post.photos.build
  end

  def create
    @post = Post.new(post_params)
    if @post.photos.present?
      @post.save
      redirect_to root_path
      flash[:notice] = "投稿が保存されました"
    else
      redirect_to root_path
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  private
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
    end
end