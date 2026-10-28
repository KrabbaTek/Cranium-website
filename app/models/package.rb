class Package < ApplicationRecord
  # technically we could allow multiple packages to share a name,
  # but I don't like how messy and ambiguous that becomes.
  validates :name, presence: true, uniqueness: true

  # I made this unique to prevent people from just copying and pasting the same prompt for each package.
  validates :description, presence: true, uniqueness: true, length: { minimum: 96, maximum: 1704 }

  # ensures the given string is actually a link
  # since it has to be a GitHub url we could make our own regex but this works for now
  # TODO do that ^^^
  validates :github_url, presence: true, uniqueness: true, format: { with: URI.regexp(%w[http https]) }

  belongs_to :user
end
