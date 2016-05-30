require "segment/analytics"

Analytics = Segment::Analytics.new({
  write_key: Rails.application.secrets.segment_key,
  on_error: Proc.new { |_, msg| print msg },
  stub: Rails.env.test?
})
