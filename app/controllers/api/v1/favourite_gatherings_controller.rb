class Api::V1::FavouriteGatheringsController < ApiController
  before_action :authenticate!, only: [:index, :create, :destroy]

  def index
    @page = (params[:page] || 1).to_i

    @favouritable = current_user || current_volunteer

    @gatherings = @favouritable.favourites.offset(($per_page * @page) - $per_page).limit($per_page)

    render json: @gatherings, each_serializer: GatheringSerializer, scope: @favouritable
  end

  def create
    @gathering = Gathering.find(params[:gathering_id])

    @favouritable = current_user || current_volunteer

    unless @favouritable.favourites.include?(@gathering)
      @favouritable.favourites << @gathering
      render json: { message: "Збережено в обране" }, status: :created
      return
    end

    render json: { message: "Збір вже збережено в обране" }, status: 400
  end

  def destroy
    @gathering = Gathering.find(params[:gathering_id])

    @favouritable = current_user || current_volunteer

    if @favouritable.favourites.include?(@gathering)
      @favouritable.favourites.delete(@gathering)
      render json: { message: "Видалено з обраного" }, status: 200
      return
    end

    render json: { message: "Збір не збережено в обраному" }, status: 400
  end
end
