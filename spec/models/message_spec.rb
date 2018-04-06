require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "通常のメッセージ" do
    let(:text) { "piyopiyo" }
    it "does not detect something" do
      Message.detect!(text) do |result|
        expect(result).to be_nil
      end
    end
  end
  describe "タスクメッセージ" do
    let(:text) { "タスク" }
    it "detect something" do
      Message.detect!(text) do |result|
        expect(result).to_not be_nil
      end
    end
  end
end
