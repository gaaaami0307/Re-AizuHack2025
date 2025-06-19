class TopsController < ApplicationController

  def index
    @tasks = Task.where(date:Date.today)
    @task = Task.new
    @plan = Plan.find_by(date:Date.today)
  end

  def create
    
    @task = Task.new(task_params)

    if @task.save
      redirect_to tops_path
    else
      render :index, notice: "タスクの保存に失敗しました。"
      return
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tops_path
  end

  private

  def task_params
    params.require(:task).permit(:date, :content, :complete)
  end

end
