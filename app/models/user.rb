class User < ActiveRecord::Base
  
  
  #If user exists, return the login count, else return zero
  def self.getCount(user, password)
    user_data = User.find_by_user_and_password(user, password)
    if user_data
      return user_data.count
    else
      return 0
    end
  end

  #checks if user and password are well formed.
  #returns the corresponding error code, 1 if well formed
  def self.check_cred_format(user, password)
    errCode = 1
    if user.length < 1 or user.length > 128
      errCode = -3
    elsif password.length > 128
      errCode = -4
    end
    return errCode
  end
  #Checks if credentials are valid.
  #if so, increments login counter
  #returns appropriate error code (1 if logged in correctly)
  def self.login(user, password)
    errCode = 1
    count = User.getCount(user, password) #if this is 0, credentials are not valid
    if count == 0
      errCode = -1
    else 
      user_data = User.find_by_user_and_password(user, password)
      user_data.count += 1
      user_data.save
    end
    return errCode
  end
  
  #adds a user to the database, returns false if user already exists.
  def self.addUser(user, password)
    user_data = User.find_by_user(user)
    if user_data
      return false
    end
    newUser = User.new()
    newUser.user = user
    newUser.password = password
    newUser.count = 1
    newUser.save
    return true
  end

  def self.resetFixture()
    User.destroy_all()
  end
      
end
