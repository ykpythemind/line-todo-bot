require 'rails_helper'

RSpec.describe Handler, type: :model do
  describe "タスク追加のメッセージがくるとき" do
    context "メッセージの内容が正しくあるとき" do
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

    context "メッセージが空の時" do
      let(:handler) { Handler.new("タスク追加") }
      it "データベースに追加しないこと" do
        expect { handler.perform! }.to_not change(Task, :count)
      end
    end
  end

  describe "タスク完了のメッセージがくるとき" do
    let!(:task) { Task.create(id: 1, text: "とあるタスク") }
    context "正しくIDを指定したとき" do
      let(:handler) { Handler.new("タスク完了　1") }
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

    context "正しくないID" do
      let(:handler) { Handler.new("タスク完了　ほげ") }
      it "データベースから削除しない" do
        expect { handler.perform! }.to_not change { Task.count }
      end
      it "ちがっていることをリプライ" do
        handler.perform!
        message = handler.reply.instance_variable_get(:@stack).join
        expect(message).to include "見つけられなかった"
      end
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
