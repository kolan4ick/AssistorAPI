class Api::V1::VolunteersController < ApiController
  before_action :authenticate!

  def index
    @authenticatable = current_user || current_volunteer

    volunteers = Volunteer.all
    render json: volunteers, status: 200, each_serializer: VolunteerSerializer, scope: @authenticatable
  end
end
