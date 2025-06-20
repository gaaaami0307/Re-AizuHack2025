class HistoriesController < ApplicationController

  def index
    @today = Date.parse(params[:date])
    @plan = Plan.find_by(date:@today)
    @enable = false
    @prev = @today - 1;
    @next = @today + 1;
    
    if @plan.present? 
      @enable = true;
    end

    if @enable
      @input = Input.find_by(date:@today)
      @tasks = Task.where(date:@today)
    end
  end
  
end
