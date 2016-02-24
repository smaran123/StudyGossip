WebApp::Application.routes.draw do

 

  devise_for :parents,:controllers => {:sessions => 'parent_sessions', :passwords => 'parent_passwords'}
  devise_scope :parent do
 #   get "parent_login",:to => "parent_sessions#new" ,:as => "parent_login"
   get "parent_sign_out", :to => "parent_sessions#destroy",:as => "parent_sign_out"

  end

  devise_for :school_admins,:controllers => {:sessions => 'school_sessions', :passwords => 'school_passwords'}

  devise_for :users,:controllers => {:sessions => 'sessions', :passwords => 'passwords'}
  devise_scope :user do
    get "sign_out", :to => "devise/sessions#destroy",:as => "logout"
  end

  devise_for :admins,:controllers => {:sessions => "admin/sessions",:passwords => "admin/passwords"}
  devise_scope :admin do
    get "admin_login",:to => "admin/sessions#new" ,:as => "admin_login"
    get "admin_sign_out", :to => "admin/sessions#destroy",:as => "admin_logout"
  end
namespace :parent do
  resources :dashboards
end
  namespace :admin do
    resources :dashboards
    resources :schools
    resources :students do
      member do
        get :followers
        get :following
      end
    end
  end

  resources :students do
    collection do
      put :username
    end
  end
 
  resources :teachers do
    get :assign_subject
  end

  resources :classes,:path => "/:school_name/classes/" do
    resources :markreports do
      collection do
        get :student_subject_marks
      end
    end 
    resources :attendences
    resources :teachertweets do
      collection do
        get :student_subject_posts
      end
    end
    member do
      get :roster
      get :invite_students
      post :create_invited_students
      get :graphs
      get :student_subject_show
      get :students_show
    end
    collection do
      put :switch_theme
    end
    resources :faqs do
      collection do
        get :faqs
        get :student_subject_faqs
      end
    end
    resources :readings do
      collection do
        get :readings
        get :student_subject_readings
      end
    end
    resources :importent_links do
      collection do
        post :upload_doc
        get :links
        get :student_subject_links
      end
    end
  end
  resources :notifications,:path => "/:school_name/notifications/" do
    member do
      get :announcements
    end
  end

  resources :schools do
     resources :parents
    resources :clses do
      get :cls_subjects
      collection do
        get :autocomplete_subject_subject_name
      end
    end
    resources :students do
      member do
        get :followers
        get :following
        get :posts
        get :display_class
      end
    end
    resources :teachers do
      member do
        get :assign_class
        post :assign_teachercls
      end
    end
    resources :upload_csvs do
      collection do
        post :student_upload_csv
        post :teacher_upload_csv
      end
    end
  end

  resources :profiles,:path => "/:school_name/profiles/" do
    member do
      get :conversation
      get :profile_summary
      get :more_profile_information
      post :conversation_message
      get :report
      post :report_post
      get :post
      post :create_post
      get :favorites
    end
    collection do
      get :search
      get :edit_password
      put :update_password
      post :compose_message
      get :new_compose
      post :new_compose_message
      put :switch_theme
    end
  end

  resources :users do
    resources :posts do
      collection do
        post :favourite
        put :update_favourite
        put :update_mark_favourite
      end

      member do
        post :repost
        get :reply
        post :reply_post
      end
    end
    resources :follows do
      member do
        post :follow
        put :unfollow
        put :update_follow
      end
    end
  end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  get '/enquiry' => "home#enquiry", :as => :enquiry
  post '/student_enquiry' => "home#student_enquiry", :as => :student_enquiry
  root :to => 'home#index'
  resources :home do
    member do
      get :new_user1
      get :new_user2
      put :update_new_user2
      get :checkout
    end
    collection do
      get :school_login
      get :about
      get :contact
      post :post_contact
      get :terms_of_service
      get :privacy_policy
      post :contact_us
      post :post_ind_payment
      post :post_institute_payment
    end
  end

  match '/return'=>'home#return'
end