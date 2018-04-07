require 'rails_helper'

RSpec.describe Message, type: :model do

  Msg = Struct.new(:text, :expected)

  describe "detect message" do
    subject { Message.detect!(text) }

    list = [
      Msg.new("ふつうのメッセージ", 'be nil'),
      Msg.new("タスク", "eq :all"),
      Msg.new("タスクをテステス", "be_nil"),
      Msg.new("タスク追加　ぴよぴよ", "eq :add"),
      Msg.new("タスク完了　ぴよ", "eq :done"),
      Msg.new("タスク使い方", "eq :usage"),
      Msg.new("タスクヘルプ", "eq :usage"),
      Msg.new("タスク？", "eq :usage"),
      Msg.new("help", "eq :usage"),
      Msg.new("version", "eq :version"),
      Msg.new("タスク終わり　1", "eq :done"),
    ]

    list.each do |msg|
      class_eval <<-"RUBY"
        describe '#{msg.text}' do
          let(:text) { '#{msg.text}' }
          it { is_expected.to #{msg.expected} }
        end
      RUBY
    end
  end

  describe "タスク追加" do
    it "'タスク追加'という部分を削除すること" do
      msg = 'タスク追加　ほげほげほげ'
      Message.detect!(msg)
      expect(msg).to eq 'ほげほげほげ'
    end
  end
  describe "タスク完了" do
    it "'タスク完了'という部分を削除すること" do
      msg = 'タスク完了　1'
      Message.detect!(msg)
      expect(msg).to eq '1'
    end
  end
  describe "タスクおわり" do
    it "'タスクおわり'という部分を削除すること" do
      msg = 'タスクおわり　1'
      Message.detect!(msg)
      expect(msg).to eq '1'
    end
  end
end
