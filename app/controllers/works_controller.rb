class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new]

  def index
    @work = Work.order('start_time DESC').includes(:user)
  end
  
  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @work.comments.includes(:user)
    @chat = Chat.new
  end

  def update
    if @work.update(update_params)
      redirect_to work_path
    else
      render :edit
    end
  end

  def destroy
    if @work.destroy
      redirect_to user_path
    else
      render :edit
    end
  end
  
  private
  
  def work_params
    params.require(:work).permit(:type_id, :name, :genre_id, :place, :start_time, :end_time, :description).merge(user_id: current_user.id)
  end
  
  def update_params
    params.require(:work).permit(:type_id, :name, :genre_id, :place, :start_time, :end_time, :description)
  end
  
  def set_work
    @work = Work.find(params[:id])
  end

  def correct_user
    work = Work.find(params[:id])
    if !user_signed_in? || current_user.id != work.user_id
      redirect_to root_path
    end
  end
end
