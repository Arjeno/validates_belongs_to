class User < ActiveRecord::Base
  has_many :warehouses
  has_many :cars
end

class Warehouse < ActiveRecord::Base
  has_many :cars
  belongs_to :user
end

class Car < ActiveRecord::Base
  belongs_to :user
  belongs_to :warehouse
  validates :warehouse, :belongs_to => :user
end