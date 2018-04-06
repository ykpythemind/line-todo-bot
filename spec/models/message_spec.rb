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
    describe "先頭がタスクで始まらない" do
      let(:text) { "テストテストテストタスクをやる" }
      it { is_expected.to be_nil }
    end
    describe "なんかちがう" do
      let(:text) { "タスクをテステス" }
      it { is_expected.to be_nil }
    end
    describe "タスク追加" do
      let(:text) { "タスク追加　ぴよぴよ" }
      it { is_expected.to eq :add }
    end
    describe "タスク完了" do
      let(:text) { "タスク完了　ぴよ" }
      it { is_expected.to eq :done }
    end
    describe "タスク終" do
      let(:text) { "タスク終了　ぴよ" }
      it { is_expected.to eq :done }
    end
    describe "タスク使い方" do
      let(:text) { "タスク使い方" }
      it { is_expected.to eq :usage }
    end
    describe "タスクヘルプ" do
      let(:text) { "タスクヘルプ" }
      it { is_expected.to eq :usage }
    end
    describe "タスク？" do
      let(:text) { "タスク？" }
      it { is_expected.to eq :usage }
    end
    describe "help" do
      let(:text) { "help" }
      it { is_expected.to eq :usage }
    end
    describe "version" do
      let(:text) { "version" }
      it { is_expected.to eq :version }
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
