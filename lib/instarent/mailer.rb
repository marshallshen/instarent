require 'mail'
module Instarent
  class Mailer
    def initialize
      options = { :address              => "smtp.gmail.com",
                  :port                 => 587,
                  :domain               => 'mail.google.com',
                  :user_name            => 'TryRentSmart',
                  :password             => 'password',
                  :authentication       => 'plain',
                  :enable_starttls_auto => true  }

      Mail.defaults do
          delivery_method :smtp, options
      end
    end

    def notify(apartment_results, receipt)
      body = <<-MAIL
      Yo, you might find these apartment deals interesting...
         #{formatted_results(apartment_results)}

      Best,
      Marshall Shen,
      From Instarent
      MAIL

      Mail.deliver do
        to receipt
        from "tryrentsmart@gmail.com"
        subject "[#{Time.now.strftime('%e %B, %Y')}] Apartment to rent.."
        body body
      end
    end

    private
    def formatted_results(apartment_results)
      apartment_results.reduce("\n ") do |formatted_result, (neighborhood, urls_of_apts)|
        formatted_result += "#{neighborhood}: \n\n"
        urls_of_apts.each do |urls_per_apt|
          formatted_result += "Craiglist url: #{urls_per_apt.first}\n"
          formatted_result += "See it on Google map: #{urls_per_apt.last} \n"
          formatted_result += "-----\n\n"
        end
        formatted_result
      end
    end
  end
end

