class Api::V1::GatheringsController < ApiController
  include GatheringHelper

  before_action :authenticate!, only: [:index, :show, :search, :create_view, :viewed, :created_by_volunteer]
  before_action :set_gathering, only: [:show, :update, :destroy]
  before_action :volunteer_authenticate!, only: [:create, :update, :destroy]
  before_action :check_volunteer!, only: [:update, :destroy]

  # GET /gatherings
  def index
    @page = (params[:page] || 1).to_i

    @gatherings = Gathering.offset(($per_page * @page) - $per_page).limit($per_page)

    @favouritable = current_user || current_volunteer

    render json: @gatherings.order(created_at: :desc), each_serializer: GatheringSerializer, scope: @favouritable
  end

  def search
    @page = (params[:page] || 1).to_i

    @favouritable = current_user || current_volunteer

    # Get all gatherings
    @gatherings = Gathering.all

    # Filter gatherings by filter options
    @gatherings = filtering(@gatherings)

    # Search gatherings by search query
    @gatherings = searching(@gatherings)

    # Sort gatherings by sort options
    @gatherings = sorting(@gatherings)

    @gatherings = @gatherings.offset(($per_page * @page) - $per_page).limit($per_page)
    render json: @gatherings.order(created_at: :desc), each_serializer: GatheringSerializer, scope: @favouritable
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
      render json: { error_message: "#{@gathering.errors.full_messages.join(", ")}" }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gatherings/1
  def update
    if @gathering.update(gathering_params)
      render json: @gathering, each_serializer: GatheringSerializer, scope: current_volunteer, status: 200
    else
      render json: { error_message: "#{@gathering.errors.full_messages.join(", ")}" }, status: :unprocessable_entity
    end
  end

  # DELETE /gatherings/1
  def destroy
    @gathering.destroy!
    render json: { message: "Збір видалено" }, status: 200
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

    @authenticatable = current_user || current_volunteer

    @gatherings = @authenticatable.viewed_gatherings

    @page = (params[:page] || 1).to_i

    @favouritable = current_user || current_volunteer

    @gatherings = @gatherings.offset(($per_page * @page) - $per_page).limit($per_page)

    render json: @gatherings.order(created_at: :desc), each_serializer: GatheringSerializer, scope: @favouritable
  end

  def created_by_volunteer
    @page = (params[:page] || 1).to_i

    @volunteer = Volunteer.find(params[:volunteer_id])
    @gatherings = @volunteer.created_gatherings.offset(($per_page * @page) - $per_page).limit($per_page)

    @favouritable = current_user || current_volunteer

    render json: @gatherings.order(created_at: :desc), each_serializer: GatheringSerializer, scope: @favouritable
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

  def filtering(gatherings)
    @gatherings = gatherings

    if params[:filter]
      filter = params[:filter]

      if filter
        if filter[:categories]
          categories = filter[:categories].split(",")
          @gatherings = @gatherings.where(gathering_category_id: categories)
        end

        # If both active and not_active are true, then do not change @gatherings
        unless true?(filter[:active]) && true?(filter[:not_active])
          if true?(filter[:active])
            @gatherings = @gatherings.where(ended: false)
          end

          if true?(filter[:not_active])
            @gatherings = @gatherings.where(ended: true)
          end
        end

        if true?(filter[:new])
          @gatherings = @gatherings.where("created_at >= ?", 2.week.ago)
        end
      end
    end

    @gatherings
  end

  def true?(obj)
    obj.to_s.downcase == "true"
  end

  def searching(gatherings)
    @gatherings = gatherings

    if params[:query]
      query = params[:query].downcase

      if query
        # Search gathering by title, description, sum and by gathering category title, and by volunteer name
        @gatherings = @gatherings.where("LOWER(title) LIKE ? OR LOWER(description) LIKE ? OR CAST(sum AS TEXT) LIKE ? OR gathering_category_id
                                       IN (SELECT id FROM gathering_categories WHERE LOWER(title) LIKE ?)
                                       OR creator_id IN (SELECT id FROM volunteers WHERE LOWER(name) LIKE ?)",
                                        "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")

      end
    end
    @gatherings
  end

  def sorting(gatherings)
    @gatherings = gatherings

    if params[:sort]
      sort = params[:sort]

      if sort
        case sort[:by]
        when "created_at_desc" # Created at descending
          @gatherings = @gatherings.order(created_at: :desc)
        when "gathered_sum_asc" # Gathered sum ascending
          @gatherings = @gatherings.order(gathered_sum: :asc)
        when "gathered_sum_desc" # Gathered sum descending
          @gatherings = @gatherings.order(gathered_sum: :desc)
        else
          # Default - created at ascending
          @gatherings = @gatherings.order(created_at: :asc)
        end
      end
    end
    @gatherings
  end

  # Only allow a trusted parameter "white list" through.
  def gathering_params
    params.require(:gathering).permit(:title, :description, :sum, :start, :end, :ended, :link, :gathering_category_id, photos: [], finished_photos: [])
  end
end