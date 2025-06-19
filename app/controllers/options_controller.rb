class OptionsController < ApplicationController

  def index

    #タスクなしの状態でこれなくする
    if !Task.where(date:Date.today).present?
      redirect_to tops_path, notice: "最低でも1件のタスクを入力してください。"
      return
    end
    
    @input = Input.new
    @inputed = Input.find_by(date:Date.today)
  end

  def create

    if Input.where(date:Date.today).present?
      redirect_to options_path, notice: "すでに今日の状態を入力しました。"
      return
    end

    @input = Input.new(input_params)

    if !@input.save
      redirect_to options_path, notice: "感情を入力してください。"
      return
    end


  end

  private

  def input_params
    params.require(:input).permit(:date, :emotion, :maxtime)
  end

end
