ActiveAdmin.register Volunteer do

  permit_params :name, :surname, :email, :phone,
                :username, :description, :trust_level, :verification, :created_at,
                :updated_at, :avatar, :banned, documents: [], created_gatherings: []

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

  form do | f |
    f.inputs t("active_admin.details", model: t("activerecord.models.volunteer.one")) do
      f.input :name
      f.input :surname
      f.input :email
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
      row :avatar do | volunteer |
        image_tag volunteer.avatar, size: '100' if volunteer.avatar.present?
      end
      row :documents do | volunteer |
        div do
          volunteer.documents.each do | document |
            div class: "photo-card" do
              span image_tag url_for(document)
              span link_to t(:delete), delete_picture_admin_volunteer_path(volunteer.id, picture_id: document.id),
                           method: :delete, data: { confirm: t("active_admin.delete_confirmation") }, class: "delete-button"
            end
          end
        end
      end
      row :created_at
      row :updated_at
      panel t('activerecord.models.gathering.many') do
        table_for volunteer.created_gatherings do
          column :title do | gathering |
            link_to gathering.title, admin_gathering_path(gathering)
          end
          column :sum
          column :link
        end
      end
      active_admin_comments
    end
  end

  member_action :delete_picture, method: :delete do
    picture = ActiveStorage::Attachment.find(params[:picture_id])
    picture.purge_later
    redirect_back(fallback_location: admin_volunteer_path(params[:id]))
  end

  controller do
    include RemoveEmptyElements

    def update
      changed_to_verified = volunteer_params[:verification] == '1' && Volunteer.find(params[:id]).verification == false

      # delete empty documents
      params[:volunteer][:documents] = remove_empty(params[:volunteer][:documents])
      @volunteer = Volunteer.find(params[:id])

      if @volunteer.update(volunteer_params)
        # If verification status was changed to true, send verification email
        if changed_to_verified
          VolunteerMailer.verification_email(Volunteer.find(params[:id])).deliver_now
        end
        redirect_to admin_volunteer_path(@volunteer), notice: 'Волонтер успішно оновлений!'
      else
        render :edit
      end
    end

    private

    def volunteer_params
      params.require(:volunteer).permit(:name, :surname, :email, :phone,
                                        :username, :description, :trust_level, :verification, :created_at,
                                        :updated_at, :avatar, :banned, documents: [])
    end
  end

end
