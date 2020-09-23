class WorksController < ApplicationController
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

  private

  def work_params
    params.require(:work).permit(:type_id, :name, :genre_id, :place, :start_time, :end_time, :description).merge(user_id: current_user.id)
  end
end
