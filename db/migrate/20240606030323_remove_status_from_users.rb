class RemoveStatusFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :status, :boolean
  end
end
