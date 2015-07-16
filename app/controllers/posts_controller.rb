class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :vote]
  before_action :need_log_in, except: [:index, :show]
  before_action :require_same_user_to_edit_post, only: [:update, :destroy, :edit]

  def index
    @posts = Post.all.sort { |x, y| y.total_votes <=> x.total_votes }
  end

  def new
    @post = Post.new()
  end

  def show
    @comment = Comment.new()
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash["notice"] = "New post has been saved!"
      redirect_to posts_path
    else
      render "new"
    end
  end

  def update
    if !@post.update(post_params)
      render  "edit"
    else
      flash['notice'] = "Post has been updated!"
      redirect_to posts_path
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def vote
    vote = Vote.create(vote: params[:vote], user: current_user, voteable: @post)

    if vote.valid?
      flash['notice'] = "Your votes has been counted."
      redirect_to :back
    else
      flash[:error] = "You can only vote once."
      redirect_to :back
    end
  end

  private

  def post_params
    params.require(:post).permit(:url, :title, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
