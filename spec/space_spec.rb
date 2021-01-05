require 'space'

describe Space do
  describe '.show_listings' do
    it 'responds to the method .show_listings' do
      expect(Space).to respond_to :show_listings
    end
  end

  describe '.new_listing' do
    it 'adds a new listing to spaces' do
      Space.new_listing('Cave', 'small cave', '£2.00')
      connection = PG.connect(dbname: 'makersbnb_test')
      result = connection.exec("SELECT * FROM spaces;")

      expect(result[0]['name']).to eq 'Cave'
      expect(result[0]['description']).to eq 'small cave'
      expect(result[0]['price']).to eq '£2.00'
    end
  end
end
