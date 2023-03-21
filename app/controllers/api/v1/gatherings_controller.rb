class Api::V1::GatheringsController < ApiController
  include GatheringHelper

  before_action :authenticate!, only: [:index, :show, :filter_gatherings, :create_view, :viewed]
  before_action :set_gathering, only: [:show, :update, :destroy]
  before_action :authenticate_volunteer!, only: [:create, :update, :destroy]

  # GET /gatherings
  def index
    @gatherings = Gathering.all

    @favouritable = current_user || current_volunteer

    render json: @gatherings, each_serializer: GatheringSerializer, scope: @favouritable
  end

  def show
    render json: @gathering
  end

  # POST /gatherings
  def create
    @gathering = Gathering.new(gathering_params)

    if @gathering.save
      render json: @gathering, status: :created, location: @gathering
    else
      render json: @gathering.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gatherings/1
  def update
    if @gathering.update(gathering_params)
      render json: @gathering
    else
      render json: @gathering.errors, status: :unprocessable_entity
    end
  end

  # DELETE /gatherings/1
  def destroy
    @gathering.destroy
  end

  def filter_gatherings
    @gatherings = Gathering.all

    @filtered_gatherings = filtering(@gatherings)

    @filtered_gatherings = sorting(@filtered_gatherings)

    render json: @filtered_gatherings
  end

  def create_view
    @gathering = Gathering.find(params[:gathering_id])

    @viewer = current_user || current_volunteer

    unless @viewer.viewed_gatherings.include?(@gathering)
      @viewer.viewed_gatherings << @gathering
      render json: { message: "Перегляд створено" }, status: :created
      return
    end

    render json: { message: "Збір уже переглянуто" }, status: 200
  end

  def viewed
    if current_user
      @gatherings = current_user.viewed_gatherings.with_attached_photos.with_attached_finished_photos
    elsif current_volunteer
      @gatherings = current_volunteer.viewed_gatherings.with_attached_photos.with_attached_finished_photos
    else
      render json: { error: "Ви не авторизовані" }, status: 401
      return
    end

    @favouritable = current_user || current_volunteer

    render json: @gatherings, each_serializer: GatheringSerializer, scope: @favouritable
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gathering
    @gathering = Gathering.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def gathering_params
    params.require(:gathering).permit(:title, :description, :sum, :start, :end, :ended, :link, :volunteer_id, :gathering_category_id)
  end
end