desc "Task collecting statistics for boards"
task :collect_stats => :environment do
  puts "Collecting statistics..."
  StatisticsCollector.collect_for_all
  puts "done."
end
