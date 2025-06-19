class TopsController < ApplicationController

  def index

  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tops_path
    else
      render :index, status; ;unprocessable_entity
    end
  end

  def destroy

  end

  private

  def task_params
    params.require(:task).permit(:date, :content, :complete)
  end

end
