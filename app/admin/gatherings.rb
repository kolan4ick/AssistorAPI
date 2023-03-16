ActiveAdmin.register Gathering do
  permit_params :title, :description, :gathering_category_id, :sum, :start, :end, :ended, :verification, :link, :creator_id, photos: [], finished_photos: []

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

  form do |f|
    f.inputs "Gathering Details" do
      f.input :title
      f.input :description
      f.input :gathering_category_id, as: :select, collection: GatheringCategory.all.map { |u| [u.title, u.id] }
      f.input :sum
      f.input :start
      f.input :end
      f.input :ended
      f.input :verification
      f.input :link
      f.input :creator_id, as: :select, collection: Volunteer.all.map { |u| ["#{u.name} #{u.surname}", u.id] }
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
      row :verification
      row :link
      row :creator do |gathering|
        link_to "#{gathering.creator.name} #{gathering.creator.surname}", admin_volunteer_path(gathering.creator)
      end
      row :photos do |gathering|
        div do
          gathering.photos.each do |photo|
            span image_tag url_for(photo), size: '100'
          end
        end
      end
      row :finished_photos do
        div do
          gathering.finished_photos.each do |photo|
            span image_tag url_for(photo), size: '100'
          end
        end
      end
    end
  end

end
