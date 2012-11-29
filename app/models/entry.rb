class Entry < ActiveRecord::Base
  attr_accessible :purchaser_name, :item_description, :item_price, :purchase_count,
  	:merchant_address, :merchant_name, :image_token

  def self.revenue(token=nil)
  	if token
			return where('image_token = ?', token).sum('item_price*purchase_count')
		end
		sum('item_price*purchase_count')
  end
end
