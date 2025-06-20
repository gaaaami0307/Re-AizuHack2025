require 'csv'

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

    #AIにデータを渡す
    input_path = Rails.root.join('emotion_ai','data','input.csv')
    output_path = Rails.root.join('emotion_ai','data','output','output.csv')
    app_path = Rails.root.join('emotion_ai', 'pred.py')

    #書き込み
    CSV.open(input_path, 'w', encoding: 'UTF-8') do |csv|
      csv << ['text']
      csv << [@input.emotion]
    end

    #app実行
    system("python3 #{app_path} input.csv")

    #読み込み
    negative = nil
    neutral = nil
    positive = nil

    CSV.foreach(output_path, encoding: "UTF-8").with_index(1) do |row, index|
      if index == 2
        negative = row[2].to_d
        neutral = row[3].to_d
        positive = row[4].to_d
        break
      end
    end

    Emotion.create(date:Date.today, positive:positive, neutral:neutral, negative:negative)

    #ep計算
    ep = nil
    ep_judge = (2 * positive) + (-2 * negative)

    if ep_judge >= 1.5 
      ep = 5
    elsif ep_judge >= 0.75 
      ep = 4
    elsif ep_judge > -0.75 
      ep = 3
    elsif ep_judge > -1.5
      ep = 2
    else 
      ep = 1
    end

    #タスクの数
    numtask = Task.where(date:Date.today).count

    #最大勉強時間
    maxtime = Input.find_by(date:Date.today).maxtime

    #勉強時間の確率をチューニングから取り出す
    tuning = Tuning.find_by(ep:ep)

    #勉強時間割合の計算
    percent = (tuning.T*3 + tuning.C*5 + tuning.M*1) / 9.0

    puts "percent:"
    puts percent

    #実際勉強時間を計算
    time = ((maxtime*60) * percent).to_i

    #Planに記録
    Plan.create(date:Date.today, ep:ep, num: numtask, time:time, finished:false)

    #redirect_to tops_path
    head :no_content

  end

  private

  def input_params
    params.require(:input).permit(:date, :emotion, :maxtime)
  end

end
