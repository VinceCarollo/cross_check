require './lib/stat_tracker'
require './lib/stat_tracker_dummy_initiator'

stat_tracker = StatTrackerDummyInitiator.create

require 'pry'; binding.pry
