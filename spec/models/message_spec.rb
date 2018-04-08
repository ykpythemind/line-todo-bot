require 'rails_helper'

RSpec.describe Message, type: :model do

  Msg = Struct.new(:text, :expected)

  describe "detect message" do

    list = [
      Msg.new("ふつうのメッセージ", nil),
      Msg.new("タスク", :all),
      Msg.new("タスクをテステス", nil),
      Msg.new("タスク追加　ぴよぴよ", :add),
      Msg.new("タスク完了　ぴよ", :done),
      Msg.new("タスク使い方", :usage),
      Msg.new("タスクヘルプ", :usage),
      Msg.new("タスク？", :usage),
      Msg.new("help", :usage),
      Msg.new("version", :version),
      Msg.new("タスク終わり　1", :done),
    ]

    list.each do |msg|
      it "'#{msg.text}' -> 期待通りのシンボルが返ってくること" do
        expect(Message.detect!(msg.text)).to eq msg.expected
      end
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
