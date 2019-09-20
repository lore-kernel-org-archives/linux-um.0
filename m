Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBKDU-0005rd-25
 for linux-um@lists.infradead.org; Fri, 20 Sep 2019 14:49:04 +0000
Subject: Re: linux-image-5.2.0-2-amd64: breaks UML all versions, both debian
 stock and compiled from source.
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
References: <156897436056.2001.10040310871991691509.reportbug@sleer.kot.begemot.co.uk>
Message-ID: <ded0fc52-3631-375f-e4b5-c18e93777c4f@kot-begemot.co.uk>
Date: Fri, 20 Sep 2019 15:48:53 +0100
MIME-Version: 1.0
In-Reply-To: <156897436056.2001.10040310871991691509.reportbug@sleer.kot.begemot.co.uk>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Debian Bug Tracking System <submit@bugs.debian.org>
Cc: linux-um@lists.infradead.org

These are the Start (that is what sbrk(0) returns) and &_end values I 
get for the two kernels:

Linux 4.19 on host - Start 1645867008 end 1631412224 diff 14454784

Linux 5.2 on host - Start 93825006145536 end 1631412224 diff 93823374733312

I think the whole logic in UML here is broken because with memory model 
= large &_end is less than start to start off with so reserving XM gap 
does not quite make sense.

I am going to see if I can sort out the UML side, but I think we still 
need to check the host kernel side and what is reason for the sudden 
change in behavior.

A.

