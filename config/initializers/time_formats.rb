Time::DATE_FORMATS[:ja] = proc { |t| t.strftime("%Y年%m月%d日(#{%w(日 月 火 水 木 金 土)[t.wday]}) %H時%M分") }
