module GatheringHelper

  def filtering(gatherings)
    @gatherings = gatherings

    @filtered_gatherings = []

    filters = params[:filter]

    if filters.include?('sum')
      @filtered_gatherings = @gatherings.where('sum >= ?', filters['sum'].to_i)
    end


    if filters.include?('category')
      @filtered_gatherings = @gatherings.where('gathering_category_id = ?', filters['category'])
    end

    if filters.include?('verification')
      @filtered_gatherings = @gatherings.where('verification = ?', filters['verification'])
    end

    # delete duplicates
    @filtered_gatherings = @filtered_gatherings.uniq
  end

  def sorting(gatherings)
    @gatherings = gatherings

    case params[:sort_by]
    when "1" # sort from newest to oldest
      @gatherings = @gatherings.order(created_at: :desc)
    when "2" # sort from oldest to newest
      @gatherings = @gatherings.order(created_at: :asc)
    when "3" # sort from highest sum to lowest sum
      @gatherings = @gatherings.order(sum: :desc)
    else
      @gatherings
    end
  end
end
