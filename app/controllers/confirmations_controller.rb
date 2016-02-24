class ConfirmationsController <  Devise::ConfirmationsController

  def show
    super
    p "**********************"
    p resource
    p "**********************"
     flash[:notice]="Thanks for your interest and some one will get in touch with you shortly to help you with the setup and payments." 
     sign_in(resource, bypass: true)
  end
end
