class Account < ApplicationRecord
  has_many :phones, :dependent => :destroy

end
