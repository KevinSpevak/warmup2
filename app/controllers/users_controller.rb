class UsersController < ApplicationController
  def login
    user = request[:user]
    pswd = request[:password]
    errCode = User.check_cred_format(user, pswd)
    if errCode == 1
      errCode = User.login(user, pswd)
    end
    count = User.getCount(user, pswd)
    render json: {:errCode => errCode, :count => count}, :status => 200
  end
  
  def add
    user = request[:user]
    pswd = request[:password]
    errCode = User.check_cred_format(user, pswd)
    count = 0
    if errCode == 1
      success = User.addUser(user, pswd)
      if success
        count = User.getCount(user, pswd)
      else
        errCode = -2
      end
    end
    render json: {:errCode => errCode, :count => count}, status => 200
  end
end
