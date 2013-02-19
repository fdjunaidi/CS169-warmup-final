require 'spec_helper'

describe TestapiController do

  describe "GET 'resetFixture'" do
    it "returns http success" do
      get 'resetFixture'
      response.should be_success
    end
  end

  describe "GET 'unitTests'" do
    it "returns http success" do
      get 'unitTests'
      response.should be_success
    end
  end

end
