cask "phidget-control-panel" do
  version "22,1.7.20210816"
  sha256 "40dbe2e097e1e0892f5d06dd3b8cffd1bd342619e66e6257e515110fb3c2d8fb"

  url "https://www.phidgets.com/downloads/phidget#{version.before_comma}/libraries/macos/Phidget#{version.before_comma}/Phidget#{version.before_comma}_#{version.after_comma}.dmg"
  name "Phidget Control Panel"
  desc "Libraries and control software for the Phidgets sensing kits"
  homepage "https://www.phidgets.com/"

  livecheck do
    url "https://www.phidgets.com/downloads/phidget#{version.before_comma}/libraries/macos/Phidget#{version.before_comma}.dmg"
    strategy :header_match do |headers|
      match = headers["location"].match(%r{/Phidget(\d+)_(\d+(?:\.\d+)*)\.dmg}i)
      "#{match[1]},#{match[2]}"
    end
  end

  depends_on macos: ">= :el_capitan"

  pkg "Phidgets.pkg"

  uninstall pkgutil: [
    "com.phidgets.phidget#{version.before_comma}java",
    "com.phidgets.phidget#{version.before_comma}extra",
    "com.phidgets.phidget#{version.before_comma}networkserver",
    "com.phidgets.controlpanel#{version.before_comma}",
    "com.phidgets.phidgetframework#{version.before_comma}",
    "com.phidgets.signeddriver",
  ],
            kext:    "com.phidgets.driver.Phidget"

  # A reboot _seems_ to be needed for the driver to be fully functional
  # (device detected, but sensors unreadable otherwise)
  caveats do
    reboot
  end
end
