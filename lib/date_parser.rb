class DateParser
  STR_TO_NUM = {'одинадцать' => '11',
                'двенадцать' => '12',
                'тринадцать' => '13',
                'четырнадцать' => '14',
                'пятнадцать' => '15',
                'шестнадцать' => '16',
                'семнадцать' => '17',
                'восемнадцать' => '18',
                'девятнадцать' => '19',
                'двадцать' => '20',
                'один' => '1',
                'два' => '2',
                'три' => '3',
                'четыре' => '4',
                'пять' => '5',
                'шесть' => '6',
                'семь' => '7',
                'восемь' => '8',
                'девять' => '9',
                'десять' => '10',
                'ноль' => '0' }

  def self.parse(title)
    title.downcase!
    STR_TO_NUM.each do |k,v|
      title.gsub!(k, v)
    end
    answer = ""
    did = false
    mytime = ""
    mydate = DateTime.now
    newdate = DateTime.now
    d = {
      myhours: 0,
      myminutes: 0,
      mydays: 0,
      mymonth: 0,
      myyears: 0,
      myweek: 0
    }
    shablon = /(\d{1,2}.\d{1,2}.\d{4})/
    matches = title.scan(shablon).flatten.compact
    if (matches != [])
      shablon = /(\d{1,4})/
      matches2 = matches[0].scan(shablon).flatten.compact
      newdate = newdate.change({
        day: matches2[0].to_i,
        month: (matches2[1].to_i - 1),
        year: matches2[2].to_i
        })
      answer = matches2.join('.')
      did = true
    end

    shablon = /(\d{1,2} янв)|(\d{1,2} фев)|(\d{1,2} мар)|(\d{1,2} апр)|(\d{1,2} мая)|(\d{1,2} май)|(\d{1,2} июн)|(\d{1,2} июл)|(\d{1,2} авг)|(\d{1,2} сен)|(\d{1,2} окт)|(\d{1,2} ноя)|(\d{1,2} дек)/
    matches = title.scan(shablon)

    if (matches != [])
      shablon = /(\d{4})/
      matches2  title.scan(shablon).flatten.compact
      shablon = /(янв)|(фев)|(мар)|(апр)|(мая)|(май)|(июн)|(июл)|(авг)|(сен)|(окт)|(ноя)|(дек)/
      matches3 = title.scan(shablon).flatten.compact
      shablon = /(\d{1,2})/
      matches4 = matches[0].scan(shablon).flatten.compact

      mymonth = case matches3[0]
                when "янв" then 1
                when "фев" then 2
                when "мар" then 3
                when "апр" then 4
                when "мая" then 5
                when "май" then 5
                when "июн" then 6
                when "июл" then 7
                when "авг" then 8
                when "сен" then 9
                when "окт" then 10
                when "ноя" then 11
                when "дек" then 12
                end
      newdate = newdate.change({
        day: matches4[0].to_i,
        month: (mymonth - 1).to_i
        })
      newdate = newdate.change({year: matches2[0].to_i}) if matches2 != []
      answer = matches4[0] + " " + matches3[0]
      did = true
    end

    shablon = /(вчера)|(позавчера)|(сегодня)|(завтра)|(послезавтра)/
    matches = title.scan(shablon).flatten.compact

    if (matches != [])
      add_days = case matches[0]
                 when "позавчера" then -2
                 when "вчера" then -1
                 when "сегодня" then 0
                 when "завтра" then 1
                 when "послезавтра" then 2
                 end
      newdate = newdate.change({day: (newdate.day + add_days)})
      answer = " + " + matches[0]
      did = true
    end

    shablon = /(\d{1,2}ч|\d{1,2} ч)|(в \d{1,2}:\d{1,2})|(в\d{1,2}:\d{1,2})|(\d{2} ми)|(\d{2}ми)|(\d{1,2} \d{2}м)|(в \d{1,2})|(в\d{1,2})|(\d{1,2}:\d{1,2})/
    matches = title.scan(shablon).flatten.compact
    mytime = matches.join(' ')

    matches2 = title.scan(/\d{1,4}/).flatten.compact
    plus = ''
    shablon = /(дней|лет|нед|год|мес|день|дня|час|мин|\d{1,2}м|\d{1,2} м)/
    matches = title.scan(shablon).flatten.compact

    if (title.index('назад') || title.index('через')) && matches != []
      plus = title.index('через') ? '+' : '-'

      if matches[0] == 'час' && matches2 != []
        answer = plus
        if matches2[0]
          answer += matches2[0] + ' час.'
          d[:myhours] = plus + matches2[0]
        end

        if matches2[1]
          answer += ' ' + matches2[1] + ' мин.'
          d[:myminutes] = plus + matches2[1]
        end

        mytime = ''
      end

      if (matches[0] == 'мин' || (matches[0].last == 'м' && title.index('мес').nil?)) && matches2 != 0
        answer = plus
        answer += ' ' + matches2[0] + ' мин.'
        d[:myminutes] = plus + matches2[0]
        mytime = ''
      end

      if matches[0] == 'нед'
        if matches2 != []
          answer = plus
          answer += '' + matches2[0] + ' нед.'
          d[:myweek] = plus + matches2[0]
        end

        if title.index('через нед')
          answer = '+ 1 нед.'
          d.myweek = plus + '1'
        end
      end

      if title.index('месяц')
        if matches2 != []
          answer = plus
          answer += ' ' + matches2[0] + ' мес.'
          d[:mymonth] = plus + matches2[0]
        end

        if title.index('через мес')
          answer = '+1 мес.'
          d[:mymonth] = plus + '1'
        end
      end

      if title.index('год') || title.index('лет')
        if matches2 != []
          answer = plus
          answer += ' ' + matches2[0] + ' год.'
          d[:myyears] = plus + matches2[0]
        end

        if title.index('через год')
          answer = '+1 год.'
          d[:myyears] = plus + '1'
        end
      end

      if title.index('день') || title.index('дня') || title.index('дней')
        if matches2
          answer = plus
          answer = ' ' + matches2[0] + ' дн.'
          d[:mydays] = plus + matches2[0]
        end

        if title.index('через день')
          answer = '+ 1 дн.'
          d[:mydays] = plus + '1'
        end
      end
    end

    if mytime != ''
      shablon = /(в \d{1,2})|(в\d{1,2})|(\d{1,2}:\d{1,2})/
      matches = mytime.scan(shablon).flatten.compact
      if matches != []
        need_analyse = mytime.scan(/(в \d{1,2} в \d{1,2})|(\d{1,2} \d{1,2}м)|(\d{1,2}ч\d{1,2}м)|(\d{1,2}ч \d{1,2}м)|(\d{1,2}:\d{1,2})/).flatten.compact.present?
        shablon1 = /(в \d{1,2}:\d{1,2})|(в\d{1,2}:\d{1,2})/
        matches1 = mytime.scan(shablon1).flatten.compact
        need_analyse = false if matches1 != []
        if need_analyse
          matches3 = mytime.scan(/\d{1,4}/).flatten.compact
          mytime = matches3.join(':')
        else
          mytime = mytime.gsub(/в\s*/, '')
          mytime += ':00' if matches1 == []
        end
      end
    end

    add = (mytime != '') ? "[#{mytime}]" : ''

    if mytime != ''
      if mytime.scan(/\d{1,2}:\d{1,2}/).flatten.compact
        newtime = mytime.split(':')
        mydate = mydate.change({
          hour: newtime[0].to_i,
          min: newtime[1].to_i
          })
      else
        mytime = ''
      end
    end

    if did
      newdate = newdate.change({
        hour: mydate.hour + d[:myhours].to_i,
        min: mydate.minute + d[:myminutes].to_i
        })
      mydate = newdate
    else
      mydate = mydate.change({
        hour: mydate.hour + d[:myhours].to_i,
        min: mydate.minute + d[:myminutes].to_i
        })
    end

    mydate = mydate.change({
      day: mydate.day + d[:mydays].to_i,
      month: mydate.month + d[:mymonth].to_i,
      year: mydate.year + d[:myyear].to_i
      })

    shablon = /(понед)|(вторн)|(сред)|(четв)|(пятн)|(субб)|(воскр)/
    matches = title.scan(shablon).flatten.compact

    if matches != []
      week = case matches[0]
             when 'понед' then 1
             when 'вторн' then 2
             when 'сред' then 3
             when 'четв' then 4
             when 'пятн' then 5
             when 'субб' then 6
             when 'воскр' then 7
             else 0
             end
      if week != 0
        mydate = next_week_day(mydate, week)
        answer = matches[0]
      end
    end

    mydate = nil if (answer == '' && mytime == '')

    {
      title: answer,
      date: mydate
    }
  end

  def self.next_week_day(date, day)
    date += ((day-date.wday) % 7)
  end
end
