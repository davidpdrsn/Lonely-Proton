def http_login
  username = ENV['admin_username']
  password = ENV['admin_password']
  request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic
    .encode_credentials(username, password)
end

def authenticate
  username = ENV['admin_username']
  password = ENV['admin_password']
  basic = ActionController::HttpAuthentication::Basic
  credentials = basic.encode_credentials(username, password)

  page.driver.header 'Authorization', credentials
end
