class Repair < ApplicationRecord
  belongs_to :bike
  belongs_to :mechanic, optional: true

  has_many :repair_services, dependent: :destroy
  has_many :services, through: :repair_services

  accepts_nested_attributes_for :repair_services, allow_destroy: true, reject_if: :all_blank

  # Active Storage & Action Text
  has_many_attached :photos do |attachable|
    attachable.variant :thumb, resize_to_fill: [150, 150]
    attachable.variant :large, resize_to_limit: [800, 600]
  end

  has_rich_text :diagnosis

  # Enum de estados (Sintaxis Rails 7)
  enum :status, {
    received: "received",
    quoted: "quoted",
    in_progress: "in_progress",
    ready: "ready",
    delivered: "delivered"
  }

  # Validaciones
  validate :acceptable_photos

  # Método público para saber si está atrasada
  def overdue?
    promised_on.present? && promised_on < Date.current && status != "delivered"
  end

  # Método para calcular el total cobrado
  def total
    repair_services.sum(:price_charged)
  end

  private

  # Validación de tipo y peso de imágenes
  def acceptable_photos
    return unless photos.attached?

    acceptable_types = ["image/jpeg", "image/png", "image/webp"]
    max_size = 5.megabytes

    photos.each do |photo|
      unless acceptable_types.include?(photo.blob.content_type)
        errors.add(:photos, "contiene un archivo no permitido: #{photo.filename} (Solo JPEG/PNG)")
      end

      if photo.blob.byte_size > max_size
        errors.add(:photos, "contiene un archivo demasiado grande: #{photo.filename} (Máximo 5 MB)")
      end
    end
  end
end