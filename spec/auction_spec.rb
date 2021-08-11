require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Auction do
  it 'exists' do
    auction = Auction.new
    expect(auction).to be_a(Auction)
  end

  describe '#add_item(item)' do
    it 'does not have any items at first' do
      auction = Auction.new
      expect(auction.items).to eq([])
    end

    it 'adds an item to the items array' do
      auction = Auction.new
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      auction.add_item(item1)
      auction.add_item(item2)
      expect(auction.items).to eq([item1, item2])
    end
  end

  describe '#item_names' do
    it 'returns an array of the names of items in the auction' do
      auction = Auction.new
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      auction.add_item(item1)
      auction.add_item(item2)
      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end

  describe '#add_bid(attendee,amount)' do
    it 'does not have any bids at first' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')
      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')
      auction = Auction.new
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      expect(item1.bids).to eq({})
    end

    it 'adds a bid to the hash with the attendee as the key and the amount as the value' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')
      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')
      auction = Auction.new
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      expected = {attendee2 => 20, attendee1 => 22}
      expect(item1.bids).to eq(expected)
    end
  end

  describe '#current_high_bid' do
    it 'returns the highest bid' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')
      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')
      auction = Auction.new
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      expect(item1.current_high_bid).to eq(22)
    end
  end

  describe '#unpopular_items' do
    it 'returns an array of items that have zero bids' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')
      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')
      auction = Auction.new
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      expect(auction.unpopular_items).to eq([item2, item3, item5])
      item3.add_bid(attendee2, 15)
      expect(auction.unpopular_items).to eq([item2, item5])
    end
  end

  describe '#potential_revenue' do
    it 'returns the potential revenue based off an items highest bid' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')
      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')
      auction = Auction.new
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)
      expect(auction.potential_revenue).to eq(87)
    end
  end
end
