class Api::V1::FavouriteGatheringsController < ApiController
  before_action :authenticate!, only: [:index, :create, :destroy]

  def index
    @favouritable = current_user || current_volunteer

    @gatherings = @favouritable.favourites.with_attached_photos.with_attached_finished_photos

    render json: @gatherings
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
