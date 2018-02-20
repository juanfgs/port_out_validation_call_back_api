class Account < ApplicationRecord
  has_many :phones, :dependent => :destroy
  include ActiveModel::Serializers::Xml
end
