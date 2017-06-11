class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
    set_device
    @lightOn = (@device.get("lightOn") == 1)
    render '/home'
  end

  def toggle
    set_device
    @device.call("toggleLight")
  end

  private

  def set_device
    @device = Particle.device('pat-photon')
    @device.get_attributes
  end

end
