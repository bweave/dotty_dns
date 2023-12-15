require "minitest/mock"

module MockTestHelp
  def assert_called(klass, method_name, return_value, args = [], **kwargs, &)
    mock = Minitest::Mock.new

    mock.expect(:call, return_value, args, **kwargs)
    klass.stub(method_name, mock, &)

    mock.verify
  end
end
