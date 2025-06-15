class MainsController < ApplicationController

  def index
    @foods = Food.all
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to mains_path
    else
      render :index, status; ;unprocessable_entity
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :price)
  end

end
