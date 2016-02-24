class Parent::DashboardsController < ApplicationController
  
layout :layout?
before_filter :authenticate_parent!

  def index
  end
end
