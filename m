Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9418DC369D9
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jqj3D9HlpLGzpdYciThwd/42PpX8Cr/eTfYx0EImG6E=; b=DD5MCZ8Sk5lseNufSsy6t4h/NZ
	/RU8pq1Mvx3RTeUVqPrIhOsQM8bUQLoSlCgzzq4q8oPH5YqxMIuCUlTmZbTWsqBnqN5scHFZoL50i
	aWVgnRy8LTP6aBiGIs9gAiKCnigTOwbnMVdJS5lPPKMmGR8/4AMZo/WvVXJ88G1nhv561kLQ9uzIr
	Yrt2VlReQyCt/okA8Zxl4bqMo2GrnfMh+BKX0jJnQzdLdBymV/29/V7exvdJ6C8BSkwYuqsnU6YlX
	C5Z3gSG7t50zouXqDbYwLN2GJhvTJLkvsUH98xPqHcPWAe/MOlPdqBanksHm7fP9U9RL4h1l/d3O7
	ZX2lCefg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBCsh-00000003uvL-0umI;
	Sat, 03 May 2025 13:26:15 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBCsc-00000003uuf-2Bp9
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 13:26:13 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1uBCsM-00AMsb-DZ; Sat, 03 May 2025 13:25:55 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1uBCsE-003S5E-33;
	Sat, 03 May 2025 14:25:54 +0100
Message-ID: <336553ef-92da-4710-96c7-d63c74382dd0@cambridgegreys.com>
Date: Sat, 3 May 2025 14:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] um: Remove obsolete legacy network transports
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org
References: <20250503051710.3286595-1-tiwei.btw@antgroup.com>
 <20250503051710.3286595-2-tiwei.btw@antgroup.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20250503051710.3286595-2-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250503_062611_075319_363EF662 
