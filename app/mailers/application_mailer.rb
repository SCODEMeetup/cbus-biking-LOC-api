# frozen_string_literal: true

# all application Mailers intherit from this
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
