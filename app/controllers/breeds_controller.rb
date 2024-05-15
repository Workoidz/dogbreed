class BreedsController < ApplicationController
  require 'net/http'

  def index
  end

  def fetch_breed
    breed = params[:breed].downcase
    url = URI("https://dog.ceo/api/breed/#{breed}/images/random")
    response = Net::HTTP.get(url)
    result = JSON.parse(response)

    if result['status'] == 'success'
      @breed_name = breed.capitalize
      @image_url = result['message']
    else
      @error = "Breed not found"
    end

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('breed_info', partial: 'breed_result', locals: { image_url: @image_url, breed_name: @breed_name }) }
    #  format.turbo_stream
    #  format.html { render partial: 'breed_result', status: :unprocessable_entity }
    end
  end
end
