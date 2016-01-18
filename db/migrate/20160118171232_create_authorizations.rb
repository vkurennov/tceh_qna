class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.belongs_to :user, index: true

      t.timestamps null: false
    end

    add_index :authorizations, [:provider, :uid]
  end
end
