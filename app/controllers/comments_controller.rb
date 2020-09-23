class CommentsController < ApplicationController

  def create
    comment = Comment.create(comment_params)
    redirect_to  "/works/#{comment.work.id}"
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to "/works/#{comment.work.id}"
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, work_id: params[:work_id])
  end

end
