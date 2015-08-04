class AstronautsController < ApplicationController

  def update
    astronaut = Astronaut.find_by(:id => params["id"])
    astronaut.name = params[:name]
    astronaut.save
    redirect_to root_url
  end

  def edit
    @astronaut = Astronaut.find_by(:id => params["id"])
  end

  def index
  	@astronauts = Astronaut.all
  end

  def new
  	@astronaut = Astronaut.new
  end

  def create
    @astronaut = Astronaut.new
    @astronaut.name = params["name"]
    if @astronaut.save
      redirect_to root_url # "/"
    else
      render 'new'
    end
  end

  def destroy
    @astronaut = Astronaut.find_by(:id => params["id"])
    @astronaut.delete
    redirect_to "/astronauts"
  end

  def show
    @astronaut = Astronaut.find_by(:id => params["id"])
    # @astronaut.download_details
  end

end
