ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.timestamps
  end

  create_table :warehouses, :force => true do |t|
    t.belongs_to :user
    t.timestamps
  end

  create_table :cars, :force => true do |t|
    t.belongs_to :user
    t.belongs_to :warehouse
    t.timestamps
  end
end