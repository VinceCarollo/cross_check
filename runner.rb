require_relative './stat_tracker'
require_relative './stat_tracker_initiator'

stat_tracker = StatTrackerInitiator.create

require 'pry'; binding.pry
