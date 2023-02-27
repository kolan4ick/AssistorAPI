class VolunteerMailer < ApplicationMailer
  def registration_email(volunteer)
    mail(from: "info@yuryshynets.me", to: volunteer.email, subject: "Успішна реєстрація волонтера в додатку Assistor").tap do |message|
      message.mailgun_options = {
        "tag" => ["abtest-option-a", "beta-user"],
        "tracking-opens" => true,
        "tracking-clicks" => "htmlonly"
      }
    end
  end

  def verification_email(volunteer)
    mail(from: "info@yuryshynets.me", to: volunteer.email, subject: "Статус волонтера було оновлено!").tap do |message|
      message.mailgun_options = {
        "tag" => ["abtest-option-a", "beta-user"],
        "tracking-opens" => true,
        "tracking-clicks" => "htmlonly"
      }
    end
  end
end
