class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[home show]

  def index 

  end

  def home
  end

  def programs 
  end

  def show
    @user = current_user
  end

end
