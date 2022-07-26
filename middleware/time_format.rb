require_relative '../lib/time_helper'

class TimeFormat
  REQUEST_PATCH = '/time'
  REQUEST_METHOD = 'GET'
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    @request = Rack::Request.new(env)

    if request_valid?
      handler_request
    else
      [404, {}, ["Not Found\n"]]
    end
  end

  private

  def handler_request
    formats = @request.params['format']
    return [400, {}, ["Not format\n"]] if formats.nil?
    response = TimeHelper.new(formats)
    response.call
    if response.valid?
      [200, {}, ["#{response.result}\n"]]
    else
      [400, {}, ["Unknown time format #{response.unknown}\n"]]
    end
  end

  def request_valid?
    @request.path == REQUEST_PATCH && @request.request_method == REQUEST_METHOD
  end
end
