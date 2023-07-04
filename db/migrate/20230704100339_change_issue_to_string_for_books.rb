class ChangeIssueToStringForBooks < ActiveRecord::Migration[7.0]
  def change
    change_column :books, :issue, :string
  end
end
