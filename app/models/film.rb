class Film
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  validates_presence_of :score, :title, :rating, :poster_url, :url, :summary, :director, :year

  # belongs_to :user, inverse_of: :films

  field :score,      type: Integer, default: 0
  field :title,      type: String
  field :genre,      type: Array
  field :rating,     type: Float
  field :summary,    type: String
  field :poster_url, type: String
  field :url,        type: String
  field :director,   type: String
  field :stars,      type: Array
  field :keywords,   type: Array
  field :year,       type: Integer
  # field :user_id, type: Integer

  index({ title: 1 }, { unique: true, name: "title_index" })
  index({ score: 1 }, { name: "score_index" })

  def self.zero_score!
    self.each do |film|
      film.update_attributes(score: 0)
    end
  end
end
