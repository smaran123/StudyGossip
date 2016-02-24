require 'will_paginate/array' 
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper:all
  helper_method :after_sign_in_path_for
  
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      profiles_path(:school_name => current_user.school_admin.school)
    elsif resource_or_scope.is_a?(Parent)
      parent_dashboards_path
    end
  end

  def is_login?
    unless current_user
      flash[:error] = "Please login"
      redirect_to '/'
    end
  end


  private
  def is_admin?
    unless current_admin
      flash[:error] = 'Please Login.'
      redirect_to '/'
    end
  end

  def is_school?
    unless current_school_admin
      flash[:error] = 'Please Login.'
      redirect_to '/'
    end
  end



  def layout?
    if current_admin
      return 'admin'
    end
    if current_parent
      return 'parent'
    end
  end

  def get_layout
    return "eduposts"
  end
  
  def home_layout
    return "home"
  end

  def get_school_layout
    if current_school_admin
      return "school"
    end
  end

end
