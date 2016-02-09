class AddLockVersionToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :lock_version, :integer, default: 0
  end
end
