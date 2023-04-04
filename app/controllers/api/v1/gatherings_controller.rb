class Api::V1::GatheringsController < ApiController
  include GatheringHelper

  before_action :authenticate!, only: [:index, :show, :filter_gatherings, :create_view, :viewed, :created_by_volunteer]
  before_action :set_gathering, only: [:show, :update, :destroy]
  before_action :volunteer_authenticate!, only: [:create, :update, :destroy]
  before_action :check_volunteer!, only: [:update, :destroy]

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
    # If volunteer is not verified, return error
    if current_volunteer.verification == false
      render json: { error: "Ваш аккаунт не верифіковано" }, status: 401
      return
    end

    @gathering = Gathering.new(gathering_params)

    # set creator to current volunteer
    @gathering.creator = current_volunteer

    if @gathering.save
      render json: @gathering, status: :created, each_serializer: GatheringSerializer, scope: current_volunteer
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

  def created_by_volunteer
    @volunteer = Volunteer.find(params[:volunteer_id])
    @gatherings = @volunteer.created_gatherings.with_attached_photos.with_attached_finished_photos

    @favouritable = current_user || current_volunteer

    render json: @gatherings, each_serializer: GatheringSerializer, scope: @favouritable
  end

  private

  def check_volunteer!
    unless current_volunteer == @gathering.creator
      raise StandardError.new("Ви не маєте прав редагувати цей збір")
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_gathering
    @gathering = Gathering.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def gathering_params
    params.require(:gathering).permit(:title, :description, :sum, :start, :end, :ended, :link, :gathering_category_id, photos: [], finished_photos: [])
  end
end