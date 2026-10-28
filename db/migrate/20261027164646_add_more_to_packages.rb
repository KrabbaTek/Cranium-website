class AddMoreToPackages < ActiveRecord::Migration[8.1]
  def change
    add_column :packages, :description, :text
    add_column :packages, :github_url, :string
    add_column :packages, :downloads_count, :integer
    add_reference :packages, :user, null: false, foreign_key: true
  end
end
