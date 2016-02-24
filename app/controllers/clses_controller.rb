class ClsesController < ApplicationController
  layout :get_school_layout
  autocomplete :subject, :subject_name
  
  def new
    @school = SchoolAdmin.find(params[:school_id])
    @class = Cls.new
    1.times {@class.subjects.build}
  end
  
  def create
    @school = SchoolAdmin.find(params[:school_id])
    @class = Cls.new(params[:cls])
    @class.school_admin_id = @school.id
    if @class.save
      flash[:notice] = "class is created"
      redirect_to school_path(@school)
    else
      flash[:error] = "Failed to Send Invitation"
      render :action => 'new'
    end
  end
  
  def edit
    @school = SchoolAdmin.find(params[:school_id])
    @class = Cls.find(params[:id])
    
  end
 
  def update
    @school = SchoolAdmin.find(params[:school_id])
    @class = Cls.find(params[:id])
    if  @class.update_attributes(params[:cls])
      redirect_to school_path(@school)
    else
      render 'edit'
    end
  end
 

  def index
    @school = SchoolAdmin.find(params[:school_id])
    @classes = Cls.where("school_admin_id = '#{current_school_admin.id}'").all
  end
  
  def cls_subjects
    @class = Cls.find(params[:clse_id])
    if !@class.blank?
      @subjects = @class.subjects.all
    end
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @class = Cls.find(params[:id])
    if @class.destroy
      flash[:notice] = "Successfully deleted this class"
      redirect_to  school_clses_path
    end
  end
 
  
end
