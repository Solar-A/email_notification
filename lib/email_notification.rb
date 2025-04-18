# frozen_string_literal: true

require_relative '../workers/email/sending_worker'
require 'sidekiq'

class EmailNotification
  class << self
    def add_email(email, locale = 'en')
      params = { email: email, locale: locale }
      send_notification_via_api('add_email', params)
    end

    def send_email(emails, subject:, body: '', variables: nil, template: nil, attachments: nil) # rubocop:disable Metrics/ParameterLists
      raise 'emails not specified' if emails.blank?

      params = { emails: emails, subject: subject, body: body, variables: variables, template: template,
                 attachments: attachments }
      send_notification_via_api('send', params)
    end

    def smtp_list_emails(limit: 0, offset: 0, from: '', to: '', sender: '', recipient: '') # rubocop:disable Metrics/ParameterLists
      params = { limit: limit, offset: offset, from: from, to: to, sender: sender, recipient: recipient }
      send_notification_via_api('list', params, async: false)
    end

    private

    def send_notification_via_api(action, params, async: true)
      worker = Email::SendingWorker
      async ? worker.perform_async(action, params.to_json) : worker.new.perform(action, params.to_json)
    end
  end
end
