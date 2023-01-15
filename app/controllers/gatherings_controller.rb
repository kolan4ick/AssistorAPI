class GatheringsController < ApiController
  before_action :authenticate!, only: [:index, :show]
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