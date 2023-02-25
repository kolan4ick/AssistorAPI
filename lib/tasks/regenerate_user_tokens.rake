namespace :regenerate_tokens do
  desc 'Regenerate user tokens'
  task :all => :environment do
    User.all.each do |user|
      if user.expired_authentication_token?
        user.renew_authentication_token!
      end
    end

    Volunteer.all.each do |volunteer|
      if volunteer.expired_authentication_token?
        volunteer.renew_authentication_token!
      end
    end
  end
end
