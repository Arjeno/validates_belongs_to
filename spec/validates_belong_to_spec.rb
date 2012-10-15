require 'spec_helper'

describe ValidatesBelongsTo do

  context "valid" do

    let(:user)      { User.create }
    let(:warehouse) { Warehouse.create({ :user => user }) }

    subject { Car.create({ :user => user, :warehouse => warehouse })}

    it { should be_valid }

  end

  context "invalid" do

    let(:user)        { User.create }
    let(:user_2)      { User.create }
    let(:warehouse)   { Warehouse.create({ :user => user }) }

    subject { Car.create({ :user => user_2, :warehouse => warehouse })}

    it { should_not be_valid }

    it "should contain validation error" do
      subject.errors[:warehouse].should include 'does not belong to user'
    end

  end

end