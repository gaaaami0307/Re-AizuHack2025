class TopsController < ApplicationController

  def index
    @tasks = Task.where(date:Date.today)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tops_path
    else
      render :index, status; ;unprocessable_entity, notice: "タスクの保存に失敗しました。"
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
