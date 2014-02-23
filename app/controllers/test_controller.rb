class TestController < ApplicationController
  def reset
    User.resetFixture()
    render json: {:errCode => 1}, :status => 200
  end

  def unit_tests
    output = `rspec`
    numbers = output.match(/^\d* examples, \d* failures$/)[0].to_s
    num_examples = numbers.match(/^\d*/)[0].to_i
    num_failed = numbers.match(/\d* f/)[0].match(/\d*/)[0].to_i
    render json: {:nrFailed => num_failed, :output => output,
      :totalTests => num_examples}, :status => 200
  end
end
