require 'rspec'

RSpec.describe PizzaFactory::InventoryService do
  let(:inventory_service) { described_class.new }
  let(:item) { double("Item", name: "Pepperoni") }
  let(:inventory) { instance_double("PizzaFactory::Inventory") }

  before do
    allow(PizzaFactory::Inventory).to receive(:new).and_return(inventory)
  end

  describe "#restock" do
    it "adds item to inventory" do
      expect(inventory).to receive(:add_item).with(item, 10)
      inventory_service.restock(item, 10)
    end
  end

  describe "#check_availability?" do
    it "checks if an item is available in sufficient quantity" do
      allow(inventory).to receive(:available?).with(item, 5).and_return(true)
      expect(inventory_service.check_availability?(item, 5)).to be true
    end
  end

  describe "#deduct" do
    context "when item is valid" do
      it "deducts the item from inventory" do
        allow(inventory).to receive(:valid?).with(item).and_return(true)
        expect(inventory).to receive(:deduct).with(item, 1)
        inventory_service.deduct(item)
      end
    end

    context "when item is not valid" do
      it "raises an error" do
        allow(inventory).to receive(:valid?).with(item).and_return(false)
        expect { inventory_service.deduct(item) }.to raise_error(RuntimeError, "#{item.class} not available: #{item.name}")
      end
    end
  end

  describe "#valid?" do
    it "checks if an item is valid in inventory" do
      allow(inventory).to receive(:valid?).with(item).and_return(true)
      expect(inventory_service.valid?(item)).to be true
    end
  end
end

