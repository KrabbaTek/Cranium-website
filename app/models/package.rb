class Package < ApplicationRecord
  # technically we could allow multiple packages to share a name,
  # but I don't like how messy and ambiguous that becomes.
  validates :name, presence: true, uniqueness: true

  # I made this unique to prevent people from just copying and pasting the same prompt for each package.
  validates :description, presence: true, uniqueness: true, length: { minimum: 96, maximum: 1704 }

  validates :github_url, presence: true, format: { with: /github\.com/ }

  belongs_to :user

  has_one_attached :tarball

  validate :tarball_is_tar_gz

  def tarball_is_tar_gz
    if tarball.attached? && !tarball.filename.to_s.end_with?(".tar.gz")
      errors.add(:tarball, "File must be a .tar.gz file")
    end
  end
end
