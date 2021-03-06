use Mix.Config

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

config :shoehorn,
  init: [:nerves_runtime, :nerves_init_gadget],
  app: Mix.Project.config()[:app]

config :logger, backends: [RingLogger]

config :nerves_firmware_ssh,
  authorized_keys: [
    File.read!(Path.join(System.user_home!, ".ssh/id_rsa.pub"))
  ]

config :logger, backends: [RingLogger]

config :nerves_rpi3_wifi_picam, interface: :wlan0, port: 4001

config :nerves_init_gadget,
  node_name: :target01,
  mdns_domain: "nerves.local",
  address_method: :dhcp,
  ifname: "wlan0"

key_mgmt = System.get_env("NERVES_NETWORK_KEY_MGMT") || "WPA-PSK"

config :nerves_network, :default,
  wlan0: [
    ssid: System.get_env("NERVES_NETWORK_SSID"),
    psk: System.get_env("NERVES_NETWORK_PSK"),
    key_mgmt: String.to_atom(key_mgmt)
  ],
  eth0: [
    ipv4_address_method: :dhcp
  ]
