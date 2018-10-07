class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :merchant_id, :description, :unit_price
end
