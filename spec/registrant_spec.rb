require 'spec_helper'

RSpec.describe Registrant do
  let(:willy_wonka) { Registrant.new(name: "Willy Wonka", age: 40) }
  let(:charlie) { Registrant.new(name: "Charlie Bucket", age: 14) }
  let(:grandpa) { Registrant.new(name: "Grandpa Joe", age: 75) }

  describe '#initialize' do
    it 'can initialize' do
      expect(willy_wonka).to be_an_instance_of(Registrant)
      expect(willy_wonka.name).to eq("Willy Wonka")
      expect(willy_wonka.age).to eq(40)
      expect(willy_wonka.permit?).to eq(false)
      expect(willy_wonka.license_data).to eq({ :written=>false, :license=>false, :renewed=>false })
    end
  end
end