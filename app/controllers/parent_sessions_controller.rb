class ParentSessionsController < Devise::SessionsController
 layout :layout?
  def new
  end

  def create
    resource = warden.authenticate!(:scope => resource_name)
    puts resource.errors.inspect
    flash[:notice] = "Successfully Login .."
    redirect_to  parent_dashboards_path
  end

  def destroy
    puts "dfgthfdghutrhghgbutghbtihbt"
    puts "delete not working"
    signed_in = signed_in?(resource_name)
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    flash[:notice] = "Logout Successfully"
    redirect_to "/"
  end
end


