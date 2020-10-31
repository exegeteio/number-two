# Omniauth callbacks controller.
class CallbacksController < Devise::OmniauthCallbacksController
  def twitch
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.save!
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      cookies.encrypted['username'] = @user.username
      session['devise.twitch_data'] = request.env['omniauth.auth'].except(:extra)
      set_flash_message(:notice, :success, kind: 'Twitch') if is_navigational_format?
    end
  end

  def failure
    redirect_to root_path
  end
end
