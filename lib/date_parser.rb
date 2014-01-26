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
    return '' unless title
    STR_TO_NUM.each do |key, value|
      title = title.gsub(key,value)
    end
    @answer = ''
    @did = false
    mytime = ''
    mydate = DateTime.new
    newdate = DateTime.new
    d = { myhours: 0,
          myminutes: 0,
          mydays: 0,
          mymonth: 0,
          myyears: 0,
          myweek: 0}
    shablon = /(\d{1,2}.\d{1,2}.\d{4})/
    matches = title.match(shablon)
    if matches
      shablon = /(\d{1,4})/
      matches2 = matches[0].match(@shablon)
      newdate = Date.new(matches2[2].to_i, (matches2[1].to_i - 1), matches2[0])
      @answer = (newdate + 1.months).strftime("dd/mm/yyyy")
      @did = true
    end
    shablon = /(\d{1,2} янв)|(\d{1,2} фев)|(\d{1,2} мар)|(\d{1,2} апр)|(\d{1,2} мая)|(\d{1,2} май)|(\d{1,2} июн)|(\d{1,2} июл)|(\d{1,2} авг)|(\d{1,2} сен)|(\d{1,2} окт)|(\d{1,2} ноя)|(\d{1,2} дек)/
    matches = title.match(shablon)
    if matches
      shablon = /(\d{4})/
      matches2 = title.match(shablon)
      shablon = /(янв)|(фев)|(мар)|(апр)|(мая)|(май)|(июн)|(июл)|(авг)|(сен)|(окт)|(ноя)|(дек)/
      matches3 = title.match(shablon)
      shablon = /(\d{1,2})/
      matches4 = matches[0].match(shablon)
      mymonth = case matches3[0]
                when 'янв' then 1
                when 'фев' then 2
                when 'мар' then 3
                when 'апр' then 4
                when 'мая' then 5
                when 'май' then 5
                when 'июн' then 6
                when 'июл' then 7
                when 'авг' then 8
                when 'сен' then 9
                when 'окт' then 10
                when 'ноя' then 11
                when 'дек' then 12
                end
      newdate = Date.today
      newdate.change(day: matches4[0].to_i, month: (mymonth.to_i-1))
      newdate.change(year: matches2[0].to_i) if matches2
      @answer = matches4[0] + ' ' + matches3[0]
      @did = true
    end

    shablon = /(вчера)|(позавчера)|(сегодня)|(завтра)|(послезавтра)/
    matches = title.match(shablon)
    if matches
      add_days = case matches[0]
                 when 'позавчера' then -2
                 when 'вчера' then -1
                 when 'сегодня' then 0
                 when 'завтра' then 1
                 when 'послезавтра' then 2
                 end
      newdate = newdate + add_days.days
      @answer = ' + ' + matches[0]
      @did = true
    end

    shablon = /(\d{1,2}ч|\d{1,2} ч)|(в \d{1,2}:\d{1,2})|(в\d{1,2}:\d{1,2})|(\d{2} ми)|(\d{2}ми)|(\d{1,2} \d{2}м)|(в \d{1,2})|(в\d{1,2})|(\d{1,2}:\d{1,2})/
    matches = title.match(shablon)
    if matches
      mytime = (matches.count == 1) ? matches : matches.join(' ')
    end
    matches2 = title.match(/\d{1,4}/)
    shablon = /(дней|лет|нед|год|мес|день|дня|час|мин|\d{1,2}м|\d{1,2} м)/
    matches = title.match(shablon)
    if (title.index('назад').present? || title.index('через').present?) && matches
      plus = title.index('через').present? ? '+' : '-'
      if matches[0] == 'час' && matches2
        @answer = plus
        if matches2[0]
          @answer += matches2[0] + ' час.'
          d[:myhours] = plus + matches2[0]
        end
        if matches2[1]
          @answer += ' ' + matches2[1] + ' мин.'
          d[:myminutes] = plus + matches2[0]
        end
        mytime = ''
      end

      if (matches[0] == 'мин' || (matches[0][matches[0].length - 1] == 'м')) && title.index('мес').nil? && matches2
        @answer = plus
        @answer += ' ' + matches2[0] + ' мин.'
        mytime = ''
      end

      if matches[0] == 'нед'
        if matches2
          @answer = plus
          @answer += ' ' + matches2[0] + ' нед. '
          d[:myweek] = plus + matches2[0]
        end
        if title.index('через нед').present?
          @answer = '+ 1 нед.'
          d[:myweek] = plus + 1
        end
      end

      if title.index('месяц').present?
        if matches2
          @answer = plus
          @answer += ' ' + matches2[0] + ' мес. '
          d[:mymonth] = plus + matches2[0]
        end
        if title.index('через мес').present?
          @answer = '+ 1 мес.'
          d[:mymonth] = plus + 1
        end
      end

      if (title.index(' год').present? || title.index(' лет').present?)
        if matches2
          @answer = plus
          @answer += ' ' + matches2[0] + ' год. '
          d[:myyears] = plus + matches2[0]
        end
        if title.index('через год').present?
          @answer = '+ 1 год.'
          d[:myyears] = plus + 1
        end
      end

      if (title.index(' день').present? || title.index(' дня').present? || title.index(' дней').present? || title.index(' суток').present?)
        if matches2
          @answer = plus
          @answer += ' ' + matches2[0] + ' дн. '
          d[:mydays] = plus + matches2[0]
        end
        if title.index('через день').present?
          @answer = '+ 1 дн.'
          d[:mydays] = plus + 1
        end
      end
    end

    if mytime.present?
      shablon = /(в \d{1,2})|(в\d{1,2})|(\d{1,2}:\d{1,2})/
      matches = mytime.match(shablon)

      if matches
        need_analyse = mytime.match(/(в \d{1,2} в \d{1,2})|(\d{1,2} \d{1,2}м)|(\d{1,2}ч\d{1,2}м)|(\d{1,2}ч \d{1,2}м)|(\d{1,2}:\d{1,2})/)
        shablon1 = /(в \d{1,2}:\d{1,2})|(в\d{1,2}:\d{1,2})/
        matches1 = mytime.match(shablon1)
        need_analyse = false if matches1
        if need_analyse
          matches3 = mytime.match(/\d{1,4}/)
          if matches3
            mytime = (matches3.length == 1) ? matches3 : matches3.koin(':')
          end
        else
          mytime = mytime.gsub('в ','').gsub('в','')
          mytime += ':00' unless matches1
        end
      end
    end

    add = mytime.present? ? "[" + mytime + "]" : ''

    if mytime.present?
      if mytime.match(/\d{1,2}:\d{1,2}/)
        newtime = mytime.split(':')
        mydate.change(hours: newtime[0].to_i,
                      minutes: newtime[1].to_i,
                      seconds: 0)
      else
        mytime = ''
      end
    end

    if @did
      newdate.change( hours: mydate.hour + d[:myhours].to_i,
                      minutes: mydate.minute + d[:myminutes].to_i,
                      seconds: 0)
      mydate = newdate
    else
      mydate.change( hours: mydate.hour + d[:myhours].to_i,
                      minutes: mydate.minute + d[:myminutes].to_i,
                      seconds: 0)
    end

    mydate += (d[:mydays].to_i + d[:myweek]*7).days
    mydate += d[:mymonth].to_i.months
    mydate += d[:myyears].to_i.years
    shablon = /(понед)|(вторн)|(сред)|(четв)|(пятн)|(субб)|(воскр)/
    matches = title.match(shablon)

    if matches
      week = 0
      week = case matches[0]
            when 'понед' then 1
            when 'вторн' then 2
            when 'сред' then 3
            when 'четв' then 4
            when 'пятн' then 5
            when 'субб' then 6
            when 'воскр' then 7
            end
      if week != 0
        mydate = next_week_day(mydate, week)
        @answer = matches[0]
      end
    end

    @answer + ' ' + add
  end

  def self.next_week_day(date, day)
    (day = day.abs%7 - date.day) < 0 && day += 7
    date + day.days
  end
end
