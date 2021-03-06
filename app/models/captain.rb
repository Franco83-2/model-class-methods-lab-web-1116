class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: {name: "Catamaran" })
  end

  def self.sailors
    self.joins(boats: :classifications).where(classifications: {name: "Sailboat" }).uniq
  end

  def self.talented_seamen
    where(name: self.sailors.pluck(:name) & self.motorboats.pluck(:name))
  end

  def self.motorboats
    self.joins(boats: :classifications).where(classifications: {name: "Motorboat" }).uniq
  end

  def self.non_sailors
    where.not(name: self.sailors.pluck(:name))
  end

end
