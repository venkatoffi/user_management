class UserEmailUniq < ActiveRecord::Migration[8.0]
  def change
    # Make column NOT NULL
    change_column_null :users, :email, false

    # Add UNIQUE index
    add_index :users, :email, unique: true

    # Make column NOT NULL
    change_column_null :users, :password_digest, false
  end
end
