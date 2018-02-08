class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :pon
      t.string :pin
      t.string :account_number
      t.string :zip_code
      t.string :subscriber_name

      t.timestamps
    end
  end
end
