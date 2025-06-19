class OptionsController < ApplicationController

  def index

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
