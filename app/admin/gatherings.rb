ActiveAdmin.register Gathering do
  permit_params :title, :description, :gathering_category, :sum, :start, :end, :ended, :verification, :link, :volunteer_id, photos: [], finished_photos: []

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
    column :volunteer_id
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
  filter :volunteer_id

  form do |f|
    f.inputs "Gathering Details" do
      f.input :title
      f.input :description
      f.input :gathering_category
      f.input :sum
      f.input :start
      f.input :end
      f.input :ended
      f.input :verification
      f.input :link
      f.input :volunteer
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
      row :volunteer
      row :photos do |gathering|
        gathering.photos.each do |photo|
          span image_tag url_for(photo), size: '100'
        end
      end
      row :finished_photos do |gathering|
        gathering.finished_photos.each do |photo|
          span image_tag url_for(photo), size: '100'
        end
      end
    end
  end

end
