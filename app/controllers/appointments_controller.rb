class AppointmentsController < ApplicationController
  STATUSES = { 0 => "Scheduled", 1 => "In Progress", 2 => "Completed", 3 => "Cancelled" }

  def index
    @appointments = Appointment.all
  end

  def show
    @appointment = Appointment.find(params[:id])
  end
end