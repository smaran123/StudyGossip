class SessionsController < Devise::SessionsController

  def new
    @users = User.all
    puts "sessions new"
  end

  def create
  #  if resource_or_scope.is_a?(User)
  puts "fusifhsudfbs"
      @user = User.find_by_email_and_role(params[:user][:email],params[:user][:role])
      respond_to do |format|
        format.js
      end
#     else
#       @parent = Parent.find_by_email(params[:parent][:email])
# p "SDSFSDFDSFDSFDSFDSFDSF"

#     end
  end

end
