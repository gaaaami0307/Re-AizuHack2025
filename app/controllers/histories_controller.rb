class HistoriesController < ApplicationController

  def index
    day = params[:day]
    @plan = Plan.find_by(date:day)
    @enable = false
    
    if @plan.present? 
      @enable = true;
    end

    if @enable
      @input = Input.find_by(date:day)
      @tasks = Task.where(date:day)
    end
  end
  
end
