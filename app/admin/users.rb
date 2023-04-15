ActiveAdmin.register User do

  permit_params :email, :password, :password_confirmation, :name, :surname, :username

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :surname
    column :username
    column :created_at
    actions
  end

  filter :email
  filter :name
  filter :surname
  filter :username
  filter :created_at

  form do |f|
    f.inputs t("active_admin.details", model: t("activerecord.models.user.one")) do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :name
      f.input :surname
      f.input :username
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :name
      row :surname
      row :authentication_token
      row :username
      row :created_at
      active_admin_comments
    end
  end
end
