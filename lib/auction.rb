class Auction
  attr_reader :items
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    @items.find_all do |item|
      item.bids.empty?
    end
  end

  def potential_revenue
    @items.sum do |item|
      item.current_high_bid.to_i
    end
  end

  def bidders
    bidders = []
    @items.each do |item|
      item.bids.each do |attendee, amount|
        bidders << attendee.name
      end
    end
    bidders.uniq
  end

  def bidder_info
    info = {}
    @items.each do |item|
      item.bids.each do |attendee, amount|
        if info[attendee].nil?
          info[attendee] = {:budget => attendee.budget, :items => [item]}
        else
          info[attendee][:budget] = attendee.budget
          info[attendee][:items] << item
        end
      end
    end
    info
  end
end
