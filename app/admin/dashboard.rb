# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel t("activeadmin.charts.users_per_day"), style: "text-align: center;" do
          # chartkick chart with info about the number of users/volunteers registrations per day
          render partial: "admin/charts/users_per_day", locals: { entities: User.all + Volunteer.all }
        end

        panel t("activeadmin.charts.gatherings_per_status"), style: "text-align: center;" do
          # chartkick chart with info about active, ended, verified gatherings
          render partial: "admin/charts/gatherings_per_status"
        end

        panel t("activeadmin.charts.volunteers_per_status"), style: "text-align: center;" do
          # chartkick chart with info about processed, verified, banned, and processed but not verified volunteers
          render partial: "admin/charts/volunteers_per_status"
        end
      end
    end
  end
end
