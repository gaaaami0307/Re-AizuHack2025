class FeedbacksController < ApplicationController

  def index
    @feedback = FeedBack.new
    @ep = Plan.find_by(date:Date.today).ep
  end

  def create
    @feedback = FeedBack.new(feedback_params)

    if !@feedback.save
      render :index, notice: "フィードバックの保存に失敗しました。"
    end

    #終了判定(TOPページ処理用)
    plan = Plan.find_by(date:Date.today)
    plan.update(finished: true)

    #チューニング
    tuning_parameter()

    redirect_to tops_path
  end

  private

  def feedback_params
    params.require(:feedback).permit(:date, :ep, :tf, :con, :mtv)
  end

  def tuning_parameter
    feedback = FeedBack.find_by(date:Date.today)
    ep = Plan.find_by(date:Date.today).ep
    tuning = Tuning.find_by(ep:ep)

    T = tuning.T
    M = tuning.M
    C = tuning.C

    #シグモイド関数でチューニング
    T += sigmoid(feedback.tf)
    M += sigmoid(feedback.con)
    C += sigmoid(feedback.mtv)

    #0.1~0.9の範囲に抑えるように
    T = [T, 0.1].max
    T = [T, 0.9].min
    M = [M, 0.1].max
    M = [M, 0.9].min
    C = [C, 0.1].max
    C = [C, 0.9].min

    tuning.update(T:T, M:M, C:C)
  end

  def sigmoid(x)
    1.0 / (1.0 + Math.exp(-x))
  end

end
