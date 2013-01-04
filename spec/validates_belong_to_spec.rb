require 'spec_helper'

describe ValidatesBelongsTo do

  describe :validation do

    let(:user)        { User.create }
    let(:user_2)      { User.create }

    let(:warehouse)   { Warehouse.create({ :user => user }) }
    let(:warehouse_2) { Warehouse.create({ :user => user_2 }) }

    subject { Car.new({ :user => user }) }

    it { should allow_value(warehouse).for(:warehouse) }
    it { should_not allow_value(warehouse_2).for(:warehouse).with_message('does not belong to user') }

    describe 'when association owner is set to nil' do

      it { should allow_value(Warehouse.create).for(:warehouse) }

    end

    describe 'when record owner is set to nil' do

      subject { Car.new }

      it { should_not allow_value(warehouse).for(:warehouse) }

    end

  end

end