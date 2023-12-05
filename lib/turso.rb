require "uri"
require "json"
require "net/http"

class Turso
  def initialize(base_url, token)
    @uri = URI(base_url)
    @token = token
  end

  def execute(statements)
    statements = prepare_statements(statements)

    https = Net::HTTP.new(@uri.host, @uri.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(@uri)
    request["Authorization"] = "Bearer #{@token}"
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({ "statements": statements })

    begin
      response = https.request(request)
      handle_response(response)
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end

  private

  def prepare_statements(statements)
    statements = [statements] if statements.is_a?(String)

    statements.map do |statement|
      statement.is_a?(String) ? { q: statement } : statement
    end
  end

  def handle_response(response)
    case response
    when Net::HTTPSuccess
      JSON.parse(response.body)
    else
      { "error" => "Something went wrong: #{response.code}" }
    end
  end
end