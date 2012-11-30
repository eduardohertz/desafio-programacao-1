class Entry < ActiveRecord::Base
  attr_accessible :purchaser_name, :item_description, :item_price, :purchase_count,
  	:merchant_address, :merchant_name, :image_token

  belongs_to :user

  validates_presence_of :item_price, :purchase_count

  def self.revenue(opts={})
  	if opts[:token]
			return where('image_token = ? AND user_id = ?', opts[:token], opts[:user_id]).sum('item_price*purchase_count')
		end
		where('user_id = ?', opts[:user_id]).sum('item_price*purchase_count')
  end
end
