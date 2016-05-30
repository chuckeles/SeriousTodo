require "segment/analytics"

Analytics = Segment::Analytics.new({
  write_key: Rails.application.secrets.segment_key
})
