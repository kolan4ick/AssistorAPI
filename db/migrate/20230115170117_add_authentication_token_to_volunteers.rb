class AddAuthenticationTokenToVolunteers < ActiveRecord::Migration[7.0]
  def change
    add_column :volunteers, :authentication_token, :text

    add_column :volunteers, :authentication_token_created_at, :datetime

    add_index :volunteers, :authentication_token, unique: true
  end
end
