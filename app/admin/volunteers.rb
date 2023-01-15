ActiveAdmin.register Volunteer do

  permit_params :name, :surname, :email, :phone, :login, :description, :trust_level, :verification, :created_at, :updated_at, :avatar

  index do
    selectable_column
    id_column
    column :name
    column :surname
    column :email
    column :phone
    column :login
    column :description
    column :trust_level
    column :verification
    column :avatar
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :surname
  filter :email
  filter :phone
  filter :login
  filter :description
  filter :trust_level
  filter :verification
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "Volunteer Details" do
      f.input :name
      f.input :surname
      f.input :email
      f.input :phone
      f.input :login
      f.input :description
      f.input :trust_level
      f.input :verification
      f.input :avatar, as: :file, input_html: { accept: 'image/*' }
      f.input :created_at
      f.input :updated_at
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :surname
      row :email
      row :phone
      row :login
      row :description
      row :trust_level
      row :verification
      row :avatar do |volunteer|
        image_tag volunteer.avatar.url, size: '100'
      end
      row :created_at
      row :updated_at
    end
  end
end
