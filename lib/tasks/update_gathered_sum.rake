require 'puppeteer-ruby'

namespace :update_gathered_sum do
  desc 'Update gathered sum of gatherings'
  task :all => :environment do
    # Initialize the browser
    browser = $browser

    # Get all unfinished gatherings
    gatherings = Gathering.where(ended: false)

    # Create an array to store the threads
    threads = []

    # Update the gathered_sum field for each gathering
    gatherings.each do | gathering |
      next if !gathering.is_monobank_link? || gathering.is_ended?

      # Check if gathering is ended by end date and update it if it is
      if gathering.end < Time.now
        gathering.update!(ended: true)
        next
      end

      # Create a new thread for each gathering
      threads << Thread.new(gathering) do | g |
        begin
          # Create a new page
          page = browser.new_page

          # Go to the gathering's link
          page.goto(g.link)

          # Wait for the .stats-data-value selector to appear on the page or timeout after 4 seconds
          page.wait_for_selector('.stats-data-value', timeout: 4000)

          # Get the gathered sum value
          gathered_sum = page.evaluate("document.querySelector('.stats-data-value').innerText")

          # Remove the spaces from the gathered sum value and convert it to a float
          gathered_sum = gathered_sum.gsub(' ', '').to_f

          # Update the gathering's gathered_sum field
          g.update!(gathered_sum: gathered_sum)

          # Close the page
          page.close if page
        rescue StandardError => e
          puts "Error updating gathering #{g.id}: #{e.message}"
        end
      end
    end

    # Wait for all threads to finish
    threads.each(&:join)

    # Close the browser
    browser.close
  end
end
