class  CommentsController < ApplicationController
  before_action :need_log_in, only: [:create]

  def create
    @post = Post.find_by(slug: params[:post_id])
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
    @vote = Vote.create(vote: params[:vote], user: current_user, voteable: @comment)

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash['notice'] = "You vote was counted!"
        else
          flash[:error] = "You can vote only once per comment"
        end
        redirect_to :back
      end

      format.js
    end
  end
end
