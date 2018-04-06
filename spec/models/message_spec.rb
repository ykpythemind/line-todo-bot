require 'rails_helper'

RSpec.describe Message, type: :model do

  describe "detect message" do
    subject { Message.detect!(text) }
    describe "通常のメッセージ" do
      let(:text) { "piyopiyo" }
      it { is_expected.to be_nil }
    end
    describe "タスクメッセージ" do
      let(:text) { "タスク" }
      it { is_expected.to eq :all }
    end
  end

end
