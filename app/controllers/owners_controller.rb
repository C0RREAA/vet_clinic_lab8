class OwnersController < ApplicationController
  def index
    @owners = Owner.includes(:pets).all
  end

  def show
    @owner = Owner.includes(pets: :appointments).find(params[:id])
  end
end