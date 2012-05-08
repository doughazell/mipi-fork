class HomeController < ApplicationController
  def index
    @registrations = Registration.viewable(current_user)
    @ids = Array.new
    @registrations.each do |r|
      logger.info("Globe ID: #{r.globe_id}")
      @ids.push(r.globe_id)
    end
    @globes = Globe.find_all_by_id(@ids)

    #
    
    if !@globes.blank? then
      respond_to do |format|
        format.html { render '/globes/index' }
        format.html # index.html.erb
        format.xml  { render :xml => @globes }
      end
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @globes }
      end
    end

  end

  def show
  end
end
