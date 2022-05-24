class CustomAuthenticationFailure < Devise::FailureApp
  def redirect_url
    welcome_path
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
