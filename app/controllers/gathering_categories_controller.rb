class GatheringCategoriesController < ApiController
  before_action :authenticate!

  def index
    @gathering_categories = GatheringCategory.all
    render json: @gathering_categories
  end
end
