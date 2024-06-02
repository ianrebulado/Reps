# frozen_string_literal: true

require 'faraday'

class ExerciseApi::V1::Client
  EXERCISE_API_BASE_URL = 'https://exercisedb.p.rapidapi.com'
  API_KEY = Rails.application.credentials.exercise.api_key

  def get_exercise(name)
    response = request(
      http_method: :get,
      endpoint: "/exercises/name/#{name}",
      params: { name:,
                limit: 2 }
    )

    if response[:status] == 200
      exercises = response[:body]
      exercises.each do |exercise|
        puts "Exercise: #{exercise[:name]}, Body Part: #{exercise[:bodyPart]}"
      end
    else
      puts "Error: #{response[:status]}"
    end

  end

  # def get_body_part(body_part)
  #   response = request(
  #     http_method: :get,
  #     endpoint: "/exercises/bodyPart/#{body_part}",
  #     params: { body_part:,
  #               limit: 1 }
  #   )

  #   nil unless response[:status] == 200
  # end

  private

  def client
    @client ||= begin
      options = {
        request: {
          open_timeout: 10,
          read_timeout: 10
        }
      }
      Faraday.new(url: EXERCISE_API_BASE_URL, **options) do |config|
        config.headers['x-rapidapi-key'] = API_KEY
        config.request :json
        config.response :json, parser_options: { symbolize_names: true }
        config.response :raise_error
        config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug
      end
    end
  end

  def request(http_method:, endpoint:, params: {})
    response = client.public_send(http_method, endpoint, params)
    {
      status: response.status,
      body: response.body
    }
  rescue Faraday::Error => e
    raise Errors::ApiError.new(
      message: "API ERROR: #{e.message.capitalize}",
      faraday_error_class: e.class
    )
  end
end
