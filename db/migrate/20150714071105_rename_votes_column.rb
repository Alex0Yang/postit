class RenameVotesColumn < ActiveRecord::Migration
  def change
    change_table :votes do |t|
      t.rename :votable_type, :voteable_type
      t.rename :votable_id, :voteable_id
    end
  end
end
