class BreedsController < ApplicationController
  require 'net/http'

  def index
    # This action can be used to render a form for breed input or a list of breeds.
  end

  def fetch_breed
    breed = params[:breed].downcase
    url = URI("https://dog.ceo/api/breed/#{breed}/images/random")

    begin
      response = Net::HTTP.get(url)
      result = JSON.parse(response)

      if result['status'] == 'success'
        @breed_name = breed.capitalize
        @image_url = result['message']
      else
        @error = "Breed not found"
      end
    rescue JSON::ParserError => e
      @error = "Error parsing the response"
      Rails.logger.error("JSON::ParserError: #{e.message}")
    rescue StandardError => e
      @error = "An error occurred: #{e.message}"
      Rails.logger.error("StandardError: #{e.message}")
    end

    respond_to do |format|
      if @error
        format.turbo_stream { render turbo_stream: turbo_stream.replace('breed_info', partial: 'breed_result', locals: { error: @error }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('breed_info', partial: 'breed_result', locals: { image_url: @image_url, breed_name: @breed_name, error: @error }) }
      end
    end
  end
end
