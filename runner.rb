require_relative './lib/stat_tracker'
require_relative './lib/stat_tracker_initiator'

stat_tracker = StatTrackerInitiator.create

require 'pry'; binding.pry
