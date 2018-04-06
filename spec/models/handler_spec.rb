require 'rails_helper'

RSpec.describe Handler, type: :model do
  describe "タスク追加のメッセージがくるとき" do
    let(:handler) { Handler.new("タスク追加　piyopiyo") }
    it "データベースに追加すること" do
      expect {
        handler.perform!
      }.to change(Task, :count)
      expect(Task.last.text).to eq "piyopiyo"
    end
    it "追加したことをリプライする" do
      handler.perform!
      message = handler.reply.instance_variable_get(:@stack).join
      expect(message).to include "追加した"
    end
  end

  describe "タスク完了のメッセージがくるとき" do
    let(:handler) { Handler.new("タスク完了　1") }
    let!(:task) { Task.create(id: 1, text: "とあるタスク") }
    it "データベースから削除すること" do
      expect {
        handler.perform!
      }.to change { Task.count }.by(-1)
    end
    it "終了したことをリプライする" do
      handler.perform!
      message = handler.reply.instance_variable_get(:@stack).join
      expect(message).to include "とあるタスク"
    end
  end

  describe "タスク使い方のメッセージがくるとき" do
    let(:handler) { Handler.new("タスク使い方") }
    it "使い方を表示すること" do
      helptext = Handler.const_get(:USAGE)
      handler.perform!
      message = handler.reply.instance_variable_get(:@stack).join
      expect(message).to include helptext
    end
  end
end
