class  CommentsController < ApplicationController
  before_action :need_log_in, only: [:create]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      @post.comments << @comment
      flash['notice'] = 'New comment was added!'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    vote = Vote.create(vote: params[:vote], user: current_user, voteable: @comment)

    if vote.valid?
      flash['notice'] = "You vote was counted!"
      redirect_to :back
    else
      flash[:error] = "You can vote only once per comment"
      redirect_to :back
    end
  end
end