On 20/09/2019 11:12, Anton Ivanov wrote:
> Package: src:linux
> Version: 5.2.9-2
> Severity: important
>
> Dear Maintainer,
>
> Any attempt to run UML on a machine running 5.2.9-2 results in:
>
> Adding 93823388884992 bytes to physical memory to account for exec-shield gap
> Too few physical memory! Needed=93823417974784, given=547037904896
>
> Running the same UML images on 4.19 debian stock has no issues.
>
> A.
>
> -- Package-specific info:
> ** Version:
> Linux version 5.2.0-2-amd64 (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-21)) #1 SMP Debian 5.2.9-2 (2019-08-21)
>
> ** Command line:
> BOOT_IMAGE=/boot/vmlinuz-5.2.0-2-amd64 root=UUID=8eb17efb-6574-42d0-885e-487b98364059 ro mitigations=off noht quiet
>
> ** Not tainted
>
> ** Kernel log:
> [    3.684402] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/sound/card0/input8
> [    3.684490] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/sound/card0/input9
> [    3.684555] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/sound/card0/input10
> [    3.685553] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/sound/card0/input11
> [    3.685627] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/sound/card0/input12
> [    3.806626] kvm: Nested Virtualization enabled
> [    3.806636] kvm: Nested Paging enabled
> [    3.806637] SVM: Virtual VMLOAD VMSAVE supported
> [    3.806637] SVM: Virtual GIF supported
> [    3.820371] MCE: In-kernel MCE decoding enabled.
> [    3.824533] EDAC amd64: Node 0: DRAM ECC disabled.
> [    3.824536] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    3.872569] pktcdvd: pktcdvd0: writer mapped to sr0
> [    3.900858] EDAC amd64: Node 0: DRAM ECC disabled.
> [    3.900860] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    3.948661] EDAC amd64: Node 0: DRAM ECC disabled.
> [    3.948662] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    3.996651] EDAC amd64: Node 0: DRAM ECC disabled.
> [    3.996652] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    4.002382] audit: type=1400 audit(1568973482.655:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=706 comm="apparmor_parser"
> [    4.002712] audit: type=1400 audit(1568973482.655:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=701 comm="apparmor_parser"
> [    4.005254] audit: type=1400 audit(1568973482.659:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oopslash" pid=699 comm="apparmor_parser"
> [    4.007555] audit: type=1400 audit(1568973482.659:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=702 comm="apparmor_parser"
> [    4.007558] audit: type=1400 audit(1568973482.659:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=702 comm="apparmor_parser"
> [    4.011004] audit: type=1400 audit(1568973482.663:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=709 comm="apparmor_parser"
> [    4.011007] audit: type=1400 audit(1568973482.663:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=709 comm="apparmor_parser"
> [    4.011009] audit: type=1400 audit(1568973482.663:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=709 comm="apparmor_parser"
> [    4.012542] audit: type=1400 audit(1568973482.667:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/ntpd" pid=705 comm="apparmor_parser"
> [    4.052465] EDAC amd64: Node 0: DRAM ECC disabled.
> [    4.052466] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    4.132680] EDAC amd64: Node 0: DRAM ECC disabled.
> [    4.132682] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    4.144991] new mount options do not match the existing superblock, will be ignored
> [    4.192879] EDAC amd64: Node 0: DRAM ECC disabled.
> [    4.192880] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    4.193837] fuse: init (API version 7.31)
> [    4.252733] EDAC amd64: Node 0: DRAM ECC disabled.
> [    4.252735] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    4.320692] EDAC amd64: Node 0: DRAM ECC disabled.
> [    4.320694] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    4.376606] EDAC amd64: Node 0: DRAM ECC disabled.
> [    4.376607] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    4.432461] EDAC amd64: Node 0: DRAM ECC disabled.
> [    4.432462] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    4.508617] EDAC amd64: Node 0: DRAM ECC disabled.
> [    4.508618] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>                  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>                  (Note that use of the override may cause unknown side effects.)
> [    4.556977] WARNING! power/level is deprecated; use power/control instead
> [    4.563794] usblp 3-3:1.0: usblp0: USB Bidirectional printer dev 4 if 0 alt 0 proto 2 vid 0x03F0 pid 0x0B2A
> [    4.563822] usbcore: registered new interface driver usblp
> [    6.748722] igb 0000:06:00.1 enp6s0f1: igb: enp6s0f1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> [    6.749170] IPv6: ADDRCONF(NETDEV_CHANGE): enp6s0f1: link becomes ready
> [    7.590037] 8021q: 802.1Q VLAN Support v1.8
> [    7.590048] 8021q: adding VLAN 0 to HW filter on device enp6s0f1
> [    7.711673] IPv6: ADDRCONF(NETDEV_CHANGE): p-veth0: link becomes ready
> [    7.761697] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> [    7.764549] lxc-bridge0: port 1(enp6s0f1.504) entered blocking state
> [    7.764551] lxc-bridge0: port 1(enp6s0f1.504) entered disabled state
> [    7.764643] device enp6s0f1.504 entered promiscuous mode
> [    7.764643] device enp6s0f1 entered promiscuous mode
> [    7.767790] lxc-bridge0: port 1(enp6s0f1.504) entered blocking state
> [    7.767791] lxc-bridge0: port 1(enp6s0f1.504) entered forwarding state
> [    7.956058] FS-Cache: Loaded
> [    7.987348] FS-Cache: Netfs 'nfs' registered for caching
> [    7.990831] Key type dns_resolver registered
> [    8.001096] kauditd_printk_skb: 23 callbacks suppressed
> [    8.001097] audit: type=1400 audit(1568973486.655:34): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="/usr/bin/lxc-start" pid=1231 comm="apparmor_parser"
> [    8.011932] audit: type=1400 audit(1568973486.663:35): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="lxc-container-default" pid=1235 comm="apparmor_parser"
> [    8.011935] audit: type=1400 audit(1568973486.663:36): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="lxc-container-default-cgns" pid=1235 comm="apparmor_parser"
> [    8.011938] audit: type=1400 audit(1568973486.663:37): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="lxc-container-default-with-mounting" pid=1235 comm="apparmor_parser"
> [    8.011940] audit: type=1400 audit(1568973486.663:38): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="lxc-container-default-with-nesting" pid=1235 comm="apparmor_parser"
> [    8.109159] NFS: Registering the id_resolver key type
> [    8.109167] Key type id_resolver registered
> [    8.109167] Key type id_legacy registered
> [    8.792061] IPv6: ADDRCONF(NETDEV_CHANGE): lxc-bridge0: link becomes ready
> [    9.633488] usblp0: removed
> [    9.634376] usblp 3-3:1.0: usblp0: USB Bidirectional printer dev 4 if 0 alt 0 proto 2 vid 0x03F0 pid 0x0B2A
>
> ** Model information
> sys_vendor: System manufacturer
> product_name: System Product Name
> product_version: System Version
> chassis_vendor: Default string
> chassis_version: Default string
> bios_vendor: American Megatrends Inc.
> bios_version: 1814
> board_vendor: ASUSTeK COMPUTER INC.
> board_name: PRIME B450M-A
> board_version: Rev X.0x
>
> ** Loaded modules:
> snd_hrtimer
> snd_seq_midi
> snd_seq_midi_event
> snd_rawmidi
> snd_seq
> snd_seq_device
> nfsv3
> nfs_acl
> rpcsec_gss_krb5
> auth_rpcgss
> nfsv4
> dns_resolver
> nf_tables
> nfs
> nfnetlink
> lockd
> grace
> fscache
> bridge
> veth
> 8021q
> garp
> stp
> mrp
> llc
> usblp
> fuse
> binfmt_misc
> nls_ascii
> nls_cp437
> vfat
> fat
> pktcdvd
> edac_mce_amd
> kvm_amd
> kvm
> irqbypass
> crct10dif_pclmul
> crc32_pclmul
> ghash_clmulni_intel
> snd_hda_codec_realtek
> joydev
> snd_hda_codec_generic
> ledtrig_audio
> snd_hda_intel
> snd_hda_codec
> snd_hda_core
> efi_pstore
> snd_hwdep
> snd_pcm_oss
> snd_mixer_oss
> snd_pcm
> aesni_intel
> snd_timer
> snd
> eeepc_wmi
> asus_wmi
> aes_x86_64
> crypto_simd
> sparse_keymap
> cryptd
> soundcore
> glue_helper
> rfkill
> k10temp
> efivars
> sp5100_tco
> wmi_bmof
> pcspkr
> sg
> watchdog
> ccp
> rng_core
> evdev
> pcc_cpufreq
> acpi_cpufreq
> parport_pc
> ppdev
> sunrpc
> lp
> parport
> efivarfs
> ip_tables
> x_tables
> autofs4
> ext4
> crc16
> mbcache
> jbd2
> crc32c_generic
> sr_mod
> sd_mod
> cdrom
> hid_generic
> usbhid
> hid
> nouveau
> mxm_wmi
> video
> ttm
> drm_kms_helper
> ahci
> libahci
> xhci_pci
> drm
> xhci_hcd
> libata
> igb
> usbcore
> scsi_mod
> crc32c_intel
> dca
> ptp
> i2c_piix4
> pps_core
> i2c_algo_bit
> usb_common
> wmi
> gpio_amdpt
> gpio_generic
> button
>
> ** Network interface configuration:
> *** /etc/network/interfaces:
>
> source /etc/network/interfaces.d/*
>
> auto lo
> iface lo inet loopback
>
> allow-hotplug enp6s0f1
> iface enp6s0f1 inet static
>          address 192.168.3.72
>          netmask 255.255.255.0
>          gateway 192.168.3.1
>
> auto enp6s0f1.502
> iface enp6s0f1.502 inet static
>          address 192.168.20.1
>          netmask 255.255.255.192
>
> auto enp6s0f1.504
> iface enp6s0f1.504 inet manual
>
> auto l-veth0
> iface l-veth0 inet static
>          address 192.168.97.1
>          netmask 255.255.255.252
>          broadcast 192.168.97.3
>          pre-up ip link add l-veth0 type veth peer name p-veth0 && ifconfig p-veth0 up
>
> auto lxc-bridge0
> iface lxc-bridge0 inet static
>          address 192.168.2.254
>          netmask 255.255.255.0
>          broadcast 192.168.2.255
>          bridge_ports enp6s0f1.504
>
>
> ** Network status:
> *** IP interfaces and addresses:
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>      inet 127.0.0.1/8 scope host lo
>         valid_lft forever preferred_lft forever
>      inet6 ::1/128 scope host
>         valid_lft forever preferred_lft forever
> 2: enp6s0f0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
>      link/ether 6c:b3:11:1b:db:e6 brd ff:ff:ff:ff:ff:ff
> 3: enp6s0f1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
>      link/ether 6c:b3:11:1b:db:e7 brd ff:ff:ff:ff:ff:ff
>      inet 192.168.3.72/24 brd 192.168.3.255 scope global enp6s0f1
>         valid_lft forever preferred_lft forever
>      inet6 fe80::6eb3:11ff:fe1b:dbe7/64 scope link
>         valid_lft forever preferred_lft forever
> 4: enp6s0f1.502@enp6s0f1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>      link/ether 6c:b3:11:1b:db:e7 brd ff:ff:ff:ff:ff:ff
>      inet 192.168.20.1/26 brd 192.168.20.63 scope global enp6s0f1.502
>         valid_lft forever preferred_lft forever
>      inet6 fe80::6eb3:11ff:fe1b:dbe7/64 scope link
>         valid_lft forever preferred_lft forever
> 5: enp6s0f1.504@enp6s0f1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master lxc-bridge0 state UP group default qlen 1000
>      link/ether 6c:b3:11:1b:db:e7 brd ff:ff:ff:ff:ff:ff
> 6: p-veth0@l-veth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>      link/ether 4a:39:de:0f:40:38 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::4839:deff:fe0f:4038/64 scope link
>         valid_lft forever preferred_lft forever
> 7: l-veth0@p-veth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>      link/ether c6:ae:6b:0c:ab:64 brd ff:ff:ff:ff:ff:ff
>      inet 192.168.97.1/30 brd 192.168.97.3 scope global l-veth0
>         valid_lft forever preferred_lft forever
>      inet6 fe80::c4ae:6bff:fe0c:ab64/64 scope link
>         valid_lft forever preferred_lft forever
> 8: lxc-bridge0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>      link/ether 6c:b3:11:1b:db:e7 brd ff:ff:ff:ff:ff:ff
>      inet 192.168.2.254/24 brd 192.168.2.255 scope global lxc-bridge0
>         valid_lft forever preferred_lft forever
>      inet6 fe80::6eb3:11ff:fe1b:dbe7/64 scope link
>         valid_lft forever preferred_lft forever
>
> *** Device statistics:
> Inter-|   Receive                                                |  Transmit
>   face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
> enp6s0f0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
> enp6s0f1:  907555    6894    0   16    0     0          0       573   785451    4990    0    0    0     0       0          0
> lxc-bridge0:     443       5    0    0    0     0          0         0    30853      81    0    0    0     0       0          0
>      lo:  254937    1397    0    0    0     0          0         0   254937    1397    0    0    0     0       0          0
> enp6s0f1.502:    1228      19    0    0    0     0          0         2    31458      83    0    0    0     0       0          0
> p-veth0:   25285      75    0    0    0     0          0         0    15989      43    0    0    0     0       0          0
> l-veth0:   15989      43    0    0    0     0          0         0    25285      75    0    0    0     0       0          0
> enp6s0f1.504:     443       5    0    0    0     0          0         1    31033      83    0    0    0     0       0          0
>
> *** Protocol statistics:
> Ip:
>      Forwarding: 2
>      6052 total packets received
>      0 forwarded
>      0 incoming packets discarded
>      5963 incoming packets delivered
>      4834 requests sent out
>      20 dropped because of missing route
> Icmp:
>      5 ICMP messages received
>      0 input ICMP message failed
>      ICMP input histogram:
>          destination unreachable: 3
>          echo requests: 2
>      8 ICMP messages sent
>      0 ICMP messages failed
>      ICMP output histogram:
>          destination unreachable: 6
>          echo replies: 2
> IcmpMsg:
>          InType3: 3
>          InType8: 2
>          OutType0: 2
>          OutType3: 6
> Tcp:
>      47 active connection openings
>      11 passive connection openings
>      0 failed connection attempts
>      4 connection resets received
>      4 connections established
>      6819 segments received
>      5600 segments sent out
>      0 segments retransmitted
>      0 bad segments received
>      20 resets sent
> Udp:
>      464 packets received
>      3 packets to unknown port received
>      0 packet receive errors
>      626 packets sent
>      0 receive buffer errors
>      0 send buffer errors
>      IgnoredMulti: 9
> UdpLite:
> TcpExt:
>      29 TCP sockets finished time wait in fast timer
>      106 delayed acks sent
>      2806 packet headers predicted
>      181 acknowledgments not containing data payload received
>      3349 predicted acknowledgments
>      TCPBacklogCoalesce: 2
>      9 connections reset due to unexpected data
>      2 connections reset due to early user close
>      TCPRcvCoalesce: 210
>      TCPAutoCorking: 49
>      TCPOrigDataSent: 3811
>      TCPHystartTrainDetect: 3
>      TCPHystartTrainCwnd: 55
>      TCPKeepAlive: 3
>      TCPDelivered: 3858
> IpExt:
>      InMcastPkts: 153
>      OutMcastPkts: 149
>      InBcastPkts: 25
>      OutBcastPkts: 13
>      InOctets: 832699
>      OutOctets: 691798
>      InMcastOctets: 61049
>      OutMcastOctets: 60568
>      InBcastOctets: 2229
>      OutBcastOctets: 1009
>      InNoECTPkts: 6154
>
>
> ** PCI devices:
> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Root Complex [1022:1450]
> 	Subsystem: ASUSTeK Computer Inc. Family 17h (Models 00h-0fh) Root Complex [1043:8747]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) I/O Memory Management Unit [1022:1451]
> 	Subsystem: ASUSTeK Computer Inc. Family 17h (Models 00h-0fh) I/O Memory Management Unit [1043:8747]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin ? routed to IRQ 25
> 	Capabilities: <access denied>
>
> 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:01.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) PCIe GPP Bridge [1022:1453] (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin ? routed to IRQ 26
> 	Bus: primary=00, secondary=01, subordinate=06, sec-latency=0
> 	I/O behind bridge: 0000f000-0000ffff
> 	Memory behind bridge: f5400000-f65fffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>
> 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) PCIe GPP Bridge [1022:1453] (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin ? routed to IRQ 27
> 	Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
> 	I/O behind bridge: 0000e000-0000efff
> 	Memory behind bridge: f2000000-f50fffff
> 	Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>
> 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454] (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 28
> 	Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
> 	Memory behind bridge: f6700000-f69fffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>
> 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454] (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 30
> 	Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
> 	Memory behind bridge: f6a00000-f6afffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>
> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 59)
> 	Subsystem: ASUSTeK Computer Inc. FCH SMBus Controller [1043:8747]
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Kernel driver in use: piix4_smbus
> 	Kernel modules: i2c_piix4, sp5100_tco
>
> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
> 	Subsystem: ASUSTeK Computer Inc. FCH LPC Bridge [1043:8747]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
>
> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Kernel driver in use: k10temp
> 	Kernel modules: k10temp
>
> 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Data Fabric: Device 18h; Function 6 [1022:1466]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> 01:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset USB 3.1 XHCI Controller [1022:43d5] (rev 01) (prog-if 30 [XHCI])
> 	Subsystem: ASMedia Technology Inc. 400 Series Chipset USB 3.1 XHCI Controller [1b21:1142]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 65
> 	Region 0: Memory at f65a0000 (64-bit, non-prefetchable) [size=32K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: xhci_hcd
> 	Kernel modules: xhci_pci
>
> 01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset SATA Controller [1022:43c8] (rev 01) (prog-if 01 [AHCI 1.0])
> 	Subsystem: ASMedia Technology Inc. 400 Series Chipset SATA Controller [1b21:1062]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin B routed to IRQ 47
> 	Region 5: Memory at f6580000 (32-bit, non-prefetchable) [size=128K]
> 	Expansion ROM at f6500000 [disabled] [size=512K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: ahci
> 	Kernel modules: ahci
>
> 01:00.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Bridge [1022:43c6] (rev 01) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin C routed to IRQ 32
> 	Bus: primary=01, secondary=02, subordinate=06, sec-latency=0
> 	I/O behind bridge: 0000f000-0000ffff
> 	Memory behind bridge: f5400000-f64fffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>
> 02:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Port [1022:43c7] (rev 01) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 33
> 	Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>
> 02:04.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Port [1022:43c7] (rev 01) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 34
> 	Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>
> 02:05.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Port [1022:43c7] (rev 01) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 36
> 	Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>
> 02:06.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Port [1022:43c7] (rev 01) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 37
> 	Bus: primary=02, secondary=06, subordinate=06, sec-latency=0
> 	I/O behind bridge: 0000f000-0000ffff
> 	Memory behind bridge: f5400000-f64fffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>
> 06:00.0 Ethernet controller [0200]: Intel Corporation 82576 Gigabit Network Connection [8086:10c9] (rev 01)
> 	Subsystem: Intel Corporation Gigabit ET Dual Port Server Adapter [8086:a03c]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 31
> 	Region 0: Memory at f6420000 (32-bit, non-prefetchable) [size=128K]
> 	Region 1: Memory at f6000000 (32-bit, non-prefetchable) [size=4M]
> 	Region 2: I/O ports at f020 [disabled] [size=32]
> 	Region 3: Memory at f6444000 (32-bit, non-prefetchable) [size=16K]
> 	Expansion ROM at f5c00000 [disabled] [size=4M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: igb
> 	Kernel modules: igb
>
> 06:00.1 Ethernet controller [0200]: Intel Corporation 82576 Gigabit Network Connection [8086:10c9] (rev 01)
> 	Subsystem: Intel Corporation Gigabit ET Dual Port Server Adapter [8086:a03c]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin B routed to IRQ 70
> 	Region 0: Memory at f6400000 (32-bit, non-prefetchable) [size=128K]
> 	Region 1: Memory at f5800000 (32-bit, non-prefetchable) [size=4M]
> 	Region 2: I/O ports at f000 [disabled] [size=32]
> 	Region 3: Memory at f6440000 (32-bit, non-prefetchable) [size=16K]
> 	Expansion ROM at f5400000 [disabled] [size=4M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: igb
> 	Kernel modules: igb
>
> 07:00.0 VGA compatible controller [0300]: NVIDIA Corporation G86 [Quadro NVS 290] [10de:042f] (rev a1) (prog-if 00 [VGA controller])
> 	Subsystem: NVIDIA Corporation G86 [Quadro NVS 290] [10de:0492]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 67
> 	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=16M]
> 	Region 1: Memory at e0000000 (64-bit, prefetchable) [size=256M]
> 	Region 3: Memory at f2000000 (64-bit, non-prefetchable) [size=32M]
> 	Region 5: I/O ports at e000 [size=128]
> 	Expansion ROM at 000c0000 [disabled] [size=128K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: nouveau
> 	Kernel modules: nouveau
>
> 08:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Zeppelin/Raven/Raven2 PCIe Dummy Function [1022:145a]
> 	Subsystem: ASUSTeK Computer Inc. Zeppelin/Raven/Raven2 PCIe Dummy Function [1043:8747]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Capabilities: <access denied>
>
> 08:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) Platform Security Processor [1022:1456]
> 	Subsystem: ASUSTeK Computer Inc. Family 17h (Models 00h-0fh) Platform Security Processor [1043:8747]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin B routed to IRQ 80
> 	Region 2: Memory at f6800000 (32-bit, non-prefetchable) [size=1M]
> 	Region 5: Memory at f6900000 (32-bit, non-prefetchable) [size=8K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: ccp
> 	Kernel modules: ccp
>
> 08:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) USB 3.0 Host Controller [1022:145c] (prog-if 30 [XHCI])
> 	Subsystem: ASUSTeK Computer Inc. Family 17h (Models 00h-0fh) USB 3.0 Host Controller [1043:8747]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin C routed to IRQ 69
> 	Region 0: Memory at f6700000 (64-bit, non-prefetchable) [size=1M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: xhci_hcd
> 	Kernel modules: xhci_pci
>
> 09:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Zeppelin/Renoir PCIe Dummy Function [1022:1455]
> 	Subsystem: ASUSTeK Computer Inc. Zeppelin/Renoir PCIe Dummy Function [1043:8747]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Capabilities: <access denied>
>
> 09:00.2 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51) (prog-if 01 [AHCI 1.0])
> 	Subsystem: ASUSTeK Computer Inc. FCH SATA Controller [AHCI mode] [1043:8747]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin B routed to IRQ 49
> 	Region 5: Memory at f6a08000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: ahci
> 	Kernel modules: ahci
>
> 09:00.3 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) HD Audio Controller [1022:1457]
> 	Subsystem: ASUSTeK Computer Inc. Family 17h (Models 00h-0fh) HD Audio Controller [1043:86c7]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin C routed to IRQ 84
> 	Region 0: Memory at f6a00000 (32-bit, non-prefetchable) [size=32K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: snd_hda_intel
> 	Kernel modules: snd_hda_intel
>
>
> ** USB devices:
> Bus 004 Device 002: ID 05e3:0612 Genesys Logic, Inc. Hub
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 005: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
> Bus 003 Device 004: ID 03f0:0b2a HP, Inc
> Bus 003 Device 003: ID 1bcf:0005 Sunplus Innovation Technology Inc. Optical Mouse
> Bus 003 Device 002: ID 046d:c31b Logitech, Inc. Compact Keyboard K300
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>
>
> -- System Information:
> Debian Release: 10.1
>    APT prefers stable-updates
>    APT policy: (500, 'stable-updates'), (500, 'stable')
> Architecture: amd64 (x86_64)
>
> Kernel: Linux 5.2.0-2-amd64 (SMP w/12 CPU cores)
> Locale: LANG=en_GB.UTF-8, LC_CTYPE=en_GB.UTF-8 (charmap=UTF-8), LANGUAGE=en_GB:en (charmap=UTF-8)
> Shell: /bin/sh linked to /bin/dash
> Init: systemd (via /run/systemd/system)
> LSM: AppArmor: enabled
>
> Versions of packages linux-image-5.2.0-2-amd64 depends on:
> ii  initramfs-tools [linux-initramfs-tool]  0.133+deb10u1
> ii  kmod                                    26-1
> ii  linux-base                              4.6
>
> Versions of packages linux-image-5.2.0-2-amd64 recommends:
> ii  apparmor             2.13.2-10
> ii  firmware-linux-free  3.4
>
> Versions of packages linux-image-5.2.0-2-amd64 suggests:
> pn  debian-kernel-handbook  <none>
> ii  grub-pc                 2.02+dfsg1-20
> pn  linux-doc-5.2           <none>
>
> Versions of packages linux-image-5.2.0-2-amd64 is related to:
> ii  firmware-amd-graphics     20190114-2
> pn  firmware-atheros          <none>
> pn  firmware-bnx2             <none>
> pn  firmware-bnx2x            <none>
> pn  firmware-brcm80211        <none>
> pn  firmware-cavium           <none>
> pn  firmware-intel-sound      <none>
> pn  firmware-intelwimax       <none>
> pn  firmware-ipw2x00          <none>
> pn  firmware-ivtv             <none>
> ii  firmware-iwlwifi          20190114-2
> pn  firmware-libertas         <none>
> ii  firmware-linux-nonfree    20190114-2
> ii  firmware-misc-nonfree     20190114-2
> pn  firmware-myricom          <none>
> pn  firmware-netxen           <none>
> pn  firmware-qlogic           <none>
> ii  firmware-realtek          20190114-2
> pn  firmware-samsung          <none>
> pn  firmware-siano            <none>
> pn  firmware-ti-connectivity  <none>
> pn  xen-hypervisor            <none>
>
> -- no debconf information
>
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

