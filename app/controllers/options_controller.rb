class OptionsController < ApplicationController

  def index

    #タスクなしの状態でこれなくする
    if !Task.where(date:Date.today).present?
      redirect_to tops_path, notice: "最低でも1件のタスクを入力してください。"
    end
    
    @input = Input.new
  end

  def create
    @input = Input.new(input_params)

    if !@input.save
      render :index, status; ;unprocessable_entity
    end


  end

  private

  def input_params
    params.require(:input).permit(:date, :emotion, :maxtime)
  end

end
