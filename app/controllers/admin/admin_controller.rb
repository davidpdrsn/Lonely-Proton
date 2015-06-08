module Admin
  class AdminController < ApplicationController
    USERNAME = ENV.fetch("admin_username")
    PASSWORD = ENV.fetch("admin_password")

    http_basic_authenticate_with name: USERNAME, password: PASSWORD
  end
end
