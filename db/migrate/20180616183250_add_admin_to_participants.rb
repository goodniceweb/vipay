class AddAdminToParticipants < ActiveRecord::Migration[5.1]
  def change
    add_column :participants, :admin, :boolean
  end
end
