class TweetParameter
  attr_reader :user_id, :text, :img_data, :mine

  # キーワード引数を使っても良いかも
  def initialize(attrs = {})
    @user_id = attrs[:user_id]
    @text = valid_text(attrs[:text],attrs[:img_data])
    @img_data = attrs[:img_data].present? ? valid_img(attrs[:img_data]) : nil
    @mine = attrs[:img_data].try(:content_type)
    freeze
  end

  # 画像: 24文字
  # URL: 23文字
  def valid_text(text,img)
    if img.present? #画像あり
      return _valid_text(text,117)
    else #画像なし
      return _valid_text(text,141)
    end
  end

  def valid_img(data)
    if  (data.size < 5.megabyte && data.try(:content_type) != "image/gif") || (data.size < 3.megabyte && data.try(:content_type) == "image/gif")
      return data.read
    else
      return "INVALID_IMAGE"
    end
  end

  def _valid_text(text, text_limitation)
    text = text.gsub(/(\r\n|\r)/,"\n")
    text_length = text.length

    # URLありの時は再計算
    if m = text.to_enum(:scan, /https?:\/\/([\w*%#!()~\'-]+\.)+[\w*%#!()~\'-\/]+(\/[\w*%#!()~\'-.]+)*/u).map{Regexp.last_match} # URLあり
      url_count = m.length * 23 # urlの個数*23
      _text = text.gsub(/https?:\/\/([\w*%#!()~\'-]+\.)+[\w*%#!()~\'-\/]+(\/[\w*%#!()~\'-.]+)*/u,'') # 本テキストからurl分の箇所を空にして純粋なテキストのみにする
      text_length = _text.length + url_count # 文字数を再計算
    end

    if text_length < text_limitation
      return text
    else
      return 'INVALID_TEXT_SIZE'
    end
  end

end