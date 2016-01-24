require 'date'
require 'open-uri'
require 'yaml'

# timezone parser
# http://qiita.com/semind/items/9614ded891d6154e9a06
class Time
  def timezone(timezone = 'Asia/Tokyo')
    old = ENV['TZ']
    utc = self.dup.utc
    ENV['TZ'] = timezone
    output = utc.localtime
    ENV['TZ'] = old
    output
  end
end

class BotUtil
  class << self
    public
    def timeToDate(time)
      result = nil
      if time.class == Time
        result = Date.new(time.year,time.month,time.day)
      elsif time.class == Date
        result = time
      end
      return result
    end

    def compDates(target,base=Date.today,ignore_days=90)
      result = ""
      limit = (timeToDate(target) - timeToDate(base)).to_i

      if limit == 0
        result = "本日開催です\!"
      elsif limit == 1
        result = "明日開催です\!"
      elsif limit < ignore_days
        # 指定日時以上後なら日付を出さない
        result = "あと#{limit}日です"
      end
    end

    def getHashtag(tags,title,column=0)
      key = title.split[column]
      result = tags[key]
      if result.nil?
        result = ""
      end
      return result
    end

    def getRandomMessage(messages,tag=nil)
      list = Array.new
      # タグの指定が無ければgeneral部分から取得
      if tag.nil?
        list.concat messages["general"]

      # allが指定されていればすべてのタグを対象にする
      elsif tag == "all"
        messages.each_value do | data |
          list.concat data
        end

      # タグが指定されている場合はその項目の中から選択
      else
        if tag != ""
          ary = messages[tag]
          # イベントのタグがランダムメッセージ用のファイルにない場合はGeneralを利用
          if ary.nil?
            ary = messages["general"]
          end
          list.concat ary
        end
      end

      return list.sample
    end

    # ファイルもしくはURLからYAMLをロードする
    # 第二引数にtrueを渡すとファイルがない場合作成する
    def loadYmlData(path,create=true)
      result = ""
      begin
        file = open(path).read
        result = YAML.load_stream(file)
        if result.size == 1
          result = result[0]
        end
      rescue Errno::ENOENT
        if create && path != "" && path != nil
          File.open(path,"w").close()
        end
      end

      return result
    end

    def saveYmlData(path,data)
      file = File.open(path,"w")
      file.write(data)
    end
  end
end
