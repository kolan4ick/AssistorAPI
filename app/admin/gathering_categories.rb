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

  form do |f|
    f.inputs "Gathering Category Details" do
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
    panel "Gatherings" do
      table_for gathering_category.gatherings do
        column :title
        column :description
        column :location
        column :date
        column :time
      end
    end
  end

end
