class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def trello
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.save unless @user.persisted?

    sign_in_and_redirect @user
    #set_flash_message(:notice, :success, :kind => "Trello") if is_navigational_format?
  end
end
