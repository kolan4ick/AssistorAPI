every 2.weeks do
  rake "regenerate_tokens:all"
end

every 1.minute do
  rake 'update_gathered_sum:all'
end