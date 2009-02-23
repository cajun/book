module AmountUnit
  include DataMapper::Resource
  is :remixable
  
  property :id, Serial
  property :amount, BigDecimal
  property :unit, String
  property :created_at, DateTime
end