X-CRM114-Status: GOOD (  39.05  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 03/05/2025 06:17, Tiwei Bie wrote:
> These legacy network transports were marked as obsolete in commit
> 40814b98a570 ("um: Mark non-vector net transports as obsolete").
> More than five years have passed since then. Remove these network
> transports to reduce the maintenance burden.
> 
> Suggested-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
>   .../virt/uml/user_mode_linux_howto_v2.rst     |  31 +--
>   arch/um/configs/i386_defconfig                |   6 -
>   arch/um/configs/x86_64_defconfig              |   6 -
>   arch/um/drivers/Kconfig                       | 170 ------------
>   arch/um/drivers/Makefile                      |  18 +-
>   arch/um/drivers/daemon.h                      |  29 --
>   arch/um/drivers/daemon_kern.c                 |  95 -------
>   arch/um/drivers/daemon_user.c                 | 194 --------------
>   arch/um/drivers/slip.h                        |  21 --
>   arch/um/drivers/slip_common.c                 |  55 ----
>   arch/um/drivers/slip_common.h                 | 106 --------
>   arch/um/drivers/slip_kern.c                   |  93 -------
>   arch/um/drivers/slip_user.c                   | 252 ------------------
>   arch/um/drivers/slirp.h                       |  34 ---
>   arch/um/drivers/slirp_kern.c                  | 120 ---------
>   arch/um/drivers/slirp_user.c                  | 124 ---------
>   arch/um/drivers/umcast.h                      |  27 --
>   arch/um/drivers/umcast_kern.c                 | 188 -------------
>   arch/um/drivers/umcast_user.c                 | 184 -------------
>   arch/um/drivers/vde.h                         |  32 ---
>   arch/um/drivers/vde_kern.c                    | 129 ---------
>   arch/um/drivers/vde_user.c                    | 125 ---------
>   arch/um/include/shared/os.h                   |   1 -
>   arch/um/os-Linux/Makefile                     |   2 +-
>   arch/um/os-Linux/drivers/Makefile             |  13 -
>   arch/um/os-Linux/drivers/etap.h               |  21 --
>   arch/um/os-Linux/drivers/ethertap_kern.c      | 100 -------
>   arch/um/os-Linux/drivers/ethertap_user.c      | 248 -----------------
>   arch/um/os-Linux/drivers/tuntap.h             |  21 --
>   arch/um/os-Linux/drivers/tuntap_kern.c        |  86 ------
>   arch/um/os-Linux/drivers/tuntap_user.c        | 215 ---------------
>   arch/um/os-Linux/file.c                       |  15 --
>   32 files changed, 4 insertions(+), 2757 deletions(-)
>   delete mode 100644 arch/um/drivers/daemon.h
>   delete mode 100644 arch/um/drivers/daemon_kern.c
>   delete mode 100644 arch/um/drivers/daemon_user.c
>   delete mode 100644 arch/um/drivers/slip.h
>   delete mode 100644 arch/um/drivers/slip_common.c
>   delete mode 100644 arch/um/drivers/slip_common.h
>   delete mode 100644 arch/um/drivers/slip_kern.c
>   delete mode 100644 arch/um/drivers/slip_user.c
>   delete mode 100644 arch/um/drivers/slirp.h
>   delete mode 100644 arch/um/drivers/slirp_kern.c
>   delete mode 100644 arch/um/drivers/slirp_user.c
>   delete mode 100644 arch/um/drivers/umcast.h
>   delete mode 100644 arch/um/drivers/umcast_kern.c
>   delete mode 100644 arch/um/drivers/umcast_user.c
>   delete mode 100644 arch/um/drivers/vde.h
>   delete mode 100644 arch/um/drivers/vde_kern.c
>   delete mode 100644 arch/um/drivers/vde_user.c
>   delete mode 100644 arch/um/os-Linux/drivers/Makefile
>   delete mode 100644 arch/um/os-Linux/drivers/etap.h
>   delete mode 100644 arch/um/os-Linux/drivers/ethertap_kern.c
>   delete mode 100644 arch/um/os-Linux/drivers/ethertap_user.c
>   delete mode 100644 arch/um/os-Linux/drivers/tuntap.h
>   delete mode 100644 arch/um/os-Linux/drivers/tuntap_kern.c
>   delete mode 100644 arch/um/os-Linux/drivers/tuntap_user.c
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 584000b743f3..60f35ed748b2 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -219,16 +219,6 @@ remote UML and other VM instances.
>   +-----------+--------+------------------------------------+------------+
>   | vde       | vector | dep. on VDE VPN: Virt.Net Locator  | varies     |
>   +-----------+--------+------------------------------------+------------+
> -| tuntap    | legacy | none                               | ~ 500Mbit  |
> -+-----------+--------+------------------------------------+------------+
> -| daemon    | legacy | none                               | ~ 450Mbit  |
> -+-----------+--------+------------------------------------+------------+
> -| socket    | legacy | none                               | ~ 450Mbit  |
> -+-----------+--------+------------------------------------+------------+
> -| ethertap  | legacy | obsolete                           | ~ 500Mbit  |
> -+-----------+--------+------------------------------------+------------+
> -| vde       | legacy | obsolete                           | ~ 500Mbit  |
> -+-----------+--------+------------------------------------+------------+
>   
>   * All transports which have tso and checksum offloads can deliver speeds
>     approaching 10G on TCP streams.
> @@ -236,27 +226,16 @@ remote UML and other VM instances.
>   * All transports which have multi-packet rx and/or tx can deliver pps
>     rates of up to 1Mps or more.
>   
> -* All legacy transports are generally limited to ~600-700MBit and 0.05Mps.
> -
>   * GRE and L2TPv3 allow connections to all of: local machine, remote
>     machines, remote network devices and remote UML instances.
>   
> -* Socket allows connections only between UML instances.
> -
> -* Daemon and bess require running a local switch. This switch may be
> -  connected to the host as well.
> -
>   
>   Network configuration privileges
>   ================================
>   
>   The majority of the supported networking modes need ``root`` privileges.
> -For example, in the legacy tuntap networking mode, users were required
> -to be part of the group associated with the tunnel device.
> -
> -For newer network drivers like the vector transports, ``root`` privilege
> -is required to fire an ioctl to setup the tun interface and/or use
> -raw sockets where needed.
> +For example, for vector transports, ``root`` privilege is required to fire
> +an ioctl to setup the tun interface and/or use raw sockets where needed.
>   
>   This can be achieved by granting the user a particular capability instead
>   of running UML as root.  In case of vector transport, a user can add the
> @@ -610,12 +589,6 @@ connect to a local area cloud (all the UML nodes using the same
>   multicast address running on hosts in the same multicast domain (LAN)
>   will be automagically connected together to a virtual LAN.
>   
> -Configuring Legacy transports
> -=============================
> -
> -Legacy transports are now considered obsolete. Please use the vector
> -versions.
> -
>   ***********
>   Running UML
>   ***********
> diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
> index 1ffa088739f4..7c8999f18f2d 100644
> --- a/arch/um/configs/i386_defconfig
> +++ b/arch/um/configs/i386_defconfig
> @@ -53,12 +53,6 @@ CONFIG_UNIX=y
>   CONFIG_INET=y
>   # CONFIG_IPV6 is not set
>   CONFIG_UML_NET=y
> -CONFIG_UML_NET_ETHERTAP=y
> -CONFIG_UML_NET_TUNTAP=y
> -CONFIG_UML_NET_SLIP=y
> -CONFIG_UML_NET_DAEMON=y
> -CONFIG_UML_NET_MCAST=y
> -CONFIG_UML_NET_SLIRP=y
>   CONFIG_EXT4_FS=y
>   CONFIG_QUOTA=y
>   CONFIG_AUTOFS_FS=m
> diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
> index 03b10d3f6816..9858d989777e 100644
> --- a/arch/um/configs/x86_64_defconfig
> +++ b/arch/um/configs/x86_64_defconfig
> @@ -52,12 +52,6 @@ CONFIG_UNIX=y
>   CONFIG_INET=y
>   # CONFIG_IPV6 is not set
>   CONFIG_UML_NET=y
> -CONFIG_UML_NET_ETHERTAP=y
> -CONFIG_UML_NET_TUNTAP=y
> -CONFIG_UML_NET_SLIP=y
> -CONFIG_UML_NET_DAEMON=y
> -CONFIG_UML_NET_MCAST=y
> -CONFIG_UML_NET_SLIRP=y
>   CONFIG_EXT4_FS=y
>   CONFIG_QUOTA=y
>   CONFIG_AUTOFS_FS=m
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 9cb196070614..5bf4f0f3fd01 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -143,99 +143,6 @@ config UML_NET
>   	  enable at least one of the following transport options to actually
>   	  make use of UML networking.
>   
> -config UML_NET_ETHERTAP
> -	bool "Ethertap transport (obsolete)"
> -	depends on UML_NET
> -	help
> -	  The Ethertap User-Mode Linux network transport allows a single
> -	  running UML to exchange packets with its host over one of the
> -	  host's Ethertap devices, such as /dev/tap0.  Additional running
> -	  UMLs can use additional Ethertap devices, one per running UML.
> -	  While the UML believes it's on a (multi-device, broadcast) virtual
> -	  Ethernet network, it's in fact communicating over a point-to-point
> -	  link with the host.
> -
> -	  To use this, your host kernel must have support for Ethertap
> -	  devices.  Also, if your host kernel is 2.4.x, it must have
> -	  CONFIG_NETLINK_DEV configured as Y or M.
> -
> -	  For more information, see
> -	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
> -	  has examples of the UML command line to use to enable Ethertap
> -	  networking.
> -
> -	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
> -	  migrate to UML_NET_VECTOR.
> -
> -	  If unsure, say N.
> -
> -config UML_NET_TUNTAP
> -	bool "TUN/TAP transport (obsolete)"
> -	depends on UML_NET
> -	help
> -	  The UML TUN/TAP network transport allows a UML instance to exchange
> -	  packets with the host over a TUN/TAP device.  This option will only
> -	  work with a 2.4 host, unless you've applied the TUN/TAP patch to
> -	  your 2.2 host kernel.
> -
> -	  To use this transport, your host kernel must have support for TUN/TAP
> -	  devices, either built-in or as a module.
> -
> -	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
> -	  migrate to UML_NET_VECTOR.
> -
> -	  If unsure, say N.
> -
> -config UML_NET_SLIP
> -	bool "SLIP transport (obsolete)"
> -	depends on UML_NET
> -	help
> -	  The slip User-Mode Linux network transport allows a running UML to
> -	  network with its host over a point-to-point link.  Unlike Ethertap,
> -	  which can carry any Ethernet frame (and hence even non-IP packets),
> -	  the slip transport can only carry IP packets.
> -
> -	  To use this, your host must support slip devices.
> -
> -	  For more information, see
> -	  <http://user-mode-linux.sourceforge.net/old/networking.html>.
> -	  has examples of the UML command line to use to enable slip
> -	  networking, and details of a few quirks with it.
> -
> -	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
> -	  migrate to UML_NET_VECTOR.
> -
> -	  If unsure, say N.
> -
> -config UML_NET_DAEMON
> -	bool "Daemon transport (obsolete)"
> -	depends on UML_NET
> -	help
> -	  This User-Mode Linux network transport allows one or more running
> -	  UMLs on a single host to communicate with each other, but not to
> -	  the host.
> -
> -	  To use this form of networking, you'll need to run the UML
> -	  networking daemon on the host.
> -
> -	  For more information, see
> -	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
> -	  has examples of the UML command line to use to enable Daemon
> -	  networking.
> -
> -	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
> -	  migrate to UML_NET_VECTOR.
> -
> -	  If unsure, say N.
> -
> -config UML_NET_DAEMON_DEFAULT_SOCK
> -	string "Default socket for daemon transport"
> -	default "/tmp/uml.ctl"
> -	depends on UML_NET_DAEMON
> -	help
> -	  This option allows setting the default socket for the daemon
> -	  transport, normally it defaults to /tmp/uml.ctl.
> -
>   config UML_NET_VECTOR
>   	bool "Vector I/O high performance network devices"
>   	depends on UML_NET
> @@ -248,83 +155,6 @@ config UML_NET_VECTOR
>   	  with up to 4 times higher network throughput than the UML network
>   	  drivers.
>   
> -config UML_NET_VDE
> -	bool "VDE transport (obsolete)"
> -	depends on UML_NET
> -	depends on !MODVERSIONS
> -	select MAY_HAVE_RUNTIME_DEPS
> -	help
> -	  This User-Mode Linux network transport allows one or more running
> -	  UMLs on a single host to communicate with each other and also
> -	  with the rest of the world using Virtual Distributed Ethernet,
> -	  an improved fork of uml_switch.
> -
> -	  You must have libvdeplug installed in order to build the vde
> -	  transport into UML.
> -
> -	  To use this form of networking, you will need to run vde_switch
> -	  on the host.
> -
> -	  For more information, see <http://wiki.virtualsquare.org/>
> -	  That site has a good overview of what VDE is and also examples
> -	  of the UML command line to use to enable VDE networking.
> -
> -	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
> -	  migrate to UML_NET_VECTOR.
> -
> -	  If unsure, say N.
> -
> -config UML_NET_MCAST
> -	bool "Multicast transport (obsolete)"
> -	depends on UML_NET
> -	help
> -	  This Multicast User-Mode Linux network transport allows multiple
> -	  UMLs (even ones running on different host machines!) to talk to
> -	  each other over a virtual ethernet network.  However, it requires
> -	  at least one UML with one of the other transports to act as a
> -	  bridge if any of them need to be able to talk to their hosts or any
> -	  other IP machines.
> -
> -	  To use this, your host kernel(s) must support IP Multicasting.
> -
> -	  For more information, see
> -	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
> -	  has examples of the UML command line to use to enable Multicast
> -	  networking, and notes about the security of this approach.
> -
> -	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
> -	  migrate to UML_NET_VECTOR.
> -
> -	  If unsure, say N.
> -
> -config UML_NET_SLIRP
> -	bool "SLiRP transport (obsolete)"
> -	depends on UML_NET
> -	help
> -	  The SLiRP User-Mode Linux network transport allows a running UML
> -	  to network by invoking a program that can handle SLIP encapsulated
> -	  packets.  This is commonly (but not limited to) the application
> -	  known as SLiRP, a program that can re-socket IP packets back onto
> -	  he host on which it is run.  Only IP packets are supported,
> -	  unlike other network transports that can handle all Ethernet
> -	  frames.  In general, slirp allows the UML the same IP connectivity
> -	  to the outside world that the host user is permitted, and unlike
> -	  other transports, SLiRP works without the need of root level
> -	  privileges, setuid binaries, or SLIP devices on the host.  This
> -	  also means not every type of connection is possible, but most
> -	  situations can be accommodated with carefully crafted slirp
> -	  commands that can be passed along as part of the network device's
> -	  setup string.  The effect of this transport on the UML is similar
> -	  that of a host behind a firewall that masquerades all network
> -	  connections passing through it (but is less secure).
> -
> -	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
> -	  migrate to UML_NET_VECTOR.
> -
> -	  If unsure, say N.
> -
> -	  Startup example: "eth0=slirp,FE:FD:01:02:03:04,/usr/local/bin/slirp"
> -
>   endmenu
>   
>   config VIRTIO_UML
> diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
> index 0a5820343ad3..d0608850833c 100644
> --- a/arch/um/drivers/Makefile
> +++ b/arch/um/drivers/Makefile
> @@ -6,11 +6,7 @@
>   # pcap is broken in 2.5 because kbuild doesn't allow pcap.a to be linked
>   # in to pcap.o
>   
> -slip-objs := slip_kern.o slip_user.o
> -slirp-objs := slirp_kern.o slirp_user.o
> -daemon-objs := daemon_kern.o daemon_user.o
>   vector-objs := vector_kern.o vector_user.o vector_transports.o
> -umcast-objs := umcast_kern.o umcast_user.o
>   net-objs := net_kern.o net_user.o
>   mconsole-objs := mconsole_kern.o mconsole_user.o
>   hostaudio-objs := hostaudio_kern.o
> @@ -20,13 +16,6 @@ harddog-objs := harddog_kern.o
>   harddog-builtin-$(CONFIG_UML_WATCHDOG) := harddog_user.o harddog_user_exp.o
>   rtc-objs := rtc_kern.o rtc_user.o
>   
> -LDFLAGS_vde.o = $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
> -
> -targets := vde_kern.o vde_user.o
> -
> -$(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
> -	$(LD) -r -dp -o $@ $^ $(ld_flags)
> -
>   #XXX: The call below does not work because the flags are added before the
>   # object name, so nothing from the library gets linked.
>   #$(call if_changed,ld)
> @@ -38,12 +27,7 @@ obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
>   obj-$(CONFIG_SSL) += ssl.o
>   obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
>   
> -obj-$(CONFIG_UML_NET_SLIP) += slip.o slip_common.o
> -obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
> -obj-$(CONFIG_UML_NET_DAEMON) += daemon.o
>   obj-$(CONFIG_UML_NET_VECTOR) += vector.o
> -obj-$(CONFIG_UML_NET_VDE) += vde.o
> -obj-$(CONFIG_UML_NET_MCAST) += umcast.o
>   obj-$(CONFIG_UML_NET) += net.o
>   obj-$(CONFIG_MCONSOLE) += mconsole.o
>   obj-$(CONFIG_MMAPPER) += mmapper_kern.o
> @@ -64,7 +48,7 @@ obj-$(CONFIG_UML_PCI) += virt-pci.o
>   obj-$(CONFIG_UML_PCI_OVER_VIRTIO) += virtio_pcidev.o
>   
>   # pcap_user.o must be added explicitly.
> -USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o vde_user.o vector_user.o
> +USER_OBJS := fd.o null.o pty.o tty.o xterm.o vector_user.o
>   CFLAGS_null.o = -DDEV_NULL=$(DEV_NULL_PATH)
>   
>   CFLAGS_xterm.o += '-DCONFIG_XTERM_CHAN_DEFAULT_EMULATOR="$(CONFIG_XTERM_CHAN_DEFAULT_EMULATOR)"'
> diff --git a/arch/um/drivers/daemon.h b/arch/um/drivers/daemon.h
> deleted file mode 100644
> index 1509cc7eb907..000000000000
> --- a/arch/um/drivers/daemon.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#ifndef __DAEMON_H__
> -#define __DAEMON_H__
> -
> -#include <net_user.h>
> -
> -#define SWITCH_VERSION 3
> -
> -struct daemon_data {
> -	char *sock_type;
> -	char *ctl_sock;
> -	void *ctl_addr;
> -	void *data_addr;
> -	void *local_addr;
> -	int fd;
> -	int control;
> -	void *dev;
> -};
> -
> -extern const struct net_user_info daemon_user_info;
> -
> -extern int daemon_user_write(int fd, void *buf, int len,
> -			     struct daemon_data *pri);
> -
> -#endif
> diff --git a/arch/um/drivers/daemon_kern.c b/arch/um/drivers/daemon_kern.c
> deleted file mode 100644
> index afde1e82c056..000000000000
> --- a/arch/um/drivers/daemon_kern.c
> +++ /dev/null
> @@ -1,95 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
> - * James Leu (jleu@mindspring.net).
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - * Copyright (C) 2001 by various other people who didn't put their name here.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/netdevice.h>
> -#include <net_kern.h>
> -#include "daemon.h"
> -
> -struct daemon_init {
> -	char *sock_type;
> -	char *ctl_sock;
> -};
> -
> -static void daemon_init(struct net_device *dev, void *data)
> -{
> -	struct uml_net_private *pri;
> -	struct daemon_data *dpri;
> -	struct daemon_init *init = data;
> -
> -	pri = netdev_priv(dev);
> -	dpri = (struct daemon_data *) pri->user;
> -	dpri->sock_type = init->sock_type;
> -	dpri->ctl_sock = init->ctl_sock;
> -	dpri->fd = -1;
> -	dpri->control = -1;
> -	dpri->dev = dev;
> -	/* We will free this pointer. If it contains crap we're burned. */
> -	dpri->ctl_addr = NULL;
> -	dpri->data_addr = NULL;
> -	dpri->local_addr = NULL;
> -
> -	printk("daemon backend (uml_switch version %d) - %s:%s",
> -	       SWITCH_VERSION, dpri->sock_type, dpri->ctl_sock);
> -	printk("\n");
> -}
> -
> -static int daemon_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return net_recvfrom(fd, skb_mac_header(skb),
> -			    skb->dev->mtu + ETH_HEADER_OTHER);
> -}
> -
> -static int daemon_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return daemon_user_write(fd, skb->data, skb->len,
> -				 (struct daemon_data *) &lp->user);
> -}
> -
> -static const struct net_kern_info daemon_kern_info = {
> -	.init			= daemon_init,
> -	.protocol		= eth_protocol,
> -	.read			= daemon_read,
> -	.write			= daemon_write,
> -};
> -
> -static int daemon_setup(char *str, char **mac_out, void *data)
> -{
> -	struct daemon_init *init = data;
> -	char *remain;
> -
> -	*init = ((struct daemon_init)
> -		{ .sock_type 		= "unix",
> -		  .ctl_sock 		= CONFIG_UML_NET_DAEMON_DEFAULT_SOCK });
> -
> -	remain = split_if_spec(str, mac_out, &init->sock_type, &init->ctl_sock,
> -			       NULL);
> -	if (remain != NULL)
> -		printk(KERN_WARNING "daemon_setup : Ignoring data socket "
> -		       "specification\n");
> -
> -	return 1;
> -}
> -
> -static struct transport daemon_transport = {
> -	.list 		= LIST_HEAD_INIT(daemon_transport.list),
> -	.name 		= "daemon",
> -	.setup  	= daemon_setup,
> -	.user 		= &daemon_user_info,
> -	.kern 		= &daemon_kern_info,
> -	.private_size 	= sizeof(struct daemon_data),
> -	.setup_size 	= sizeof(struct daemon_init),
> -};
> -
> -static int register_daemon(void)
> -{
> -	register_transport(&daemon_transport);
> -	return 0;
> -}
> -
> -late_initcall(register_daemon);
> diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
> deleted file mode 100644
> index 785baedc3555..000000000000
> --- a/arch/um/drivers/daemon_user.c
> +++ /dev/null
> @@ -1,194 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
> - * James Leu (jleu@mindspring.net).
> - * Copyright (C) 2001 by various other people who didn't put their name here.
> - */
> -
> -#include <stdint.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <sys/types.h>
> -#include <sys/socket.h>
> -#include <sys/time.h>
> -#include <sys/un.h>
> -#include "daemon.h"
> -#include <net_user.h>
> -#include <os.h>
> -#include <um_malloc.h>
> -
> -enum request_type { REQ_NEW_CONTROL };
> -
> -#define SWITCH_MAGIC 0xfeedface
> -
> -struct request_v3 {
> -	uint32_t magic;
> -	uint32_t version;
> -	enum request_type type;
> -	struct sockaddr_un sock;
> -};
> -
> -static struct sockaddr_un *new_addr(void *name, int len)
> -{
> -	struct sockaddr_un *sun;
> -
> -	sun = uml_kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
> -	if (sun == NULL) {
> -		printk(UM_KERN_ERR "new_addr: allocation of sockaddr_un "
> -		       "failed\n");
> -		return NULL;
> -	}
> -	sun->sun_family = AF_UNIX;
> -	memcpy(sun->sun_path, name, len);
> -	return sun;
> -}
> -
> -static int connect_to_switch(struct daemon_data *pri)
> -{
> -	struct sockaddr_un *ctl_addr = pri->ctl_addr;
> -	struct sockaddr_un *local_addr = pri->local_addr;
> -	struct sockaddr_un *sun;
> -	struct request_v3 req;
> -	int fd, n, err;
> -
> -	pri->control = socket(AF_UNIX, SOCK_STREAM, 0);
> -	if (pri->control < 0) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "daemon_open : control socket failed, "
> -		       "errno = %d\n", -err);
> -		return err;
> -	}
> -
> -	if (connect(pri->control, (struct sockaddr *) ctl_addr,
> -		   sizeof(*ctl_addr)) < 0) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "daemon_open : control connect failed, "
> -		       "errno = %d\n", -err);
> -		goto out;
> -	}
> -
> -	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
> -	if (fd < 0) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "daemon_open : data socket failed, "
> -		       "errno = %d\n", -err);
> -		goto out;
> -	}
> -	if (bind(fd, (struct sockaddr *) local_addr, sizeof(*local_addr)) < 0) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "daemon_open : data bind failed, "
> -		       "errno = %d\n", -err);
> -		goto out_close;
> -	}
> -
> -	sun = uml_kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
> -	if (sun == NULL) {
> -		printk(UM_KERN_ERR "new_addr: allocation of sockaddr_un "
> -		       "failed\n");
> -		err = -ENOMEM;
> -		goto out_close;
> -	}
> -
> -	req.magic = SWITCH_MAGIC;
> -	req.version = SWITCH_VERSION;
> -	req.type = REQ_NEW_CONTROL;
> -	req.sock = *local_addr;
> -	n = write(pri->control, &req, sizeof(req));
> -	if (n != sizeof(req)) {
> -		printk(UM_KERN_ERR "daemon_open : control setup request "
> -		       "failed, err = %d\n", -errno);
> -		err = -ENOTCONN;
> -		goto out_free;
> -	}
> -
> -	n = read(pri->control, sun, sizeof(*sun));
> -	if (n != sizeof(*sun)) {
> -		printk(UM_KERN_ERR "daemon_open : read of data socket failed, "
> -		       "err = %d\n", -errno);
> -		err = -ENOTCONN;
> -		goto out_free;
> -	}
> -
> -	pri->data_addr = sun;
> -	return fd;
> -
> - out_free:
> -	kfree(sun);
> - out_close:
> -	close(fd);
> - out:
> -	close(pri->control);
> -	return err;
> -}
> -
> -static int daemon_user_init(void *data, void *dev)
> -{
> -	struct daemon_data *pri = data;
> -	struct timeval tv;
> -	struct {
> -		char zero;
> -		int pid;
> -		int usecs;
> -	} name;
> -
> -	if (!strcmp(pri->sock_type, "unix"))
> -		pri->ctl_addr = new_addr(pri->ctl_sock,
> -					 strlen(pri->ctl_sock) + 1);
> -	name.zero = 0;
> -	name.pid = os_getpid();
> -	gettimeofday(&tv, NULL);
> -	name.usecs = tv.tv_usec;
> -	pri->local_addr = new_addr(&name, sizeof(name));
> -	pri->dev = dev;
> -	pri->fd = connect_to_switch(pri);
> -	if (pri->fd < 0) {
> -		kfree(pri->local_addr);
> -		pri->local_addr = NULL;
> -		return pri->fd;
> -	}
> -
> -	return 0;
> -}
> -
> -static int daemon_open(void *data)
> -{
> -	struct daemon_data *pri = data;
> -	return pri->fd;
> -}
> -
> -static void daemon_remove(void *data)
> -{
> -	struct daemon_data *pri = data;
> -
> -	close(pri->fd);
> -	pri->fd = -1;
> -	close(pri->control);
> -	pri->control = -1;
> -
> -	kfree(pri->data_addr);
> -	pri->data_addr = NULL;
> -	kfree(pri->ctl_addr);
> -	pri->ctl_addr = NULL;
> -	kfree(pri->local_addr);
> -	pri->local_addr = NULL;
> -}
> -
> -int daemon_user_write(int fd, void *buf, int len, struct daemon_data *pri)
> -{
> -	struct sockaddr_un *data_addr = pri->data_addr;
> -
> -	return net_sendto(fd, buf, len, data_addr, sizeof(*data_addr));
> -}
> -
> -const struct net_user_info daemon_user_info = {
> -	.init		= daemon_user_init,
> -	.open		= daemon_open,
> -	.close	 	= NULL,
> -	.remove	 	= daemon_remove,
> -	.add_address	= NULL,
> -	.delete_address = NULL,
> -	.mtu		= ETH_MAX_PACKET,
> -	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_OTHER,
> -};
> diff --git a/arch/um/drivers/slip.h b/arch/um/drivers/slip.h
> deleted file mode 100644
> index 0f3b7ca99465..000000000000
> --- a/arch/um/drivers/slip.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __UM_SLIP_H
> -#define __UM_SLIP_H
> -
> -#include "slip_common.h"
> -
> -struct slip_data {
> -	void *dev;
> -	char name[sizeof("slnnnnn\0")];
> -	char *addr;
> -	char *gate_addr;
> -	int slave;
> -	struct slip_proto slip;
> -};
> -
> -extern const struct net_user_info slip_user_info;
> -
> -extern int slip_user_read(int fd, void *buf, int len, struct slip_data *pri);
> -extern int slip_user_write(int fd, void *buf, int len, struct slip_data *pri);
> -
> -#endif
> diff --git a/arch/um/drivers/slip_common.c b/arch/um/drivers/slip_common.c
> deleted file mode 100644
> index 20fe4f42743d..000000000000
> --- a/arch/um/drivers/slip_common.c
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <string.h>
> -#include "slip_common.h"
> -#include <net_user.h>
> -
> -int slip_proto_read(int fd, void *buf, int len, struct slip_proto *slip)
> -{
> -	int i, n, size, start;
> -
> -	if(slip->more > 0){
> -		i = 0;
> -		while(i < slip->more){
> -			size = slip_unesc(slip->ibuf[i++], slip->ibuf,
> -					  &slip->pos, &slip->esc);
> -			if(size){
> -				memcpy(buf, slip->ibuf, size);
> -				memmove(slip->ibuf, &slip->ibuf[i],
> -					slip->more - i);
> -				slip->more = slip->more - i;
> -				return size;
> -			}
> -		}
> -		slip->more = 0;
> -	}
> -
> -	n = net_read(fd, &slip->ibuf[slip->pos],
> -		     sizeof(slip->ibuf) - slip->pos);
> -	if(n <= 0)
> -		return n;
> -
> -	start = slip->pos;
> -	for(i = 0; i < n; i++){
> -		size = slip_unesc(slip->ibuf[start + i], slip->ibuf,&slip->pos,
> -				  &slip->esc);
> -		if(size){
> -			memcpy(buf, slip->ibuf, size);
> -			memmove(slip->ibuf, &slip->ibuf[start+i+1],
> -				n - (i + 1));
> -			slip->more = n - (i + 1);
> -			return size;
> -		}
> -	}
> -	return 0;
> -}
> -
> -int slip_proto_write(int fd, void *buf, int len, struct slip_proto *slip)
> -{
> -	int actual, n;
> -
> -	actual = slip_esc(buf, slip->obuf, len);
> -	n = net_write(fd, slip->obuf, actual);
> -	if(n < 0)
> -		return n;
> -	else return len;
> -}
> diff --git a/arch/um/drivers/slip_common.h b/arch/um/drivers/slip_common.h
> deleted file mode 100644
> index d3798b5caf7f..000000000000
> --- a/arch/um/drivers/slip_common.h
> +++ /dev/null
> @@ -1,106 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __UM_SLIP_COMMON_H
> -#define __UM_SLIP_COMMON_H
> -
> -#define BUF_SIZE 1500
> - /* two bytes each for a (pathological) max packet of escaped chars +  *
> -  * terminating END char + initial END char                            */
> -#define ENC_BUF_SIZE (2 * BUF_SIZE + 2)
> -
> -/* SLIP protocol characters. */
> -#define SLIP_END             0300	/* indicates end of frame	*/
> -#define SLIP_ESC             0333	/* indicates byte stuffing	*/
> -#define SLIP_ESC_END         0334	/* ESC ESC_END means END 'data'	*/
> -#define SLIP_ESC_ESC         0335	/* ESC ESC_ESC means ESC 'data'	*/
> -
> -static inline int slip_unesc(unsigned char c, unsigned char *buf, int *pos,
> -                             int *esc)
> -{
> -	int ret;
> -
> -	switch(c){
> -	case SLIP_END:
> -		*esc = 0;
> -		ret=*pos;
> -		*pos=0;
> -		return(ret);
> -	case SLIP_ESC:
> -		*esc = 1;
> -		return(0);
> -	case SLIP_ESC_ESC:
> -		if(*esc){
> -			*esc = 0;
> -			c = SLIP_ESC;
> -		}
> -		break;
> -	case SLIP_ESC_END:
> -		if(*esc){
> -			*esc = 0;
> -			c = SLIP_END;
> -		}
> -		break;
> -	}
> -	buf[(*pos)++] = c;
> -	return(0);
> -}
> -
> -static inline int slip_esc(unsigned char *s, unsigned char *d, int len)
> -{
> -	unsigned char *ptr = d;
> -	unsigned char c;
> -
> -	/*
> -	 * Send an initial END character to flush out any
> -	 * data that may have accumulated in the receiver
> -	 * due to line noise.
> -	 */
> -
> -	*ptr++ = SLIP_END;
> -
> -	/*
> -	 * For each byte in the packet, send the appropriate
> -	 * character sequence, according to the SLIP protocol.
> -	 */
> -
> -	while (len-- > 0) {
> -		switch(c = *s++) {
> -		case SLIP_END:
> -			*ptr++ = SLIP_ESC;
> -			*ptr++ = SLIP_ESC_END;
> -			break;
> -		case SLIP_ESC:
> -			*ptr++ = SLIP_ESC;
> -			*ptr++ = SLIP_ESC_ESC;
> -			break;
> -		default:
> -			*ptr++ = c;
> -			break;
> -		}
> -	}
> -	*ptr++ = SLIP_END;
> -	return (ptr - d);
> -}
> -
> -struct slip_proto {
> -	unsigned char ibuf[ENC_BUF_SIZE];
> -	unsigned char obuf[ENC_BUF_SIZE];
> -	int more; /* more data: do not read fd until ibuf has been drained */
> -	int pos;
> -	int esc;
> -};
> -
> -static inline void slip_proto_init(struct slip_proto * slip)
> -{
> -	memset(slip->ibuf, 0, sizeof(slip->ibuf));
> -	memset(slip->obuf, 0, sizeof(slip->obuf));
> -	slip->more = 0;
> -	slip->pos = 0;
> -	slip->esc = 0;
> -}
> -
> -extern int slip_proto_read(int fd, void *buf, int len,
> -			   struct slip_proto *slip);
> -extern int slip_proto_write(int fd, void *buf, int len,
> -			    struct slip_proto *slip);
> -
> -#endif
> diff --git a/arch/um/drivers/slip_kern.c b/arch/um/drivers/slip_kern.c
> deleted file mode 100644
> index c58ccdcc16d6..000000000000
> --- a/arch/um/drivers/slip_kern.c
> +++ /dev/null
> @@ -1,93 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#include <linux/if_arp.h>
> -#include <linux/init.h>
> -#include <linux/netdevice.h>
> -#include <net_kern.h>
> -#include "slip.h"
> -
> -struct slip_init {
> -	char *gate_addr;
> -};
> -
> -static void slip_init(struct net_device *dev, void *data)
> -{
> -	struct uml_net_private *private;
> -	struct slip_data *spri;
> -	struct slip_init *init = data;
> -
> -	private = netdev_priv(dev);
> -	spri = (struct slip_data *) private->user;
> -
> -	memset(spri->name, 0, sizeof(spri->name));
> -	spri->addr = NULL;
> -	spri->gate_addr = init->gate_addr;
> -	spri->slave = -1;
> -	spri->dev = dev;
> -
> -	slip_proto_init(&spri->slip);
> -
> -	dev->hard_header_len = 0;
> -	dev->header_ops = NULL;
> -	dev->addr_len = 0;
> -	dev->type = ARPHRD_SLIP;
> -	dev->tx_queue_len = 256;
> -	dev->flags = IFF_NOARP;
> -	printk("SLIP backend - SLIP IP = %s\n", spri->gate_addr);
> -}
> -
> -static unsigned short slip_protocol(struct sk_buff *skbuff)
> -{
> -	return htons(ETH_P_IP);
> -}
> -
> -static int slip_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return slip_user_read(fd, skb_mac_header(skb), skb->dev->mtu,
> -			      (struct slip_data *) &lp->user);
> -}
> -
> -static int slip_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return slip_user_write(fd, skb->data, skb->len,
> -			       (struct slip_data *) &lp->user);
> -}
> -
> -static const struct net_kern_info slip_kern_info = {
> -	.init			= slip_init,
> -	.protocol		= slip_protocol,
> -	.read			= slip_read,
> -	.write			= slip_write,
> -};
> -
> -static int slip_setup(char *str, char **mac_out, void *data)
> -{
> -	struct slip_init *init = data;
> -
> -	*init = ((struct slip_init) { .gate_addr = NULL });
> -
> -	if (str[0] != '\0')
> -		init->gate_addr = str;
> -	return 1;
> -}
> -
> -static struct transport slip_transport = {
> -	.list 		= LIST_HEAD_INIT(slip_transport.list),
> -	.name 		= "slip",
> -	.setup  	= slip_setup,
> -	.user 		= &slip_user_info,
> -	.kern 		= &slip_kern_info,
> -	.private_size 	= sizeof(struct slip_data),
> -	.setup_size 	= sizeof(struct slip_init),
> -};
> -
> -static int register_slip(void)
> -{
> -	register_transport(&slip_transport);
> -	return 0;
> -}
> -
> -late_initcall(register_slip);
> diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
> deleted file mode 100644
> index 7334019c9e60..000000000000
> --- a/arch/um/drivers/slip_user.c
> +++ /dev/null
> @@ -1,252 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <string.h>
> -#include <termios.h>
> -#include <sys/wait.h>
> -#include <net_user.h>
> -#include <os.h>
> -#include "slip.h"
> -#include <um_malloc.h>
> -
> -static int slip_user_init(void *data, void *dev)
> -{
> -	struct slip_data *pri = data;
> -
> -	pri->dev = dev;
> -	return 0;
> -}
> -
> -static int set_up_tty(int fd)
> -{
> -	int i;
> -	struct termios tios;
> -
> -	if (tcgetattr(fd, &tios) < 0) {
> -		printk(UM_KERN_ERR "could not get initial terminal "
> -		       "attributes\n");
> -		return -1;
> -	}
> -
> -	tios.c_cflag = CS8 | CREAD | HUPCL | CLOCAL;
> -	tios.c_iflag = IGNBRK | IGNPAR;
> -	tios.c_oflag = 0;
> -	tios.c_lflag = 0;
> -	for (i = 0; i < NCCS; i++)
> -		tios.c_cc[i] = 0;
> -	tios.c_cc[VMIN] = 1;
> -	tios.c_cc[VTIME] = 0;
> -
> -	cfsetospeed(&tios, B38400);
> -	cfsetispeed(&tios, B38400);
> -
> -	if (tcsetattr(fd, TCSAFLUSH, &tios) < 0) {
> -		printk(UM_KERN_ERR "failed to set terminal attributes\n");
> -		return -1;
> -	}
> -	return 0;
> -}
> -
> -struct slip_pre_exec_data {
> -	int stdin_fd;
> -	int stdout_fd;
> -	int close_me;
> -};
> -
> -static void slip_pre_exec(void *arg)
> -{
> -	struct slip_pre_exec_data *data = arg;
> -
> -	if (data->stdin_fd >= 0)
> -		dup2(data->stdin_fd, 0);
> -	dup2(data->stdout_fd, 1);
> -	if (data->close_me >= 0)
> -		close(data->close_me);
> -}
> -
> -static int slip_tramp(char **argv, int fd)
> -{
> -	struct slip_pre_exec_data pe_data;
> -	char *output;
> -	int pid, fds[2], err, output_len;
> -
> -	err = os_pipe(fds, 1, 0);
> -	if (err < 0) {
> -		printk(UM_KERN_ERR "slip_tramp : pipe failed, err = %d\n",
> -		       -err);
> -		goto out;
> -	}
> -
> -	err = 0;
> -	pe_data.stdin_fd = fd;
> -	pe_data.stdout_fd = fds[1];
> -	pe_data.close_me = fds[0];
> -	err = run_helper(slip_pre_exec, &pe_data, argv);
> -	if (err < 0)
> -		goto out_close;
> -	pid = err;
> -
> -	output_len = UM_KERN_PAGE_SIZE;
> -	output = uml_kmalloc(output_len, UM_GFP_KERNEL);
> -	if (output == NULL) {
> -		printk(UM_KERN_ERR "slip_tramp : failed to allocate output "
> -		       "buffer\n");
> -		os_kill_process(pid, 1);
> -		err = -ENOMEM;
> -		goto out_close;
> -	}
> -
> -	close(fds[1]);
> -	read_output(fds[0], output, output_len);
> -	printk("%s", output);
> -
> -	err = helper_wait(pid);
> -	close(fds[0]);
> -
> -	kfree(output);
> -	return err;
> -
> -out_close:
> -	close(fds[0]);
> -	close(fds[1]);
> -out:
> -	return err;
> -}
> -
> -static int slip_open(void *data)
> -{
> -	struct slip_data *pri = data;
> -	char version_buf[sizeof("nnnnn\0")];
> -	char gate_buf[sizeof("nnn.nnn.nnn.nnn\0")];
> -	char *argv[] = { "uml_net", version_buf, "slip", "up", gate_buf,
> -			 NULL };
> -	int sfd, mfd, err;
> -
> -	err = get_pty();
> -	if (err < 0) {
> -		printk(UM_KERN_ERR "slip-open : Failed to open pty, err = %d\n",
> -		       -err);
> -		goto out;
> -	}
> -	mfd = err;
> -
> -	err = open(ptsname(mfd), O_RDWR, 0);
> -	if (err < 0) {
> -		printk(UM_KERN_ERR "Couldn't open tty for slip line, "
> -		       "err = %d\n", -err);
> -		goto out_close;
> -	}
> -	sfd = err;
> -
> -	err = set_up_tty(sfd);
> -	if (err)
> -		goto out_close2;
> -
> -	pri->slave = sfd;
> -	pri->slip.pos = 0;
> -	pri->slip.esc = 0;
> -	if (pri->gate_addr != NULL) {
> -		sprintf(version_buf, "%d", UML_NET_VERSION);
> -		strcpy(gate_buf, pri->gate_addr);
> -
> -		err = slip_tramp(argv, sfd);
> -
> -		if (err < 0) {
> -			printk(UM_KERN_ERR "slip_tramp failed - err = %d\n",
> -			       -err);
> -			goto out_close2;
> -		}
> -		err = os_get_ifname(pri->slave, pri->name);
> -		if (err < 0) {
> -			printk(UM_KERN_ERR "get_ifname failed, err = %d\n",
> -			       -err);
> -			goto out_close2;
> -		}
> -		iter_addresses(pri->dev, open_addr, pri->name);
> -	}
> -	else {
> -		err = os_set_slip(sfd);
> -		if (err < 0) {
> -			printk(UM_KERN_ERR "Failed to set slip discipline "
> -			       "encapsulation - err = %d\n", -err);
> -			goto out_close2;
> -		}
> -	}
> -	return mfd;
> -out_close2:
> -	close(sfd);
> -out_close:
> -	close(mfd);
> -out:
> -	return err;
> -}
> -
> -static void slip_close(int fd, void *data)
> -{
> -	struct slip_data *pri = data;
> -	char version_buf[sizeof("nnnnn\0")];
> -	char *argv[] = { "uml_net", version_buf, "slip", "down", pri->name,
> -			 NULL };
> -	int err;
> -
> -	if (pri->gate_addr != NULL)
> -		iter_addresses(pri->dev, close_addr, pri->name);
> -
> -	sprintf(version_buf, "%d", UML_NET_VERSION);
> -
> -	err = slip_tramp(argv, pri->slave);
> -
> -	if (err != 0)
> -		printk(UM_KERN_ERR "slip_tramp failed - errno = %d\n", -err);
> -	close(fd);
> -	close(pri->slave);
> -	pri->slave = -1;
> -}
> -
> -int slip_user_read(int fd, void *buf, int len, struct slip_data *pri)
> -{
> -	return slip_proto_read(fd, buf, len, &pri->slip);
> -}
> -
> -int slip_user_write(int fd, void *buf, int len, struct slip_data *pri)
> -{
> -	return slip_proto_write(fd, buf, len, &pri->slip);
> -}
> -
> -static void slip_add_addr(unsigned char *addr, unsigned char *netmask,
> -			  void *data)
> -{
> -	struct slip_data *pri = data;
> -
> -	if (pri->slave < 0)
> -		return;
> -	open_addr(addr, netmask, pri->name);
> -}
> -
> -static void slip_del_addr(unsigned char *addr, unsigned char *netmask,
> -			    void *data)
> -{
> -	struct slip_data *pri = data;
> -
> -	if (pri->slave < 0)
> -		return;
> -	close_addr(addr, netmask, pri->name);
> -}
> -
> -const struct net_user_info slip_user_info = {
> -	.init		= slip_user_init,
> -	.open		= slip_open,
> -	.close	 	= slip_close,
> -	.remove	 	= NULL,
> -	.add_address	= slip_add_addr,
> -	.delete_address = slip_del_addr,
> -	.mtu		= BUF_SIZE,
> -	.max_packet	= BUF_SIZE,
> -};
> diff --git a/arch/um/drivers/slirp.h b/arch/um/drivers/slirp.h
> deleted file mode 100644
> index 4aef2b88249a..000000000000
> --- a/arch/um/drivers/slirp.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __UM_SLIRP_H
> -#define __UM_SLIRP_H
> -
> -#include "slip_common.h"
> -
> -#define SLIRP_MAX_ARGS 100
> -/*
> - * XXX this next definition is here because I don't understand why this
> - * initializer doesn't work in slirp_kern.c:
> - *
> - *   argv :  { init->argv[ 0 ... SLIRP_MAX_ARGS-1 ] },
> - *
> - * or why I can't typecast like this:
> - *
> - *   argv :  (char* [SLIRP_MAX_ARGS])(init->argv),
> - */
> -struct arg_list_dummy_wrapper { char *argv[SLIRP_MAX_ARGS]; };
> -
> -struct slirp_data {
> -	void *dev;
> -	struct arg_list_dummy_wrapper argw;
> -	int pid;
> -	int slave;
> -	struct slip_proto slip;
> -};
> -
> -extern const struct net_user_info slirp_user_info;
> -
> -extern int slirp_user_read(int fd, void *buf, int len, struct slirp_data *pri);
> -extern int slirp_user_write(int fd, void *buf, int len,
> -			    struct slirp_data *pri);
> -
> -#endif
> diff --git a/arch/um/drivers/slirp_kern.c b/arch/um/drivers/slirp_kern.c
> deleted file mode 100644
> index 0a6151ee9572..000000000000
> --- a/arch/um/drivers/slirp_kern.c
> +++ /dev/null
> @@ -1,120 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#include <linux/if_arp.h>
> -#include <linux/init.h>
> -#include <linux/netdevice.h>
> -#include <linux/string.h>
> -#include <net_kern.h>
> -#include <net_user.h>
> -#include "slirp.h"
> -
> -struct slirp_init {
> -	struct arg_list_dummy_wrapper argw;  /* XXX should be simpler... */
> -};
> -
> -static void slirp_init(struct net_device *dev, void *data)
> -{
> -	struct uml_net_private *private;
> -	struct slirp_data *spri;
> -	struct slirp_init *init = data;
> -	int i;
> -
> -	private = netdev_priv(dev);
> -	spri = (struct slirp_data *) private->user;
> -
> -	spri->argw = init->argw;
> -	spri->pid = -1;
> -	spri->slave = -1;
> -	spri->dev = dev;
> -
> -	slip_proto_init(&spri->slip);
> -
> -	dev->hard_header_len = 0;
> -	dev->header_ops = NULL;
> -	dev->addr_len = 0;
> -	dev->type = ARPHRD_SLIP;
> -	dev->tx_queue_len = 256;
> -	dev->flags = IFF_NOARP;
> -	printk("SLIRP backend - command line:");
> -	for (i = 0; spri->argw.argv[i] != NULL; i++)
> -		printk(" '%s'",spri->argw.argv[i]);
> -	printk("\n");
> -}
> -
> -static unsigned short slirp_protocol(struct sk_buff *skbuff)
> -{
> -	return htons(ETH_P_IP);
> -}
> -
> -static int slirp_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return slirp_user_read(fd, skb_mac_header(skb), skb->dev->mtu,
> -			       (struct slirp_data *) &lp->user);
> -}
> -
> -static int slirp_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return slirp_user_write(fd, skb->data, skb->len,
> -				(struct slirp_data *) &lp->user);
> -}
> -
> -const struct net_kern_info slirp_kern_info = {
> -	.init			= slirp_init,
> -	.protocol		= slirp_protocol,
> -	.read			= slirp_read,
> -	.write			= slirp_write,
> -};
> -
> -static int slirp_setup(char *str, char **mac_out, void *data)
> -{
> -	struct slirp_init *init = data;
> -	int i=0;
> -
> -	*init = ((struct slirp_init) { .argw = { { "slirp", NULL  } } });
> -
> -	str = split_if_spec(str, mac_out, NULL);
> -
> -	if (str == NULL) /* no command line given after MAC addr */
> -		return 1;
> -
> -	do {
> -		if (i >= SLIRP_MAX_ARGS - 1) {
> -			printk(KERN_WARNING "slirp_setup: truncating slirp "
> -			       "arguments\n");
> -			break;
> -		}
> -		init->argw.argv[i++] = str;
> -		while(*str && *str!=',') {
> -			if (*str == '_')
> -				*str=' ';
> -			str++;
> -		}
> -		if (*str != ',')
> -			break;
> -		*str++ = '\0';
> -	} while (1);
> -
> -	init->argw.argv[i] = NULL;
> -	return 1;
> -}
> -
> -static struct transport slirp_transport = {
> -	.list 		= LIST_HEAD_INIT(slirp_transport.list),
> -	.name 		= "slirp",
> -	.setup  	= slirp_setup,
> -	.user 		= &slirp_user_info,
> -	.kern 		= &slirp_kern_info,
> -	.private_size 	= sizeof(struct slirp_data),
> -	.setup_size 	= sizeof(struct slirp_init),
> -};
> -
> -static int register_slirp(void)
> -{
> -	register_transport(&slirp_transport);
> -	return 0;
> -}
> -
> -late_initcall(register_slirp);
> diff --git a/arch/um/drivers/slirp_user.c b/arch/um/drivers/slirp_user.c
> deleted file mode 100644
> index 97228aa080cb..000000000000
> --- a/arch/um/drivers/slirp_user.c
> +++ /dev/null
> @@ -1,124 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#include <unistd.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <sys/wait.h>
> -#include <net_user.h>
> -#include <os.h>
> -#include "slirp.h"
> -
> -static int slirp_user_init(void *data, void *dev)
> -{
> -	struct slirp_data *pri = data;
> -
> -	pri->dev = dev;
> -	return 0;
> -}
> -
> -struct slirp_pre_exec_data {
> -	int stdin_fd;
> -	int stdout_fd;
> -};
> -
> -static void slirp_pre_exec(void *arg)
> -{
> -	struct slirp_pre_exec_data *data = arg;
> -
> -	if (data->stdin_fd != -1)
> -		dup2(data->stdin_fd, 0);
> -	if (data->stdout_fd != -1)
> -		dup2(data->stdout_fd, 1);
> -}
> -
> -static int slirp_tramp(char **argv, int fd)
> -{
> -	struct slirp_pre_exec_data pe_data;
> -	int pid;
> -
> -	pe_data.stdin_fd = fd;
> -	pe_data.stdout_fd = fd;
> -	pid = run_helper(slirp_pre_exec, &pe_data, argv);
> -
> -	return pid;
> -}
> -
> -static int slirp_open(void *data)
> -{
> -	struct slirp_data *pri = data;
> -	int fds[2], err;
> -
> -	err = os_pipe(fds, 1, 1);
> -	if (err)
> -		return err;
> -
> -	err = slirp_tramp(pri->argw.argv, fds[1]);
> -	if (err < 0) {
> -		printk(UM_KERN_ERR "slirp_tramp failed - errno = %d\n", -err);
> -		goto out;
> -	}
> -
> -	pri->slave = fds[1];
> -	pri->slip.pos = 0;
> -	pri->slip.esc = 0;
> -	pri->pid = err;
> -
> -	return fds[0];
> -out:
> -	close(fds[0]);
> -	close(fds[1]);
> -	return err;
> -}
> -
> -static void slirp_close(int fd, void *data)
> -{
> -	struct slirp_data *pri = data;
> -	int err;
> -
> -	close(fd);
> -	close(pri->slave);
> -
> -	pri->slave = -1;
> -
> -	if (pri->pid<1) {
> -		printk(UM_KERN_ERR "slirp_close: no child process to shut "
> -		       "down\n");
> -		return;
> -	}
> -
> -#if 0
> -	if (kill(pri->pid, SIGHUP)<0) {
> -		printk(UM_KERN_ERR "slirp_close: sending hangup to %d failed "
> -		       "(%d)\n", pri->pid, errno);
> -	}
> -#endif
> -	err = helper_wait(pri->pid);
> -	if (err < 0)
> -		return;
> -
> -	pri->pid = -1;
> -}
> -
> -int slirp_user_read(int fd, void *buf, int len, struct slirp_data *pri)
> -{
> -	return slip_proto_read(fd, buf, len, &pri->slip);
> -}
> -
> -int slirp_user_write(int fd, void *buf, int len, struct slirp_data *pri)
> -{
> -	return slip_proto_write(fd, buf, len, &pri->slip);
> -}
> -
> -const struct net_user_info slirp_user_info = {
> -	.init		= slirp_user_init,
> -	.open		= slirp_open,
> -	.close	 	= slirp_close,
> -	.remove	 	= NULL,
> -	.add_address	= NULL,
> -	.delete_address = NULL,
> -	.mtu		= BUF_SIZE,
> -	.max_packet	= BUF_SIZE,
> -};
> diff --git a/arch/um/drivers/umcast.h b/arch/um/drivers/umcast.h
> deleted file mode 100644
> index fe39bee1e3bd..000000000000
> --- a/arch/um/drivers/umcast.h
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#ifndef __DRIVERS_UMCAST_H
> -#define __DRIVERS_UMCAST_H
> -
> -#include <net_user.h>
> -
> -struct umcast_data {
> -	char *addr;
> -	unsigned short lport;
> -	unsigned short rport;
> -	void *listen_addr;
> -	void *remote_addr;
> -	int ttl;
> -	int unicast;
> -	void *dev;
> -};
> -
> -extern const struct net_user_info umcast_user_info;
> -
> -extern int umcast_user_write(int fd, void *buf, int len,
> -			     struct umcast_data *pri);
> -
> -#endif
> diff --git a/arch/um/drivers/umcast_kern.c b/arch/um/drivers/umcast_kern.c
> deleted file mode 100644
> index 595a54f2b9c6..000000000000
> --- a/arch/um/drivers/umcast_kern.c
> +++ /dev/null
> @@ -1,188 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * user-mode-linux networking multicast transport
> - * Copyright (C) 2001 by Harald Welte <laforge@gnumonks.org>
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - *
> - * based on the existing uml-networking code, which is
> - * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
> - * James Leu (jleu@mindspring.net).
> - * Copyright (C) 2001 by various other people who didn't put their name here.
> - *
> - */
> -
> -#include <linux/init.h>
> -#include <linux/netdevice.h>
> -#include "umcast.h"
> -#include <net_kern.h>
> -
> -struct umcast_init {
> -	char *addr;
> -	int lport;
> -	int rport;
> -	int ttl;
> -	bool unicast;
> -};
> -
> -static void umcast_init(struct net_device *dev, void *data)
> -{
> -	struct uml_net_private *pri;
> -	struct umcast_data *dpri;
> -	struct umcast_init *init = data;
> -
> -	pri = netdev_priv(dev);
> -	dpri = (struct umcast_data *) pri->user;
> -	dpri->addr = init->addr;
> -	dpri->lport = init->lport;
> -	dpri->rport = init->rport;
> -	dpri->unicast = init->unicast;
> -	dpri->ttl = init->ttl;
> -	dpri->dev = dev;
> -
> -	if (dpri->unicast) {
> -		printk(KERN_INFO "ucast backend address: %s:%u listen port: "
> -		       "%u\n", dpri->addr, dpri->rport, dpri->lport);
> -	} else {
> -		printk(KERN_INFO "mcast backend multicast address: %s:%u, "
> -		       "TTL:%u\n", dpri->addr, dpri->lport, dpri->ttl);
> -	}
> -}
> -
> -static int umcast_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return net_recvfrom(fd, skb_mac_header(skb),
> -			    skb->dev->mtu + ETH_HEADER_OTHER);
> -}
> -
> -static int umcast_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return umcast_user_write(fd, skb->data, skb->len,
> -				(struct umcast_data *) &lp->user);
> -}
> -
> -static const struct net_kern_info umcast_kern_info = {
> -	.init			= umcast_init,
> -	.protocol		= eth_protocol,
> -	.read			= umcast_read,
> -	.write			= umcast_write,
> -};
> -
> -static int mcast_setup(char *str, char **mac_out, void *data)
> -{
> -	struct umcast_init *init = data;
> -	char *port_str = NULL, *ttl_str = NULL, *remain;
> -	char *last;
> -
> -	*init = ((struct umcast_init)
> -		{ .addr	= "239.192.168.1",
> -		  .lport	= 1102,
> -		  .ttl	= 1 });
> -
> -	remain = split_if_spec(str, mac_out, &init->addr, &port_str, &ttl_str,
> -			       NULL);
> -	if (remain != NULL) {
> -		printk(KERN_ERR "mcast_setup - Extra garbage on "
> -		       "specification : '%s'\n", remain);
> -		return 0;
> -	}
> -
> -	if (port_str != NULL) {
> -		init->lport = simple_strtoul(port_str, &last, 10);
> -		if ((*last != '\0') || (last == port_str)) {
> -			printk(KERN_ERR "mcast_setup - Bad port : '%s'\n",
> -			       port_str);
> -			return 0;
> -		}
> -	}
> -
> -	if (ttl_str != NULL) {
> -		init->ttl = simple_strtoul(ttl_str, &last, 10);
> -		if ((*last != '\0') || (last == ttl_str)) {
> -			printk(KERN_ERR "mcast_setup - Bad ttl : '%s'\n",
> -			       ttl_str);
> -			return 0;
> -		}
> -	}
> -
> -	init->unicast = false;
> -	init->rport = init->lport;
> -
> -	printk(KERN_INFO "Configured mcast device: %s:%u-%u\n", init->addr,
> -	       init->lport, init->ttl);
> -
> -	return 1;
> -}
> -
> -static int ucast_setup(char *str, char **mac_out, void *data)
> -{
> -	struct umcast_init *init = data;
> -	char *lport_str = NULL, *rport_str = NULL, *remain;
> -	char *last;
> -
> -	*init = ((struct umcast_init)
> -		{ .addr		= "",
> -		  .lport	= 1102,
> -		  .rport	= 1102 });
> -
> -	remain = split_if_spec(str, mac_out, &init->addr,
> -			       &lport_str, &rport_str, NULL);
> -	if (remain != NULL) {
> -		printk(KERN_ERR "ucast_setup - Extra garbage on "
> -		       "specification : '%s'\n", remain);
> -		return 0;
> -	}
> -
> -	if (lport_str != NULL) {
> -		init->lport = simple_strtoul(lport_str, &last, 10);
> -		if ((*last != '\0') || (last == lport_str)) {
> -			printk(KERN_ERR "ucast_setup - Bad listen port : "
> -			       "'%s'\n", lport_str);
> -			return 0;
> -		}
> -	}
> -
> -	if (rport_str != NULL) {
> -		init->rport = simple_strtoul(rport_str, &last, 10);
> -		if ((*last != '\0') || (last == rport_str)) {
> -			printk(KERN_ERR "ucast_setup - Bad remote port : "
> -			       "'%s'\n", rport_str);
> -			return 0;
> -		}
> -	}
> -
> -	init->unicast = true;
> -
> -	printk(KERN_INFO "Configured ucast device: :%u -> %s:%u\n",
> -	       init->lport, init->addr, init->rport);
> -
> -	return 1;
> -}
> -
> -static struct transport mcast_transport = {
> -	.list	= LIST_HEAD_INIT(mcast_transport.list),
> -	.name	= "mcast",
> -	.setup	= mcast_setup,
> -	.user	= &umcast_user_info,
> -	.kern	= &umcast_kern_info,
> -	.private_size	= sizeof(struct umcast_data),
> -	.setup_size	= sizeof(struct umcast_init),
> -};
> -
> -static struct transport ucast_transport = {
> -	.list	= LIST_HEAD_INIT(ucast_transport.list),
> -	.name	= "ucast",
> -	.setup	= ucast_setup,
> -	.user	= &umcast_user_info,
> -	.kern	= &umcast_kern_info,
> -	.private_size	= sizeof(struct umcast_data),
> -	.setup_size	= sizeof(struct umcast_init),
> -};
> -
> -static int register_umcast(void)
> -{
> -	register_transport(&mcast_transport);
> -	register_transport(&ucast_transport);
> -	return 0;
> -}
> -
> -late_initcall(register_umcast);
> diff --git a/arch/um/drivers/umcast_user.c b/arch/um/drivers/umcast_user.c
> deleted file mode 100644
> index b50b13cff04e..000000000000
> --- a/arch/um/drivers/umcast_user.c
> +++ /dev/null
> @@ -1,184 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * user-mode-linux networking multicast transport
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - * Copyright (C) 2001 by Harald Welte <laforge@gnumonks.org>
> - *
> - * based on the existing uml-networking code, which is
> - * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
> - * James Leu (jleu@mindspring.net).
> - * Copyright (C) 2001 by various other people who didn't put their name here.
> - *
> - *
> - */
> -
> -#include <unistd.h>
> -#include <errno.h>
> -#include <netinet/in.h>
> -#include "umcast.h"
> -#include <net_user.h>
> -#include <um_malloc.h>
> -
> -static struct sockaddr_in *new_addr(char *addr, unsigned short port)
> -{
> -	struct sockaddr_in *sin;
> -
> -	sin = uml_kmalloc(sizeof(struct sockaddr_in), UM_GFP_KERNEL);
> -	if (sin == NULL) {
> -		printk(UM_KERN_ERR "new_addr: allocation of sockaddr_in "
> -		       "failed\n");
> -		return NULL;
> -	}
> -	sin->sin_family = AF_INET;
> -	if (addr)
> -		sin->sin_addr.s_addr = in_aton(addr);
> -	else
> -		sin->sin_addr.s_addr = INADDR_ANY;
> -	sin->sin_port = htons(port);
> -	return sin;
> -}
> -
> -static int umcast_user_init(void *data, void *dev)
> -{
> -	struct umcast_data *pri = data;
> -
> -	pri->remote_addr = new_addr(pri->addr, pri->rport);
> -	if (pri->unicast)
> -		pri->listen_addr = new_addr(NULL, pri->lport);
> -	else
> -		pri->listen_addr = pri->remote_addr;
> -	pri->dev = dev;
> -	return 0;
> -}
> -
> -static void umcast_remove(void *data)
> -{
> -	struct umcast_data *pri = data;
> -
> -	kfree(pri->listen_addr);
> -	if (pri->unicast)
> -		kfree(pri->remote_addr);
> -	pri->listen_addr = pri->remote_addr = NULL;
> -}
> -
> -static int umcast_open(void *data)
> -{
> -	struct umcast_data *pri = data;
> -	struct sockaddr_in *lsin = pri->listen_addr;
> -	struct sockaddr_in *rsin = pri->remote_addr;
> -	struct ip_mreq mreq;
> -	int fd, yes = 1, err = -EINVAL;
> -
> -
> -	if ((!pri->unicast && lsin->sin_addr.s_addr == 0) ||
> -	    (rsin->sin_addr.s_addr == 0) ||
> -	    (lsin->sin_port == 0) || (rsin->sin_port == 0))
> -		goto out;
> -
> -	fd = socket(AF_INET, SOCK_DGRAM, 0);
> -
> -	if (fd < 0) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "umcast_open : data socket failed, "
> -		       "errno = %d\n", errno);
> -		goto out;
> -	}
> -
> -	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "umcast_open: SO_REUSEADDR failed, "
> -		       "errno = %d\n", errno);
> -		goto out_close;
> -	}
> -
> -	if (!pri->unicast) {
> -		/* set ttl according to config */
> -		if (setsockopt(fd, SOL_IP, IP_MULTICAST_TTL, &pri->ttl,
> -			       sizeof(pri->ttl)) < 0) {
> -			err = -errno;
> -			printk(UM_KERN_ERR "umcast_open: IP_MULTICAST_TTL "
> -			       "failed, error = %d\n", errno);
> -			goto out_close;
> -		}
> -
> -		/* set LOOP, so data does get fed back to local sockets */
> -		if (setsockopt(fd, SOL_IP, IP_MULTICAST_LOOP,
> -			       &yes, sizeof(yes)) < 0) {
> -			err = -errno;
> -			printk(UM_KERN_ERR "umcast_open: IP_MULTICAST_LOOP "
> -			       "failed, error = %d\n", errno);
> -			goto out_close;
> -		}
> -	}
> -
> -	/* bind socket to the address */
> -	if (bind(fd, (struct sockaddr *) lsin, sizeof(*lsin)) < 0) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "umcast_open : data bind failed, "
> -		       "errno = %d\n", errno);
> -		goto out_close;
> -	}
> -
> -	if (!pri->unicast) {
> -		/* subscribe to the multicast group */
> -		mreq.imr_multiaddr.s_addr = lsin->sin_addr.s_addr;
> -		mreq.imr_interface.s_addr = 0;
> -		if (setsockopt(fd, SOL_IP, IP_ADD_MEMBERSHIP,
> -			       &mreq, sizeof(mreq)) < 0) {
> -			err = -errno;
> -			printk(UM_KERN_ERR "umcast_open: IP_ADD_MEMBERSHIP "
> -			       "failed, error = %d\n", errno);
> -			printk(UM_KERN_ERR "There appears not to be a "
> -			       "multicast-capable network interface on the "
> -			       "host.\n");
> -			printk(UM_KERN_ERR "eth0 should be configured in order "
> -			       "to use the multicast transport.\n");
> -			goto out_close;
> -		}
> -	}
> -
> -	return fd;
> -
> - out_close:
> -	close(fd);
> - out:
> -	return err;
> -}
> -
> -static void umcast_close(int fd, void *data)
> -{
> -	struct umcast_data *pri = data;
> -
> -	if (!pri->unicast) {
> -		struct ip_mreq mreq;
> -		struct sockaddr_in *lsin = pri->listen_addr;
> -
> -		mreq.imr_multiaddr.s_addr = lsin->sin_addr.s_addr;
> -		mreq.imr_interface.s_addr = 0;
> -		if (setsockopt(fd, SOL_IP, IP_DROP_MEMBERSHIP,
> -			       &mreq, sizeof(mreq)) < 0) {
> -			printk(UM_KERN_ERR "umcast_close: IP_DROP_MEMBERSHIP "
> -			       "failed, error = %d\n", errno);
> -		}
> -	}
> -
> -	close(fd);
> -}
> -
> -int umcast_user_write(int fd, void *buf, int len, struct umcast_data *pri)
> -{
> -	struct sockaddr_in *data_addr = pri->remote_addr;
> -
> -	return net_sendto(fd, buf, len, data_addr, sizeof(*data_addr));
> -}
> -
> -const struct net_user_info umcast_user_info = {
> -	.init	= umcast_user_init,
> -	.open	= umcast_open,
> -	.close	= umcast_close,
> -	.remove	= umcast_remove,
> -	.add_address	= NULL,
> -	.delete_address = NULL,
> -	.mtu	= ETH_MAX_PACKET,
> -	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_OTHER,
> -};
> diff --git a/arch/um/drivers/vde.h b/arch/um/drivers/vde.h
> deleted file mode 100644
> index cab0379e6142..000000000000
> --- a/arch/um/drivers/vde.h
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2007 Luca Bigliardi (shammash@artha.org).
> - */
> -
> -#ifndef __UM_VDE_H__
> -#define __UM_VDE_H__
> -
> -struct vde_data {
> -	char *vde_switch;
> -	char *descr;
> -	void *args;
> -	void *conn;
> -	void *dev;
> -};
> -
> -struct vde_init {
> -	char *vde_switch;
> -	char *descr;
> -	int port;
> -	char *group;
> -	int mode;
> -};
> -
> -extern const struct net_user_info vde_user_info;
> -
> -extern void vde_init_libstuff(struct vde_data *vpri, struct vde_init *init);
> -
> -extern int vde_user_read(void *conn, void *buf, int len);
> -extern int vde_user_write(void *conn, void *buf, int len);
> -
> -#endif
> diff --git a/arch/um/drivers/vde_kern.c b/arch/um/drivers/vde_kern.c
> deleted file mode 100644
> index bc6f22cbfb35..000000000000
> --- a/arch/um/drivers/vde_kern.c
> +++ /dev/null
> @@ -1,129 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2007 Luca Bigliardi (shammash@artha.org).
> - *
> - * Transport usage:
> - *  ethN=vde,<vde_switch>,<mac addr>,<port>,<group>,<mode>,<description>
> - *
> - */
> -
> -#include <linux/init.h>
> -#include <linux/netdevice.h>
> -#include <net_kern.h>
> -#include <net_user.h>
> -#include "vde.h"
> -
> -static void vde_init(struct net_device *dev, void *data)
> -{
> -	struct vde_init *init = data;
> -	struct uml_net_private *pri;
> -	struct vde_data *vpri;
> -
> -	pri = netdev_priv(dev);
> -	vpri = (struct vde_data *) pri->user;
> -
> -	vpri->vde_switch = init->vde_switch;
> -	vpri->descr = init->descr ? init->descr : "UML vde_transport";
> -	vpri->args = NULL;
> -	vpri->conn = NULL;
> -	vpri->dev = dev;
> -
> -	printk("vde backend - %s, ", vpri->vde_switch ?
> -	       vpri->vde_switch : "(default socket)");
> -
> -	vde_init_libstuff(vpri, init);
> -
> -	printk("\n");
> -}
> -
> -static int vde_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	struct vde_data *pri = (struct vde_data *) &lp->user;
> -
> -	if (pri->conn != NULL)
> -		return vde_user_read(pri->conn, skb_mac_header(skb),
> -				     skb->dev->mtu + ETH_HEADER_OTHER);
> -
> -	printk(KERN_ERR "vde_read - we have no VDECONN to read from");
> -	return -EBADF;
> -}
> -
> -static int vde_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	struct vde_data *pri = (struct vde_data *) &lp->user;
> -
> -	if (pri->conn != NULL)
> -		return vde_user_write((void *)pri->conn, skb->data,
> -				      skb->len);
> -
> -	printk(KERN_ERR "vde_write - we have no VDECONN to write to");
> -	return -EBADF;
> -}
> -
> -static const struct net_kern_info vde_kern_info = {
> -	.init			= vde_init,
> -	.protocol		= eth_protocol,
> -	.read			= vde_read,
> -	.write			= vde_write,
> -};
> -
> -static int vde_setup(char *str, char **mac_out, void *data)
> -{
> -	struct vde_init *init = data;
> -	char *remain, *port_str = NULL, *mode_str = NULL, *last;
> -
> -	*init = ((struct vde_init)
> -		{ .vde_switch		= NULL,
> -		  .descr		= NULL,
> -		  .port			= 0,
> -		  .group		= NULL,
> -		  .mode			= 0 });
> -
> -	remain = split_if_spec(str, &init->vde_switch, mac_out, &port_str,
> -				&init->group, &mode_str, &init->descr, NULL);
> -
> -	if (remain != NULL)
> -		printk(KERN_WARNING "vde_setup - Ignoring extra data :"
> -		       "'%s'\n", remain);
> -
> -	if (port_str != NULL) {
> -		init->port = simple_strtoul(port_str, &last, 10);
> -		if ((*last != '\0') || (last == port_str)) {
> -			printk(KERN_ERR "vde_setup - Bad port : '%s'\n",
> -						port_str);
> -			return 0;
> -		}
> -	}
> -
> -	if (mode_str != NULL) {
> -		init->mode = simple_strtoul(mode_str, &last, 8);
> -		if ((*last != '\0') || (last == mode_str)) {
> -			printk(KERN_ERR "vde_setup - Bad mode : '%s'\n",
> -						mode_str);
> -			return 0;
> -		}
> -	}
> -
> -	printk(KERN_INFO "Configured vde device: %s\n", init->vde_switch ?
> -	       init->vde_switch : "(default socket)");
> -
> -	return 1;
> -}
> -
> -static struct transport vde_transport = {
> -	.list 		= LIST_HEAD_INIT(vde_transport.list),
> -	.name 		= "vde",
> -	.setup  	= vde_setup,
> -	.user 		= &vde_user_info,
> -	.kern 		= &vde_kern_info,
> -	.private_size 	= sizeof(struct vde_data),
> -	.setup_size 	= sizeof(struct vde_init),
> -};
> -
> -static int register_vde(void)
> -{
> -	register_transport(&vde_transport);
> -	return 0;
> -}
> -
> -late_initcall(register_vde);
> diff --git a/arch/um/drivers/vde_user.c b/arch/um/drivers/vde_user.c
> deleted file mode 100644
> index bc7dc4e1e486..000000000000
> --- a/arch/um/drivers/vde_user.c
> +++ /dev/null
> @@ -1,125 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2007 Luca Bigliardi (shammash@artha.org).
> - */
> -
> -#include <stddef.h>
> -#include <errno.h>
> -#include <libvdeplug.h>
> -#include <net_user.h>
> -#include <um_malloc.h>
> -#include "vde.h"
> -
> -static int vde_user_init(void *data, void *dev)
> -{
> -	struct vde_data *pri = data;
> -	VDECONN *conn = NULL;
> -	int err = -EINVAL;
> -
> -	pri->dev = dev;
> -
> -	conn = vde_open(pri->vde_switch, pri->descr, pri->args);
> -
> -	if (conn == NULL) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "vde_user_init: vde_open failed, "
> -		       "errno = %d\n", errno);
> -		return err;
> -	}
> -
> -	printk(UM_KERN_INFO "vde backend - connection opened\n");
> -
> -	pri->conn = conn;
> -
> -	return 0;
> -}
> -
> -static int vde_user_open(void *data)
> -{
> -	struct vde_data *pri = data;
> -
> -	if (pri->conn != NULL)
> -		return vde_datafd(pri->conn);
> -
> -	printk(UM_KERN_WARNING "vde_open - we have no VDECONN to open");
> -	return -EINVAL;
> -}
> -
> -static void vde_remove(void *data)
> -{
> -	struct vde_data *pri = data;
> -
> -	if (pri->conn != NULL) {
> -		printk(UM_KERN_INFO "vde backend - closing connection\n");
> -		vde_close(pri->conn);
> -		pri->conn = NULL;
> -		kfree(pri->args);
> -		pri->args = NULL;
> -		return;
> -	}
> -
> -	printk(UM_KERN_WARNING "vde_remove - we have no VDECONN to remove");
> -}
> -
> -const struct net_user_info vde_user_info = {
> -	.init		= vde_user_init,
> -	.open		= vde_user_open,
> -	.close	 	= NULL,
> -	.remove	 	= vde_remove,
> -	.add_address	= NULL,
> -	.delete_address = NULL,
> -	.mtu		= ETH_MAX_PACKET,
> -	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_OTHER,
> -};
> -
> -void vde_init_libstuff(struct vde_data *vpri, struct vde_init *init)
> -{
> -	struct vde_open_args *args;
> -
> -	vpri->args = uml_kmalloc(sizeof(struct vde_open_args), UM_GFP_KERNEL);
> -	if (vpri->args == NULL) {
> -		printk(UM_KERN_ERR "vde_init_libstuff - vde_open_args "
> -		       "allocation failed");
> -		return;
> -	}
> -
> -	args = vpri->args;
> -
> -	args->port = init->port;
> -	args->group = init->group;
> -	args->mode = init->mode ? init->mode : 0700;
> -
> -	args->port ?  printk("port %d", args->port) :
> -		printk("undefined port");
> -}
> -
> -int vde_user_read(void *conn, void *buf, int len)
> -{
> -	VDECONN *vconn = conn;
> -	int rv;
> -
> -	if (vconn == NULL)
> -		return 0;
> -
> -	rv = vde_recv(vconn, buf, len, 0);
> -	if (rv < 0) {
> -		if (errno == EAGAIN)
> -			return 0;
> -		return -errno;
> -	}
> -	else if (rv == 0)
> -		return -ENOTCONN;
> -
> -	return rv;
> -}
> -
> -int vde_user_write(void *conn, void *buf, int len)
> -{
> -	VDECONN *vconn = conn;
> -
> -	if (vconn == NULL)
> -		return 0;
> -
> -	return vde_send(vconn, buf, len, 0);
> -}
> -
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index 152a60080d5b..e63a74a5ff19 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -143,7 +143,6 @@ extern int os_access(const char *file, int mode);
>   extern int os_set_exec_close(int fd);
>   extern int os_ioctl_generic(int fd, unsigned int cmd, unsigned long arg);
>   extern int os_get_ifname(int fd, char *namebuf);
> -extern int os_set_slip(int fd);
>   extern int os_mode_fd(int fd, int mode);
>   
>   extern int os_seek_file(int fd, unsigned long long offset);
> diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
> index 049dfa5bc9c6..fae836713487 100644
> --- a/arch/um/os-Linux/Makefile
> +++ b/arch/um/os-Linux/Makefile
> @@ -8,7 +8,7 @@ KCOV_INSTRUMENT                := n
>   
>   obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
>   	registers.o sigio.o signal.o start_up.o time.o tty.o \
> -	umid.o user_syms.o util.o drivers/ skas/
> +	umid.o user_syms.o util.o skas/
>   
>   CFLAGS_signal.o += -Wframe-larger-than=4096
>   
> diff --git a/arch/um/os-Linux/drivers/Makefile b/arch/um/os-Linux/drivers/Makefile
> deleted file mode 100644
> index cf2d75bb1884..000000000000
> --- a/arch/um/os-Linux/drivers/Makefile
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Copyright (C) 2000, 2002 Jeff Dike (jdike@karaya.com)
> -#
> -
> -ethertap-objs := ethertap_kern.o ethertap_user.o
> -tuntap-objs := tuntap_kern.o tuntap_user.o
> -
> -obj-y =
> -obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap.o
> -obj-$(CONFIG_UML_NET_TUNTAP) += tuntap.o
> -
> -include $(srctree)/arch/um/scripts/Makefile.rules
> diff --git a/arch/um/os-Linux/drivers/etap.h b/arch/um/os-Linux/drivers/etap.h
> deleted file mode 100644
> index a475259f90e1..000000000000
> --- a/arch/um/os-Linux/drivers/etap.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#ifndef __DRIVERS_ETAP_H
> -#define __DRIVERS_ETAP_H
> -
> -#include <net_user.h>
> -
> -struct ethertap_data {
> -	char *dev_name;
> -	char *gate_addr;
> -	int data_fd;
> -	int control_fd;
> -	void *dev;
> -};
> -
> -extern const struct net_user_info ethertap_user_info;
> -
> -#endif
> diff --git a/arch/um/os-Linux/drivers/ethertap_kern.c b/arch/um/os-Linux/drivers/ethertap_kern.c
> deleted file mode 100644
> index 5e5ee40680ce..000000000000
> --- a/arch/um/os-Linux/drivers/ethertap_kern.c
> +++ /dev/null
> @@ -1,100 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
> - * James Leu (jleu@mindspring.net).
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - * Copyright (C) 2001 by various other people who didn't put their name here.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/netdevice.h>
> -#include "etap.h"
> -#include <net_kern.h>
> -
> -struct ethertap_init {
> -	char *dev_name;
> -	char *gate_addr;
> -};
> -
> -static void etap_init(struct net_device *dev, void *data)
> -{
> -	struct uml_net_private *pri;
> -	struct ethertap_data *epri;
> -	struct ethertap_init *init = data;
> -
> -	pri = netdev_priv(dev);
> -	epri = (struct ethertap_data *) pri->user;
> -	epri->dev_name = init->dev_name;
> -	epri->gate_addr = init->gate_addr;
> -	epri->data_fd = -1;
> -	epri->control_fd = -1;
> -	epri->dev = dev;
> -
> -	printk(KERN_INFO "ethertap backend - %s", epri->dev_name);
> -	if (epri->gate_addr != NULL)
> -		printk(KERN_CONT ", IP = %s", epri->gate_addr);
> -	printk(KERN_CONT "\n");
> -}
> -
> -static int etap_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	int len;
> -
> -	len = net_recvfrom(fd, skb_mac_header(skb),
> -			   skb->dev->mtu + 2 + ETH_HEADER_ETHERTAP);
> -	if (len <= 0)
> -		return(len);
> -
> -	skb_pull(skb, 2);
> -	len -= 2;
> -	return len;
> -}
> -
> -static int etap_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	skb_push(skb, 2);
> -	return net_send(fd, skb->data, skb->len);
> -}
> -
> -const struct net_kern_info ethertap_kern_info = {
> -	.init			= etap_init,
> -	.protocol		= eth_protocol,
> -	.read			= etap_read,
> -	.write 			= etap_write,
> -};
> -
> -static int ethertap_setup(char *str, char **mac_out, void *data)
> -{
> -	struct ethertap_init *init = data;
> -
> -	*init = ((struct ethertap_init)
> -		{ .dev_name 	= NULL,
> -		  .gate_addr 	= NULL });
> -	if (tap_setup_common(str, "ethertap", &init->dev_name, mac_out,
> -			    &init->gate_addr))
> -		return 0;
> -	if (init->dev_name == NULL) {
> -		printk(KERN_ERR "ethertap_setup : Missing tap device name\n");
> -		return 0;
> -	}
> -
> -	return 1;
> -}
> -
> -static struct transport ethertap_transport = {
> -	.list 		= LIST_HEAD_INIT(ethertap_transport.list),
> -	.name 		= "ethertap",
> -	.setup  	= ethertap_setup,
> -	.user 		= &ethertap_user_info,
> -	.kern 		= &ethertap_kern_info,
> -	.private_size 	= sizeof(struct ethertap_data),
> -	.setup_size 	= sizeof(struct ethertap_init),
> -};
> -
> -static int register_ethertap(void)
> -{
> -	register_transport(&ethertap_transport);
> -	return 0;
> -}
> -
> -late_initcall(register_ethertap);
> diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
> deleted file mode 100644
> index bdf215c0eca7..000000000000
> --- a/arch/um/os-Linux/drivers/ethertap_user.c
> +++ /dev/null
> @@ -1,248 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
> - * James Leu (jleu@mindspring.net).
> - * Copyright (C) 2001 by various other people who didn't put their name here.
> - */
> -
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <sys/socket.h>
> -#include <sys/wait.h>
> -#include "etap.h"
> -#include <os.h>
> -#include <net_user.h>
> -#include <um_malloc.h>
> -
> -#define MAX_PACKET ETH_MAX_PACKET
> -
> -static int etap_user_init(void *data, void *dev)
> -{
> -	struct ethertap_data *pri = data;
> -
> -	pri->dev = dev;
> -	return 0;
> -}
> -
> -struct addr_change {
> -	enum { ADD_ADDR, DEL_ADDR } what;
> -	unsigned char addr[4];
> -	unsigned char netmask[4];
> -};
> -
> -static void etap_change(int op, unsigned char *addr, unsigned char *netmask,
> -			int fd)
> -{
> -	struct addr_change change;
> -	char *output;
> -	int n;
> -
> -	change.what = op;
> -	memcpy(change.addr, addr, sizeof(change.addr));
> -	memcpy(change.netmask, netmask, sizeof(change.netmask));
> -	CATCH_EINTR(n = write(fd, &change, sizeof(change)));
> -	if (n != sizeof(change)) {
> -		printk(UM_KERN_ERR "etap_change - request failed, err = %d\n",
> -		       errno);
> -		return;
> -	}
> -
> -	output = uml_kmalloc(UM_KERN_PAGE_SIZE, UM_GFP_KERNEL);
> -	if (output == NULL)
> -		printk(UM_KERN_ERR "etap_change : Failed to allocate output "
> -		       "buffer\n");
> -	read_output(fd, output, UM_KERN_PAGE_SIZE);
> -	if (output != NULL) {
> -		printk("%s", output);
> -		kfree(output);
> -	}
> -}
> -
> -static void etap_open_addr(unsigned char *addr, unsigned char *netmask,
> -			   void *arg)
> -{
> -	etap_change(ADD_ADDR, addr, netmask, *((int *) arg));
> -}
> -
> -static void etap_close_addr(unsigned char *addr, unsigned char *netmask,
> -			    void *arg)
> -{
> -	etap_change(DEL_ADDR, addr, netmask, *((int *) arg));
> -}
> -
> -struct etap_pre_exec_data {
> -	int control_remote;
> -	int control_me;
> -	int data_me;
> -};
> -
> -static void etap_pre_exec(void *arg)
> -{
> -	struct etap_pre_exec_data *data = arg;
> -
> -	dup2(data->control_remote, 1);
> -	close(data->data_me);
> -	close(data->control_me);
> -}
> -
> -static int etap_tramp(char *dev, char *gate, int control_me,
> -		      int control_remote, int data_me, int data_remote)
> -{
> -	struct etap_pre_exec_data pe_data;
> -	int pid, err, n;
> -	char version_buf[sizeof("nnnnn\0")];
> -	char data_fd_buf[sizeof("nnnnnn\0")];
> -	char gate_buf[sizeof("nnn.nnn.nnn.nnn\0")];
> -	char *setup_args[] = { "uml_net", version_buf, "ethertap", dev,
> -			       data_fd_buf, gate_buf, NULL };
> -	char *nosetup_args[] = { "uml_net", version_buf, "ethertap",
> -				 dev, data_fd_buf, NULL };
> -	char **args, c;
> -
> -	sprintf(data_fd_buf, "%d", data_remote);
> -	sprintf(version_buf, "%d", UML_NET_VERSION);
> -	if (gate != NULL) {
> -		strscpy(gate_buf, gate);
> -		args = setup_args;
> -	}
> -	else args = nosetup_args;
> -
> -	err = 0;
> -	pe_data.control_remote = control_remote;
> -	pe_data.control_me = control_me;
> -	pe_data.data_me = data_me;
> -	pid = run_helper(etap_pre_exec, &pe_data, args);
> -
> -	if (pid < 0)
> -		err = pid;
> -	close(data_remote);
> -	close(control_remote);
> -	CATCH_EINTR(n = read(control_me, &c, sizeof(c)));
> -	if (n != sizeof(c)) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "etap_tramp : read of status failed, "
> -		       "err = %d\n", -err);
> -		return err;
> -	}
> -	if (c != 1) {
> -		printk(UM_KERN_ERR "etap_tramp : uml_net failed\n");
> -		err = helper_wait(pid);
> -	}
> -	return err;
> -}
> -
> -static int etap_open(void *data)
> -{
> -	struct ethertap_data *pri = data;
> -	char *output;
> -	int data_fds[2], control_fds[2], err, output_len;
> -
> -	err = tap_open_common(pri->dev, pri->gate_addr);
> -	if (err)
> -		return err;
> -
> -	err = socketpair(AF_UNIX, SOCK_DGRAM, 0, data_fds);
> -	if (err) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "etap_open - data socketpair failed - "
> -		       "err = %d\n", errno);
> -		return err;
> -	}
> -
> -	err = socketpair(AF_UNIX, SOCK_STREAM, 0, control_fds);
> -	if (err) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "etap_open - control socketpair failed - "
> -		       "err = %d\n", errno);
> -		goto out_close_data;
> -	}
> -
> -	err = etap_tramp(pri->dev_name, pri->gate_addr, control_fds[0],
> -			 control_fds[1], data_fds[0], data_fds[1]);
> -	output_len = UM_KERN_PAGE_SIZE;
> -	output = uml_kmalloc(output_len, UM_GFP_KERNEL);
> -	read_output(control_fds[0], output, output_len);
> -
> -	if (output == NULL)
> -		printk(UM_KERN_ERR "etap_open : failed to allocate output "
> -		       "buffer\n");
> -	else {
> -		printk("%s", output);
> -		kfree(output);
> -	}
> -
> -	if (err < 0) {
> -		printk(UM_KERN_ERR "etap_tramp failed - err = %d\n", -err);
> -		goto out_close_control;
> -	}
> -
> -	pri->data_fd = data_fds[0];
> -	pri->control_fd = control_fds[0];
> -	iter_addresses(pri->dev, etap_open_addr, &pri->control_fd);
> -	return data_fds[0];
> -
> -out_close_control:
> -	close(control_fds[0]);
> -	close(control_fds[1]);
> -out_close_data:
> -	close(data_fds[0]);
> -	close(data_fds[1]);
> -	return err;
> -}
> -
> -static void etap_close(int fd, void *data)
> -{
> -	struct ethertap_data *pri = data;
> -
> -	iter_addresses(pri->dev, etap_close_addr, &pri->control_fd);
> -	close(fd);
> -
> -	if (shutdown(pri->data_fd, SHUT_RDWR) < 0)
> -		printk(UM_KERN_ERR "etap_close - shutdown data socket failed, "
> -		       "errno = %d\n", errno);
> -
> -	if (shutdown(pri->control_fd, SHUT_RDWR) < 0)
> -		printk(UM_KERN_ERR "etap_close - shutdown control socket "
> -		       "failed, errno = %d\n", errno);
> -
> -	close(pri->data_fd);
> -	pri->data_fd = -1;
> -	close(pri->control_fd);
> -	pri->control_fd = -1;
> -}
> -
> -static void etap_add_addr(unsigned char *addr, unsigned char *netmask,
> -			  void *data)
> -{
> -	struct ethertap_data *pri = data;
> -
> -	tap_check_ips(pri->gate_addr, addr);
> -	if (pri->control_fd == -1)
> -		return;
> -	etap_open_addr(addr, netmask, &pri->control_fd);
> -}
> -
> -static void etap_del_addr(unsigned char *addr, unsigned char *netmask,
> -			  void *data)
> -{
> -	struct ethertap_data *pri = data;
> -
> -	if (pri->control_fd == -1)
> -		return;
> -
> -	etap_close_addr(addr, netmask, &pri->control_fd);
> -}
> -
> -const struct net_user_info ethertap_user_info = {
> -	.init		= etap_user_init,
> -	.open		= etap_open,
> -	.close	 	= etap_close,
> -	.remove	 	= NULL,
> -	.add_address	= etap_add_addr,
> -	.delete_address = etap_del_addr,
> -	.mtu		= ETH_MAX_PACKET,
> -	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_ETHERTAP,
> -};
> diff --git a/arch/um/os-Linux/drivers/tuntap.h b/arch/um/os-Linux/drivers/tuntap.h
> deleted file mode 100644
> index e364e42abfc5..000000000000
> --- a/arch/um/os-Linux/drivers/tuntap.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#ifndef __UM_TUNTAP_H
> -#define __UM_TUNTAP_H
> -
> -#include <net_user.h>
> -
> -struct tuntap_data {
> -	char *dev_name;
> -	int fixed_config;
> -	char *gate_addr;
> -	int fd;
> -	void *dev;
> -};
> -
> -extern const struct net_user_info tuntap_user_info;
> -
> -#endif
> diff --git a/arch/um/os-Linux/drivers/tuntap_kern.c b/arch/um/os-Linux/drivers/tuntap_kern.c
> deleted file mode 100644
> index ff022d9cf0dd..000000000000
> --- a/arch/um/os-Linux/drivers/tuntap_kern.c
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#include <linux/netdevice.h>
> -#include <linux/init.h>
> -#include <linux/skbuff.h>
> -#include <asm/errno.h>
> -#include <net_kern.h>
> -#include "tuntap.h"
> -
> -struct tuntap_init {
> -	char *dev_name;
> -	char *gate_addr;
> -};
> -
> -static void tuntap_init(struct net_device *dev, void *data)
> -{
> -	struct uml_net_private *pri;
> -	struct tuntap_data *tpri;
> -	struct tuntap_init *init = data;
> -
> -	pri = netdev_priv(dev);
> -	tpri = (struct tuntap_data *) pri->user;
> -	tpri->dev_name = init->dev_name;
> -	tpri->fixed_config = (init->dev_name != NULL);
> -	tpri->gate_addr = init->gate_addr;
> -	tpri->fd = -1;
> -	tpri->dev = dev;
> -
> -	printk(KERN_INFO "TUN/TAP backend - ");
> -	if (tpri->gate_addr != NULL)
> -		printk(KERN_CONT "IP = %s", tpri->gate_addr);
> -	printk(KERN_CONT "\n");
> -}
> -
> -static int tuntap_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return net_read(fd, skb_mac_header(skb),
> -			skb->dev->mtu + ETH_HEADER_OTHER);
> -}
> -
> -static int tuntap_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return net_write(fd, skb->data, skb->len);
> -}
> -
> -const struct net_kern_info tuntap_kern_info = {
> -	.init			= tuntap_init,
> -	.protocol		= eth_protocol,
> -	.read			= tuntap_read,
> -	.write 			= tuntap_write,
> -};
> -
> -static int tuntap_setup(char *str, char **mac_out, void *data)
> -{
> -	struct tuntap_init *init = data;
> -
> -	*init = ((struct tuntap_init)
> -		{ .dev_name 	= NULL,
> -		  .gate_addr 	= NULL });
> -	if (tap_setup_common(str, "tuntap", &init->dev_name, mac_out,
> -			    &init->gate_addr))
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static struct transport tuntap_transport = {
> -	.list 		= LIST_HEAD_INIT(tuntap_transport.list),
> -	.name 		= "tuntap",
> -	.setup  	= tuntap_setup,
> -	.user 		= &tuntap_user_info,
> -	.kern 		= &tuntap_kern_info,
> -	.private_size 	= sizeof(struct tuntap_data),
> -	.setup_size 	= sizeof(struct tuntap_init),
> -};
> -
> -static int register_tuntap(void)
> -{
> -	register_transport(&tuntap_transport);
> -	return 0;
> -}
> -
> -late_initcall(register_tuntap);
> diff --git a/arch/um/os-Linux/drivers/tuntap_user.c b/arch/um/os-Linux/drivers/tuntap_user.c
> deleted file mode 100644
> index 91f0e27ca3a6..000000000000
> --- a/arch/um/os-Linux/drivers/tuntap_user.c
> +++ /dev/null
> @@ -1,215 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <linux/if_tun.h>
> -#include <net/if.h>
> -#include <sys/ioctl.h>
> -#include <sys/socket.h>
> -#include <sys/wait.h>
> -#include <sys/uio.h>
> -#include <kern_util.h>
> -#include <os.h>
> -#include "tuntap.h"
> -
> -static int tuntap_user_init(void *data, void *dev)
> -{
> -	struct tuntap_data *pri = data;
> -
> -	pri->dev = dev;
> -	return 0;
> -}
> -
> -static void tuntap_add_addr(unsigned char *addr, unsigned char *netmask,
> -			    void *data)
> -{
> -	struct tuntap_data *pri = data;
> -
> -	tap_check_ips(pri->gate_addr, addr);
> -	if ((pri->fd == -1) || pri->fixed_config)
> -		return;
> -	open_addr(addr, netmask, pri->dev_name);
> -}
> -
> -static void tuntap_del_addr(unsigned char *addr, unsigned char *netmask,
> -			    void *data)
> -{
> -	struct tuntap_data *pri = data;
> -
> -	if ((pri->fd == -1) || pri->fixed_config)
> -		return;
> -	close_addr(addr, netmask, pri->dev_name);
> -}
> -
> -struct tuntap_pre_exec_data {
> -	int stdout_fd;
> -	int close_me;
> -};
> -
> -static void tuntap_pre_exec(void *arg)
> -{
> -	struct tuntap_pre_exec_data *data = arg;
> -
> -	dup2(data->stdout_fd, 1);
> -	close(data->close_me);
> -}
> -
> -static int tuntap_open_tramp(char *gate, int *fd_out, int me, int remote,
> -			     char *buffer, int buffer_len, int *used_out)
> -{
> -	struct tuntap_pre_exec_data data;
> -	char version_buf[sizeof("nnnnn\0")];
> -	char *argv[] = { "uml_net", version_buf, "tuntap", "up", gate,
> -			 NULL };
> -	char buf[CMSG_SPACE(sizeof(*fd_out))];
> -	struct msghdr msg;
> -	struct cmsghdr *cmsg;
> -	struct iovec iov;
> -	int pid, n, err;
> -
> -	sprintf(version_buf, "%d", UML_NET_VERSION);
> -
> -	data.stdout_fd = remote;
> -	data.close_me = me;
> -
> -	pid = run_helper(tuntap_pre_exec, &data, argv);
> -
> -	if (pid < 0)
> -		return pid;
> -
> -	close(remote);
> -
> -	msg.msg_name = NULL;
> -	msg.msg_namelen = 0;
> -	if (buffer != NULL) {
> -		iov = ((struct iovec) { buffer, buffer_len });
> -		msg.msg_iov = &iov;
> -		msg.msg_iovlen = 1;
> -	}
> -	else {
> -		msg.msg_iov = NULL;
> -		msg.msg_iovlen = 0;
> -	}
> -	msg.msg_control = buf;
> -	msg.msg_controllen = sizeof(buf);
> -	msg.msg_flags = 0;
> -	n = recvmsg(me, &msg, 0);
> -	*used_out = n;
> -	if (n < 0) {
> -		err = -errno;
> -		printk(UM_KERN_ERR "tuntap_open_tramp : recvmsg failed - "
> -		       "errno = %d\n", errno);
> -		return err;
> -	}
> -	helper_wait(pid);
> -
> -	cmsg = CMSG_FIRSTHDR(&msg);
> -	if (cmsg == NULL) {
> -		printk(UM_KERN_ERR "tuntap_open_tramp : didn't receive a "
> -		       "message\n");
> -		return -EINVAL;
> -	}
> -	if ((cmsg->cmsg_level != SOL_SOCKET) ||
> -	   (cmsg->cmsg_type != SCM_RIGHTS)) {
> -		printk(UM_KERN_ERR "tuntap_open_tramp : didn't receive a "
> -		       "descriptor\n");
> -		return -EINVAL;
> -	}
> -	*fd_out = ((int *) CMSG_DATA(cmsg))[0];
> -	os_set_exec_close(*fd_out);
> -	return 0;
> -}
> -
> -static int tuntap_open(void *data)
> -{
> -	struct ifreq ifr;
> -	struct tuntap_data *pri = data;
> -	char *output, *buffer;
> -	int err, fds[2], len, used;
> -
> -	err = tap_open_common(pri->dev, pri->gate_addr);
> -	if (err < 0)
> -		return err;
> -
> -	if (pri->fixed_config) {
> -		pri->fd = os_open_file("/dev/net/tun",
> -				       of_cloexec(of_rdwr(OPENFLAGS())), 0);
> -		if (pri->fd < 0) {
> -			printk(UM_KERN_ERR "Failed to open /dev/net/tun, "
> -			       "err = %d\n", -pri->fd);
> -			return pri->fd;
> -		}
> -		memset(&ifr, 0, sizeof(ifr));
> -		ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
> -		strscpy(ifr.ifr_name, pri->dev_name);
> -		if (ioctl(pri->fd, TUNSETIFF, &ifr) < 0) {
> -			err = -errno;
> -			printk(UM_KERN_ERR "TUNSETIFF failed, errno = %d\n",
> -			       errno);
> -			close(pri->fd);
> -			return err;
> -		}
> -	}
> -	else {
> -		err = socketpair(AF_UNIX, SOCK_DGRAM, 0, fds);
> -		if (err) {
> -			err = -errno;
> -			printk(UM_KERN_ERR "tuntap_open : socketpair failed - "
> -			       "errno = %d\n", errno);
> -			return err;
> -		}
> -
> -		buffer = get_output_buffer(&len);
> -		if (buffer != NULL)
> -			len--;
> -		used = 0;
> -
> -		err = tuntap_open_tramp(pri->gate_addr, &pri->fd, fds[0],
> -					fds[1], buffer, len, &used);
> -
> -		output = buffer;
> -		if (err < 0) {
> -			printk("%s", output);
> -			free_output_buffer(buffer);
> -			printk(UM_KERN_ERR "tuntap_open_tramp failed - "
> -			       "err = %d\n", -err);
> -			return err;
> -		}
> -
> -		pri->dev_name = uml_strdup(buffer);
> -		output += IFNAMSIZ;
> -		printk("%s", output);
> -		free_output_buffer(buffer);
> -
> -		close(fds[0]);
> -		iter_addresses(pri->dev, open_addr, pri->dev_name);
> -	}
> -
> -	return pri->fd;
> -}
> -
> -static void tuntap_close(int fd, void *data)
> -{
> -	struct tuntap_data *pri = data;
> -
> -	if (!pri->fixed_config)
> -		iter_addresses(pri->dev, close_addr, pri->dev_name);
> -	close(fd);
> -	pri->fd = -1;
> -}
> -
> -const struct net_user_info tuntap_user_info = {
> -	.init		= tuntap_user_init,
> -	.open		= tuntap_open,
> -	.close	 	= tuntap_close,
> -	.remove	 	= NULL,
> -	.add_address	= tuntap_add_addr,
> -	.delete_address = tuntap_del_addr,
> -	.mtu		= ETH_MAX_PACKET,
> -	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_OTHER,
> -};
> diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
> index a0d01c68ce3e..617886d1fb1e 100644
> --- a/arch/um/os-Linux/file.c
> +++ b/arch/um/os-Linux/file.c
> @@ -106,21 +106,6 @@ int os_get_ifname(int fd, char* namebuf)
>   	return 0;
>   }
>   
> -int os_set_slip(int fd)
> -{
> -	int disc, sencap;
> -
> -	disc = N_SLIP;
> -	if (ioctl(fd, TIOCSETD, &disc) < 0)
> -		return -errno;
> -
> -	sencap = 0;
> -	if (ioctl(fd, SIOCSIFENCAP, &sencap) < 0)
> -		return -errno;
> -
> -	return 0;
> -}
> -
>   int os_mode_fd(int fd, int mode)
>   {
>   	int err;

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

I think it is time - it has been marked obsolete for 5 years.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

