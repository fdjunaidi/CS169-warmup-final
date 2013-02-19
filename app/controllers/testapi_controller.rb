class TestapiController < ApplicationController
  # Used only for testing
  # Should clear the database of all rows
  # Always return success: errCode = 1
  def resetFixture
    User.destroy_all
    respond_to do |f|
      output = { :errCode => 1 }
      f.json { render :json => output }
    end
  end

  # Used only for testing
  # Should run all of the unit tests
  # Report the results from the unit tests
  # Output any error messages produced
  def unitTests
    out = []
    test = 0
    fail = 0
    system("rspec ./spec/models/user_spec.rb > ./output.txt")
    IO.foreach('./output.txt') do |l|
      line = l.split(' ')
      firstWord = line[0]
      lastWord = line[line.length-1]
      if firstWord == "rspec"
        errorLine = l.split('#')
        out.push(errorLine[1])
      elsif lastWord == "failure" or lastWord == "failures"
        test = line[0].to_i
        fail = line[2].to_i
      end
    end
    out = out.join(',')
    respond_to do |f|
      outputMsg = { :totalTests => test, :nrFailed => fail, :output => out }
      f.json { render :json => outputMsg }
    end
  end
end
