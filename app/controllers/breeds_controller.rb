class BreedsController < ApplicationController
  def index
    
  end

  def fetch_breed
    if request.post?
      @breed = params[:breed]
      # Handle the form submission, e.g., save the breed or process it as needed
      p "Breed submitted successfully: #{@breed}"
      #redirect_to root_path
    end
  end

end
