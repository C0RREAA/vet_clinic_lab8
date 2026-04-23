class PetsController < ApplicationController
  def index
    @pets = Pet.includes(:owner).all
  end

  def show
    @pet = Pet.includes(:owner, appointments: :vet).find(params[:id])
  end
end