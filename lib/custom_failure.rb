class CustomFailure < Devise::FailureApp
  def redirect_url
    root_path
  end
end
