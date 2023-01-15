class AddAuthenticationTokenToVolunteers < ActiveRecord::Migration[7.0]
  def change
    add_column :volunteers, :authentication_token, :string
  end
end
