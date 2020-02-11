# frozen_string_literal: true

module BaseRepository
  def find_by(conditions)
    fetch_relation.where(conditions).limit(1).one
  end

  def find_with(id, includes: [])
    aggregate(*includes).where(id: id).map_to(self.class.entity).one
  end

  def find_by_with(conditions, includes: [])
    aggregate(*includes).where(conditions).map_to(self.class.entity).one
  end

  def all_by(conditions)
    fetch_relation.where(conditions).to_a
  end

  def all_with(id, includes: [])
    aggregate(*includes).where(id: id).map_to(self.class.entity).to_a
  end

  def all_by_with(conditions, includes: [])
    aggregate(*includes).where(conditions).map_to(self.class.entity).to_a
  end

  private

  def fetch_relation
    send(self.class.relation)
  end
end
