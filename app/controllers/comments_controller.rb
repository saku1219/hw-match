class CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to  "/works/#{comment.work.id}"
    else
      flash[:comment_error] = "*空欄のためコメントできませんでした*"
      redirect_to  "/works/#{comment.work.id}"
    end
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
