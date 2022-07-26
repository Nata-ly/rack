class TimeHelper
  attr_reader :unknown

  TIME_FORMAT = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: 'k',
    minute: '%M',
    second: '%S' }

  def initialize(formats)
    @unknown = []
    @known = []
    @formats = formats
  end

  def call
    @formats.downcase.split(',').each do |format|
      TIME_FORMAT.include?(format.to_sym) ? @known << TIME_FORMAT[format.to_sym] : @unknown << format
    end
  end

  def result
    Time.now.strftime(@known.join('-'))
  end

  def valid?
    @unknown.empty?
  end
end
