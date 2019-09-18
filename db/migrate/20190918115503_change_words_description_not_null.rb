class ChangeWordsDescriptionNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :words, :description, false
  end
end
