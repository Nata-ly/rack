require_relative 'app'
require_relative 'middleware/time_format'

use TimeFormat
run App.new
