require 'puppeteer-ruby'

namespace :update_gathered_sum do
  desc 'Update gathered sum of gatherings'
  task :all => :environment do
    # Initialize the browser
    browser = Puppeteer.launch(headless: true)

    # Get all unfinished gatherings
    gatherings = Gathering.where(ended: false)

    # Update the gathered_sum field for each gathering
    gatherings.each do | gathering |
      next if gathering.is_monobank_link?

      Thread.new do
        # Create a new page
        page = browser.new_page

        # Go to the gathering's link
        page.goto(gathering.link)

        # Wait for the .stats-data-value selector to appear
        page.wait_for_selector('.stats-data-value')

        # Get the gathered sum value
        gathered_sum = page.evaluate("document.querySelector('.stats-data-value').innerText")

        # Remove the spaces from the gathered sum value and convert it to a float
        gathered_sum = gathered_sum.gsub(' ', '').to_f

        # Update the gathering's gathered_sum field
        gathering.update(gathered_sum: gathered_sum)

        # Close the page
        page.close
      end
    end

    # Wait for all threads to finish
    Thread.list.each { | t | t.join unless t == Thread.current }

    # Close the browser
    browser.close
  end
end
