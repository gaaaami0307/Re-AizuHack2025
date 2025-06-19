class FeedbacksController < ApplicationController

  def index

  end

  def create
    @feedback = Food.new(feedback_params)

    if !@feedback.save
      render :index, status; ;unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:date, :ep, :tf, :con, :mtv)
  end

end
