class SchoolsController < ApplicationController
  before_filter :is_school?, :except => ['show','edit', 'update', 'destroy']
  layout :get_school_layout, :except => ['edit', 'update' 'destroy']
  def show
    @school = current_school_admin
    p "DFDSFDSFDSFDSFDSFDS"
    p @school
    p "DSFDSFSDFDSFDSFFSDFDSF"
    @students = User.where("school_admin_id = #{@school.id} AND role = 'student'")
    @teachers = User.where("school_admin_id = #{@school.id} AND role = 'teacher'")
    @classes = Cls.where("school_admin_id = #{@school.id}")
    @parents = Parent.where("school_admin_id = #{@school.id}")
    @assign_class = Teacherclass.new

  end

  def edit
    @school = SchoolAdmin.find(params[:id])
    if @school.reset_password_token != params[:reset_password_token]
      render :text => 'Invalid Token.',:layout => false
    end
  end

  def update
    @school = SchoolAdmin.find(params[:id])
    if @school.update_attributes(params[:school_admin])
      @school.update_attribute(:reset_password_token,nil)
      sign_in(@school)
      redirect_to school_path(@school)
    else
      flash.now[:error] = "Loggened in failed."
      render :action => 'edit'
    end
  end

  def destroy
    @school = SchoolAdmin.find(params[:id])
    if @school.destroy
      #render :update do |page|
        flash[:notice] = "Successfully deleted this school."
      #  page.reload
redirect_to admin_dashboards_path
    #  end
    end
  end
end
