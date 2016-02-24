class HomeController < ApplicationController
  layout :home_layout, only: ["index"]
  layout :get_school_layout, :only => ['school']

  def index
    if current_user
      redirect_to profiles_path(:school_name => current_user.school_admin.school)
    end
    @payment = Payment.new
    @payment1 = Payment.new
  end

  def new_user1
    @user = User.find(params[:id])
    sql_query = "select * from tweets a where (id in (select max(id) from tweets b where a.user_id = b.user_id )) order by a.created_at desc"
    @posts = Tweet.paginate_by_sql [sql_query], :per_page => 10, :page => params[:page]
    render :layout => false
  end

  def new_user2
    @user = User.find(params[:id])
    sql_query = "select * from tweets a where (id in (select max(id) from tweets b where a.user_id = b.user_id )) order by a.created_at desc"
    @posts = Tweet.paginate_by_sql [sql_query], :per_page => 10, :page => params[:page]
    render :layout => false
  end

  def update_new_user2
    @user = User.find(params[:id])
    sql_query = "select * from tweets a where (id in (select max(id) from tweets b where a.user_id = b.user_id )) order by a.created_at desc"
    @posts = Tweet.paginate_by_sql [sql_query], :per_page => 10, :page => params[:page]
    if @user.update_attributes(params[:user])
      redirect_to profiles_path(:school_name => current_user.school_admin.school)
    else
      flash[:error] = "Failed to Update your Profile details."
      render :action => 'new_user2', :layout => false
    end

  end

  def enquiry
    @student = StudentInformation.new
    render :layout => false
  end

  def student_enquiry
    @student = StudentInformation.new(params[:student_information])
    if @student.save
      UserMailer.send_notification(@student).deliver
      redirect_to '/'
    else
      render :action => 'enquiry', :layout => false
    end
  end

  def school_login

  end

  def about
  end

  def terms_of_service
    
  end

  def privacy_policy
    
  end

  def contact
    @contact = Contact.new
  end

  def post_contact
    @contact = Contact.new(params[:contact])
    if @contact.save
      flash[:notice] = "Successfully send the contact information"
      UserMailer.contact(@contact).deliver
      redirect_to contact_home_index_path
    else
      flash[:error] = "Fail to send the contact information"
      render :action => 'contact'
    end
  end
  
  def contact_us
    params[:captcha_error] = "Captcha is invalid." unless params[:captcha] == "4"
    params[:name_error] = "Name can't be blank." if params[:name].to_s.blank?
    params[:email_error] = "Email can't be blank" if params[:email].to_s.blank?
    params[:message_error] = "Message can't be blank." if params[:message].to_s.blank?
    
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    if params[:captcha] == "4" and !params[:name].to_s.blank? and !params[:email].to_s.blank? and !params[:message].to_s.blank?
      UserMailer.contact_us(@name,@email,@message).deliver
    end
    render
  end

  def post_ind_payment
    token = Devise.friendly_token
    @payment = Payment.new(params[:payment].merge(merchant_order_id: token, user_type: params[:user_type]))
    @payment.save
    respond_to do |format|
      format.js
    end
  end

  def post_institute_payment
    token = Devise.friendly_token
    @payment1 = Payment.new(params[:payment].merge(merchant_order_id: token, user_type: params[:user_type]))
    @payment1.save
    respond_to do |format|
      format.js
    end
  end

  def checkout
    payment
    render :layout => false
  end

  def return
        @notification = Twocheckout::ValidateResponse.purchase({:sid => SID, :secret => SECRET, :order_number => params['order_number'], :total => params['total'], :key => params['key']})
        @payment = Payment.where("merchant_order_id=?", params[:merchant_order_id]).first
        p "******************************"
        p @notification[:code]
        p "*****************************"
        begin
          if @notification[:code] == "PASS"
            @payment.first_name = params['first_name'] 
            @payment.last_name = params['last_name']
            @payment.card_holder_name = params['card_holder_name'],
            @payment.email =  params['email']
            @payment.zipcode = params['state']
            @payment.state = params['state']
            @payment.street_address = params['street_address']
            @payment.city = params['city']
            @payment.country = params['country']
            @payment.status = 'Success'
            @payment.purchased_at = Time.now
            @payment.net_payment = params['total'],
            @payment.order_number = params['order_number']
            
            flash[:notice] = "Your payment is successfully placed"
            redirect_to root_url
          else
            @payment.status = "Failed"
            flash[:notice] = "Error validating payment, please contact us for assistance."
            redirect_to root_url
          end
          ensure
          @payment.save
        end
      end

      private

      def payment
        @payment = Payment.where("merchant_order_id=?", params[:id]).first
      end
end