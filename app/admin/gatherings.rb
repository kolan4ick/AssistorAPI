ActiveAdmin.register Gathering do
  permit_params :title, :description, :gathering_category_id, :sum, :start, :end, :ended, :verification,
                :link, :creator_id, :processed, photos: [], finished_photos: []

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :gathering_category
    column :sum
    column :start
    column :end
    column :ended
    column :processed
    column :verification
    column :link
    column :creator_id
    column :photos
    column :finished_photos
    actions
  end

  filter :title
  filter :description
  filter :gathering_category
  filter :sum
  filter :start
  filter :end
  filter :ended
  filter :verification
  filter :link
  filter :creator_id
  filter :processed

  form do | f |
    f.inputs "Gathering Details" do
      f.input :title
      f.input :description
      f.input :gathering_category_id, as: :select, collection: GatheringCategory.all.map { | u | [u.title, u.id] }
      f.input :sum
      f.input :start
      f.input :end
      f.input :ended
      f.input :processed
      f.input :verification
      f.input :link
      f.input :creator_id, as: :select, collection: Volunteer.all.map { | u | ["#{u.name} #{u.surname}", u.id] }
      f.input :photos, as: :file, input_html: { multiple: true, accept: 'image/*' }
      f.input :finished_photos, as: :file, input_html: { multiple: true, accept: 'image/*' }
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :gathering_category
      row :sum
      row :start
      row :end
      row :ended
      row :processed
      row :verification
      row :link
      row :creator do | gathering |
        link_to "#{gathering.creator.name} #{gathering.creator.surname}", admin_volunteer_path(gathering.creator)
      end
      row :photos do | gathering |
        div do
          gathering.photos.each do | photo |
            span image_tag url_for(photo), size: '100'
          end
        end
      end
      row :finished_photos do
        div do
          gathering.finished_photos.each do | photo |
            span image_tag url_for(photo), size: '100'
          end
        end
      end
    end
  end

  controller do
    def update
      @gathering = Gathering.find(params[:id])
      was_processed = @gathering.processed

      if @gathering.update(gathering_params)
        if gathering_params[:processed] == "1" && gathering_params[:verification] == "1" && !was_processed
          # new trust level = old trust level + (@gathering.sum / 10000).ceil + count_of_days_between_start_and_now
          @gathering.creator.update_attribute(:trust_level, @gathering.creator.trust_level + (@gathering.sum / 10000).ceil + ((Time.now - @gathering.start) / 86400).ceil)
        end
        redirect_to admin_gathering_path(@gathering), notice: 'Збір успішно оновлено.'
      else
        render :edit
      end
    end

    private

    def gathering_params
      params.require(:gathering).permit(:title, :description, :gathering_category_id, :sum, :start, :end, :ended, :verification,
                                        :link, :creator_id, :processed, photos: [], finished_photos: [])
    end
  end
end
