class FeedbacksController < ApplicationController

  def index
    @feed_back = FeedBack.new
    @ep = Plan.find_by(date:Date.today).ep
  end

  def create
    @feed_back = FeedBack.new(feed_back_params)

    if !@feed_back.save
      render json: { error: "フィードバックの保存に失敗しました" }, status: :bad_request
      return
    end

    #終了判定(TOPページ処理用)
    plan = Plan.find_by(date:Date.today)
    plan.update(finished: true)

    #チューニング
    tuning_parameter()

    #redirect_to tops_path
    head :no_content
  end

  private

  def feed_back_params
    params.require(:feed_back).permit(:date, :ep, :tf, :con, :mtv)
  end

  def tuning_parameter
    feed_back = FeedBack.find_by(date:Date.today)
    ep = Plan.find_by(date:Date.today).ep
    tuning = Tuning.find_by(ep:ep)

    t = tuning.T
    m = tuning.M
    c = tuning.C

    # tanh関数でチューニング
    t += tanh(feed_back.tf - 3) / 4
    m += tanh(feed_back.con - 3) / 4
    c += tanh(feed_back.mtv - 3) / 4

    #0.1~0.9の範囲に抑えるように
    t = [t, 0.1].max
    t = [t, 0.9].min
    m = [m, 0.1].max
    m = [m, 0.9].min
    c = [c, 0.1].max
    c = [c, 0.9].min

    tuning.update(T:t, M:m, C:c)
    puts "----------------------------------------"
    puts "t:"
    puts t
    puts "m:"
    puts m
    puts "c:"
    puts c
    puts "----------------------------------------"
  end

  def tanh(x)
    # 値域 [-1, 1]
    (Math.exp(x) - Math.exp(-x)) / (Math.exp(x) + Math.exp(-x))
  end

end
