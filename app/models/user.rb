class User < ActiveRecord::Base
  attr_accessible :count, :password, :username
  
  # Invalid password, errCode = -4
  validates :password, :length => { :maximum => 128 }
  
  # Invalid username, errCode = -3
  # Username exists, errCode = -2
  validates :username, :presence => true,
                       :length => { :maximum => 128 },
                       :uniqueness => true
end
