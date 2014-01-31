class V1::AppointmentsController < V1::BaseController


  def resource_class
    Appointment
  end

  protected

  def find
    @search = resource_class.where(first_name: params[:first_name]) if params[:first_name]
    @search = resource_class.where(last_name: params[:last_name]) if params[:last_name]
    @search ? @search.all : super
  end

  def resource_params
    params.require(:appointment).permit(:first_name, :last_name, :end_time, :start_time, :comments)
  end


end