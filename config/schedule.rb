
every 1.day do
  runner "DailyDigestJob.perform_later"
end

every 1.hour do
  rake 'ts:index'
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


