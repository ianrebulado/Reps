# frozen_string_literal: true
require 'faraday'

class NbaApi::V1::Client
  EXERCISE_API_BASE_URL = 'exercisedb.p.rapidapi.com'
  API_KEY = Rails.application.credentials.

  # def get_team(team_name)
  #   response = request(
  #     http_method: :get,
  #     endpoint: 'teams',
  #     params: { name: team_name }
  #   )

  #   if response[:status] == 200
  #     team_data = response[:body][:response].first
  #     team_info = {
  #       name: team_data[:name],
  #       code: team_data[:code],
  #       logo: team_data[:logo],
  #       conference: team_data[:leagues][:standard][:conference]
  #     }
  #   end
  #   team_info
  # end


  # def get_player(name)
  #   response = request(
  #     http_method: :get,
  #     endpoint: 'players',
  #     params: { name: }
  #   )

  #   if response[:status] == 200
  #     players = response[:body][:response]
  #     player_names = extract_player_names(players)

  #     puts "names #{player_names}"
  #   end
  #   puts "return names: #{player_names}"
  #   player_names
  # end

  # def live_games
  #   response = request(
  #     http_method: :get,
  #     endpoint: 'games',
  #     params: { date: date_today }
  #   )

  #   extract_live_game_info(response)
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
      Faraday.new(url: NBA_API_BASE_URL, **options) do |config|
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
