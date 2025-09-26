module GamesHelper
    def last_frame_preview(game)
        content_tag(:p, safe_join(game.frames.last.state.scan(Regexp.new(".{1,#{game.board_width}}")), tag(:br)))
    end
end
