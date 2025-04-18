# frozen_string_literal: true

require 'sidekiq'

class Email
  class SendingWorker
    include Sidekiq::Worker

    sidekiq_options retry: false

    def perform(action, parmas)
      uri = URI.parse("#{ENV['EMAIL_NOTIFICATION_API_URL']}/#{action}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      parmas.merge!(source: ENV['EMAIL_NOTIFICATION_APP'])
      request = Net::HTTP::Post.new("#{uri.request_uri}?#{parmas.to_query}")
      response = http.request(request)
      JSON.parse(response.body)
    end
  end
end
