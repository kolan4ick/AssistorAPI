ActiveAdmin.register User do

  permit_params :email, :password, :password_confirmation, :name, :surname, :login

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :surname
    column :login
    column :created_at
    actions
  end

  filter :email
  filter :name
  filter :surname
  filter :login
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :name
      f.input :surname
      f.input :login
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :name
      row :surname
      row :authentication_token
      row :login
      row :created_at
    end
  end
end
