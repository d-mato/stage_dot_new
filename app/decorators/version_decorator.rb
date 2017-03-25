module VersionDecorator
  def target_string
    case item
    when Company
      "#{item.name}の企業情報"
    when Interview
      "#{item.company.name}の面談情報"
    when Resume
      'レジュメ'
    end
  end
end
