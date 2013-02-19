class UserController < ApplicationController
  # This function checks the user/password in the database.
  # On success, the function updates the count of logins in the database.
  # On success, the result is the number of logins including this one (>=1)
  # On failure, the result is an error code (<0): ERR_BAD_CREDENTIALS
  def login
    @user = User.find_by_username(params[:user])
    respond_to do |f|
      if @user and @user[:password] == params[:password]
        # Successfully found a match in DB
        @user[:count] += 1
        @user.save
        output = { :errCode => 1, :count => @user[:count] }
      else
        # Cannot find a matching username-password in DB
        output = { :errCode => -1 }
      end
      f.json { render :json => output }
    end
  end

  # This function checks that the user does not exists:
  ## The user name is not empty.
  ## The password may be empty.
  # On success, the function adds a row to the DB, with the count = 1.
  # On success, the result is the count of logins (>=1).
  # On failure, the result is an error code (<0):
  ## ERR_BAD_USERNAME (-2)
  ## ERR_BAD_PASSWORD (-4)
  ## ERR_USER_EXISTS (-3)
  # If multiple error conditions apply, return any applicable error code
  def add
    @user = User.new(:username => params[:user], :password => params[:password])
    respond_to do |f|
      @user[:count] = 1
      if @user.save
        # Successfully added to DB
        output = { :errCode => 1, :count => @user[:count] }
      else
        # Failed, need to figure out error code
        error = @user.errors.full_messages[0]
        if error.include? "taken"
          output = { :errCode => -2 }
        elsif error.include? "Password"
          output = { :errCode => -4 }
        else
          output = { :errCode => -3 }
        end
      end
      f.json { render :json => output }
    end
  end
end
