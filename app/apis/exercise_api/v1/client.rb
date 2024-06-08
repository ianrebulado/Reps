# frozen_string_literal: true

require 'faraday'

class ExerciseApi::V1::Client
  EXERCISE_API_BASE_URL = 'https://exercisedb.p.rapidapi.com'
  API_KEY = Rails.application.credentials.exercise.api_key

# EXERCISE NAME
  def get_exercise(name)
    response = request(
      http_method: :get,
      endpoint: "/exercises/name/#{name}",
      params: { name:,
                limit: 12 }
    )

    if response[:status] == 200
      response[:body]
    else
      puts "Error: #{response[:status]}"
    end
  end

  # EXERCISES PER PART
  def get_exercises(body_part)
    response = request(
      http_method: :get,
      endpoint: "/exercises/bodyPart/#{body_part}",
      params: { body_part:,
                limit: 12 }
    )

    if response[:status] == 200
      response[:body]
    else
      puts "Error: #{response[:status]}"
    end
  end

  # BODY PART LIST
  def get_body_parts
    response = request(
      http_method: :get,
      endpoint: '/exercises/bodyPartList'
    )

    if response[:status] == 200
      response[:body]
    else
      puts "Error: #{response[:status]}"
    end
  end

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
