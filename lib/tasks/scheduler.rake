namespace :scheduler do

  desc "Run by Heroku Scheduler. Checks for overdue tasks and charges the user."
  task process_pledges: :environment do
    p "Processing all pledges..."
    Pledge.process_all
    p "Done!"
  end

end
