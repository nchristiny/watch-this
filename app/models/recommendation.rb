class Recommendation
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  validates_presence_of :genres_pref, :director_pref, :decade_pref, :keywords_pref, :stars_pref, :rating_pref

  field :winning_title, type: String, default: ""
  field :winning_id,    type: String, default: ""
  field :genres_pref,   type: String, default: ""
  field :rating_pref,   type: Integer, default: 1
  field :director_pref, type: String, default: ""
  field :decade_pref,   type: Array, default: []
  field :stars_pref,    type: String, default: ""
  field :keywords_pref, type: String, default: ""

  def calculate!
    score_genres
    score_decade
    score_rating
    score_director
    score_keywords
    score_stars
    self.update_attributes(winning_title: Film.asc(:score).last[:title], winning_id: Film.asc(:score).last[:id])
  end

  def score_genres
    genre_str = self.genres_pref
    genre_array = genre_str.split(/\s*,\s*/)
    genre_array.each do |input_genre|
      Film.each do |film|
        film[:genre].each do |g|
          if g == input_genre
            film.inc(score: 40)
          end
        end
      end
    end
  end

  def score_decade
    # self.decade_pref consists of an array possibly holding these values:
    # ["Any", "Pre 70s", "70s", "80s", "90s", "2000 onwards"]
    fave_decades = []
    self.decade_pref.each do |e|
      if e == "Any"
        fave_decades << (1..2020)
      elsif e == "Pre 70s"
        fave_decades << (1..1969)
      elsif e == "70s"
        fave_decades << (1970..1979)
      elsif e == "80s"
        fave_decades << (1980..1989)
      elsif e == "90s"
        fave_decades << (1990..1999)
      else e == "2000 onwards"
        fave_decades << (2000..2020)
      end
    end
    # e.g. => fave_decades = [1..1969, 1970..1979, 2000..2020]
    if fave_decades.include? (1..2020)   # short circuit 'Any' option
      return
    else

      fave_decades.each do |input_range|
        Film.each do |film|
          if input_range.include?(film[:year])
            film.inc(score: 20)
          end
        end
      end
    end
  end

  def score_rating
    rating_int = self.rating_pref
    # film[:rating] is a float
    # checking users's rating integer in a range and updating score for films that are in that range
    case rating_int
    when (1..3)
      rating_range = (1..3)
    when (4..6)
      rating_range = (4..6)
    when (7..10)
      rating_range = (7..10)
    end

    Film.each do |film|
      if film[:rating] === rating_range
        film.inc(score: 15)
      end
    end
  end

  def score_director
    director_str = self.director_pref
    Film.each do |film|
      if film[:director] == director_str
        film.inc(score: 20)
      end
    end
  end

  def score_keywords
    keyword_str = self.keywords_pref
    keyword_array = keyword_str.split(/\s*,\s*/)
    keyword_array.each do |input_keyword|
      Film.each do |film|
        film[:keywords].each do |k|
          if k == input_keyword
            film.inc(score: 30)
          end
        end
      end
    end
  end

  def score_stars
    stars_str = self.stars_pref
    stars_array = stars_str.split(/\s*,\s*/)
    stars_array.each do |input_star|
      Film.each do |film|
        film[:stars].each do |s|
          if s == input_star
            film.inc(score: 25)
          end
        end
      end
    end
  end

end
