require_relative 'spec_helper'
require_relative '../lib/xo/engine'
require_relative '../lib/xo/game_over_state'

require 'ostruct'

module TTT

  describe GameOverState do

    before do
      null_listener = OpenStruct.new
      def null_listener.handle_event(e); end

      @engine = Engine.new(null_listener)
      @game_over_state = GameOverState.new(@engine)
    end

    describe '#continue_playing' do

      it 'clears the board' do
        @engine.board = ::MiniTest::Mock.new
        @engine.board.expect :clear, :retval
        @game_over_state.continue_playing(:any_value)
        @engine.board.verify
      end

      it 'sets turn to the value given as its argument' do
        @game_over_state.continue_playing(:any_value)
        @engine.turn.must_equal :any_value
      end

      it 'changes the state to the playing state' do
        @game_over_state.continue_playing(:any_value)
        @engine.state.must_equal @engine.playing_state
      end

      it 'notifies the listener' do
        @engine.listener = ::MiniTest::Mock.new
        @engine.listener.expect :handle_event, :retval, [Object]
        @game_over_state.continue_playing(:any_value)
        @engine.listener.verify
      end
    end

    describe '#stop' do

      it 'changes the state to the idle state' do
        @game_over_state.stop
        @engine.state.must_equal @engine.idle_state
      end
    end

    describe '#start' do

      it 'should raise NotImplementedError' do
        proc { @game_over_state.start(:t) }.must_raise NotImplementedError
      end
    end

    describe '#play' do

      it 'should raise NotImplementedError' do
        proc { @game_over_state.play(:r, :c) }.must_raise NotImplementedError
      end
    end
  end
end