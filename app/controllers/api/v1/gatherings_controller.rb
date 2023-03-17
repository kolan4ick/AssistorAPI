class Api::V1::GatheringsController < ApiController
  include GatheringHelper

  before_action :authenticate!, only: [:index, :show, :filter_gatherings, :create_review]
  before_action :set_gathering, only: [:show, :update, :destroy]
  before_action :authenticate_volunteer!, only: [:create, :update, :destroy]

  # GET /gatherings
  def index
    @gatherings = Gathering.all

    render json: @gatherings
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

  def create_review
    @gathering = Gathering.find(params[:gathering_id])

    if current_user
      # Check if user has already reviewed this gathering
      unless GatheringUserReview.where(gathering_id: @gathering.id, user_id: current_user.id).exists?
        @gathering_user_review = GatheringUserReview.new(gathering_id: @gathering.id, user_id: current_user.id)

        if @gathering_user_review.save
          render json: { message: "Перегляд створено" }, status: :created
        else
          render json: @gathering_user_review.errors, status: :unprocessable_entity
        end
        return
      end
    elsif current_volunteer
      # Check if volunteer has already reviewed this gathering
      unless GatheringVolunteerReview.where(gathering_id: @gathering.id, volunteer_id: current_volunteer.id).exists?
        @gathering_volunteer_review = GatheringVolunteerReview.new(gathering_id: @gathering.id, volunteer_id: current_volunteer.id)

        if @gathering_volunteer_review.save
          render json: { message: "Перегляд створено" }, status: :created
        else
          render json: @gathering_volunteer_review.errors, status: :unprocessable_entity
        end
        return
      end
    else
      render json: { error: "Ви не авторизовані" }, status: 401
      return
    end

    render json: { message: "Збір уже переглянуто" }, status: 200
  end

  def reviewed
    if current_user
      @gatherings = current_user.gatherings.with_attached_photos.with_attached_finished_photos
    elsif current_volunteer
      @gatherings = current_volunteer.gatherings.with_attached_photos.with_attached_finished_photos
    else
      render json: { error: "Ви не авторизовані" }, status: 401
      return
    end

    render json: @gatherings
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