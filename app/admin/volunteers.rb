ActiveAdmin.register Volunteer do

  permit_params :name, :surname, :email, :password, :password_confirmation, :phone,
                :username, :description, :trust_level, :verification, :created_at,
                :updated_at, :avatar, :banned, documents: []

  index do
    selectable_column
    id_column
    column :name
    column :surname
    column :email
    column :phone
    column :username
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
  filter :username
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
      f.input :username
      f.input :description
      f.input :trust_level
      f.input :banned
      f.input :verification
      f.input :avatar, as: :file, input_html: { accept: 'image/*' }
      f.input :documents, as: :file, input_html: { multiple: true, accept: 'image/*' }
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :surname
      row :email
      row :phone
      row :username
      row :description
      row :trust_level
      row :banned
      row :verification
      row :authentication_token
      row :avatar do |volunteer|
        image_tag volunteer.avatar, size: '100' if volunteer.avatar.present?
      end
      row :documents do
        div do
          volunteer.documents.each do |document|
            span image_tag document, size: '1000'
          end
        end
      end
      row :created_at
      row :updated_at
    end
  end
end
