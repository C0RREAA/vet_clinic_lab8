class VetsController < ApplicationController
  def index
    @vets = Vet.all
  end

  def show
    @vet = Vet.includes(appointments: :pet).find(params[:id])
    @upcoming = @vet.appointments.upcoming
    @past      = @vet.appointments.past
  end
end