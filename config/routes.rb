CS169WarmupFinal::Application.routes.draw do
  #get "user/login"
  match "/users/login", :controller => "user", :action => "login", :format => 'json'

  #get "user/add"
  match "/users/add", :controller => "user", :action => "add", :format => 'json'

  #get "testapi/resetFixture"
  match "/TESTAPI/resetFixture", :controller => 'testapi', :action => 'resetFixture', :format => 'json'

  #get "testapi/unitTests"
  match "/TESTAPI/unitTests", :controller => 'testapi', :action => 'unitTests', :format => 'json'
  
end
