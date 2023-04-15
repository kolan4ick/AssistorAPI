ActiveAdmin.register GatheringCategory do

  permit_params :title, :description

  index do
    selectable_column
    id_column
    column :title
    column :description
    actions
  end

  filter :title
  filter :description

  form do | f |
    f.inputs t("active_admin.details", model: t("activerecord.models.gathering_category.one")) do
      f.input :title
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :description
    end
    panel t('activerecord.models.gathering.many') do
      table_for gathering_category.gatherings do
        column :title do | gathering |
          link_to gathering.title, admin_gathering_path(gathering)
        end
        column :sum
        column :creator
        column :link
      end
    end
    active_admin_comments
  end

end
