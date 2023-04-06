class Api::V1::VolunteersController < ApiController
  before_action :authenticate!
  before_action :set_authenticatable

  def index
    @page = (params[:page] || 1).to_i

    volunteers = Volunteer.offset(($per_page * @page) - $per_page).limit($per_page)
    
    render json: volunteers, status: 200, each_serializer: VolunteerSerializer, scope: @authenticatable
  end

  def show
    volunteer = Volunteer.find(params[:id])
    render json: volunteer, status: 200, serializer: VolunteerSerializer, scope: @authenticatable
  end

  protected

  def set_authenticatable
    @authenticatable = current_user || current_volunteer
  end
end
