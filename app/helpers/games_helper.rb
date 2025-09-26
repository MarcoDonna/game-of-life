module GamesHelper
    def last_frame_preview(game)
        last_frame = game.frames.last
        content_tag(:p, safe_join(last_frame.state.scan(Regexp.new(".{1,#{game.board_width}}")), tag(:br))) unless last_frame&.state.nil?
    end
end
