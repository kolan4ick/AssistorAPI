ActiveAdmin.register Volunteer do

  permit_params :name, :surname, :email, :password, :password_confirmation, :phone,
                :login, :description, :trust_level, :verification, :created_at,
                :updated_at, :avatar, :banned

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
    column :banned
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
  filter :banned
  filter :verification
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "Volunteer Details" do
      f.input :name
      f.input :surname
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :phone
      f.input :login
      f.input :description
      f.input :trust_level
      f.input :banned
      f.input :verification
      f.input :avatar, as: :file, input_html: { accept: 'image/*' }
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
      row :banned
      row :verification
      row :authentication_token
      row :avatar do |volunteer|
        image_tag volunteer.avatar, size: '100' if volunteer.avatar.present?
      end
      row :created_at
      row :updated_at
    end
  end
end
