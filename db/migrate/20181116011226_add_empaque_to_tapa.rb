class AddEmpaqueToTapa < ActiveRecord::Migration
  def change
    add_reference :tapas, :empaque, index: true, foreign_key: true
  end
end
