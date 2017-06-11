class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
    set_device
    if @device.connected?
      @lightOn = (@device.get("lightOn") == 1)
      render '/home'
    else
      @error_message ||= 'The device is not connected!'
      render '/error'
    end
  end

  def toggle
    set_device
    if @device.connected?
      @device.call("toggleLight")
    else
      @error_message ||= 'The device is not connected!'
      render '/error'
    end
  end

  private

  def set_device
    begin
      @device = Particle.device('pat-photon')
      @device.get_attributes
    rescue Particle::Error => error
      @error_message ||= error.response.body[:error_description]
    end
  end

end
