class FeedbacksController < ApplicationController

  def index
    @feedback = FeedBack.new
    @ep = Plan.find_by(date:Date.today).ep
  end

  def create
    @feedback = FeedBack.new(feedback_params)

    if !@feedback.save
      render :index, status; ;unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:date, :ep, :tf, :con, :mtv)
  end

end
