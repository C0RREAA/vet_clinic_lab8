class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.includes(:pet, :vet).all
  end

  def show
    @appointment = Appointment.includes(:pet, :vet, :treatments).find(params[:id])
  end
end