Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Vmtok-0000Db-8I
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 23:19:18 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vmtof-0002sA-Lf
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 23:19:18 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 01 Dec 2013 00:19:03 +0100
Message-ID: <1555258.aSymPdfuDx@sandpuppy>
In-Reply-To: <529A31E3.8070305@gmx.de>
References: <5299F818.4070408@gmx.de> <1708241.BcyNY8F1Qe@sandpuppy>
	<529A31E3.8070305@gmx.de>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] does 3.12.2 breaks UML with "con=xterm" ?
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Am Samstag, 30. November 2013, 19:43:47 schrieb Toralf F=F6rster:
> On 11/30/2013 07:23 PM, Richard Weinberger wrote:
> > Sorry for being imprecise, I meant the raw output from UML, not GDB.
> > Currently it looks like yet another cluster fuck within the winch-Threa=
d.
> > =

> > Thanks,
> > //richard
> =

> ah - ok.
> =

> This is from the KOnsole starting the UML (FWIW the UML often starts,
> but failed to get an IP address via DHCP and then suddenly all xterms
> vanishe w/o any further core dump)
> =

> =

> tfoerste@n22 /mnt/ramdisk $ start_uml.sh -r ~/virtual/uml/trinity -y
> con=3Dxterm -l /home/tfoerste/devel/linux/linux +
> /home/tfoerste/devel/linux/linux earlyprintk
> ubda=3D/home/tfoerste/virtual/uml/trinity ubdb=3D/mnt/ramdisk/trinity_swap
> eth0=3Dtuntap,tap0,72:ef:3d:9f:c3:5a mem=3D1025M con=3Dxterm umid=3Duml_t=
rinity
> rootfstype=3Dext4 '' Locating the bottom of the address space ... 0x1000
> Locating the top of the address space ... 0xc0000000
> Core dump limits :
>         soft - NONE
>         hard - NONE
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking for tmpfs mount on /dev/shm.../dev/shm...OK
> Checking PROT_EXEC mmap in /dev/shm/...OK
> Checking for the skas3 patch in the host:
>   - /proc/mm...not found: No such file or directory
>   - PTRACE_FAULTINFO...not found
>   - PTRACE_LDT...not found
> UML running in SKAS0 mode
> Adding 23449600 bytes to physical memory to account for exec-shield gap
> bootconsole [earlycon0] enabled
> PID hash table entries: 4096 (order: 2, 16384 bytes)
> Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
> Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
> Sorting __ex_table...
> Memory: 1025168K/1072500K available (3932K kernel code, 283K rwdata, 1516K
> rodata, 114K init, 180K bss, 47332K reserved) SLUB: HWalign=3D64, Order=
=3D0-3,
> MinObjects=3D0, CPUs=3D1, Nodes=3D1
> NR_IRQS:15
> Calibrating delay loop... 2832.79 BogoMIPS (lpj=3D14163968)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> Checking for host processor cmov support...Yes
> Checking that host ptys support output SIGIO...Yes
> Checking that host ptys support SIGIO on close...No, enabling workaround
> devtmpfs: initialized
> Using 2.6 host AIO
> NET: Registered protocol family 16
> bio: create slab <bio-0> at 0
> Switched to clocksource itimer
> NET: Registered protocol family 2
> TCP established hash table entries: 16384 (order: 4, 65536 bytes)
> TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> TCP: reno registered
> UDP hash table entries: 1024 (order: 2, 16384 bytes)
> UDP-Lite hash table entries: 1024 (order: 2, 16384 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> console [stderr0] disabled
> mconsole (version 2) initialized on /home/tfoerste/.uml/uml_trinity/mcons=
ole
> Checking host MADV_REMOVE support...OK
> UML Audio Relay (host dsp =3D /dev/sound/dsp, host mixer =3D /dev/sound/m=
ixer)
> Host TLS support detected
> Detected host type: i386 (GDT indexes 6 to 9)
> audit: initializing netlink socket (disabled)
> type=3D2000 audit(1385836514.952:1): initialized
> zbud: loaded
> NFS: Registering the id_resolver key type
> Key type id_resolver registered
> Key type id_legacy registered
> nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> msgmni has been set to 2002
> alg: No test for stdrng (krng)
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
> io scheduler noop registered (default)
> loop: module loaded
> device-mapper: uevent: version 1.0.3
> device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised:
> dm-devel@redhat.com TCP: cubic registered
> NET: Registered protocol family 10
> sit: IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> Key type dns_resolver registered
> Initialized stdio console driver
> Console initialized on /dev/tty0
> console [tty0] enabled
> bootconsole [earlycon0] disabled
> =

> =

> =

> and it continues then with Gentoo's message in the xterm :
> =

> =

> =

> console [tty0] enabled
> bootconsole [earlycon0] disabled
> Initializing software serial port version 1
> console [mc-1] enabled
>  ubda: unknown partition table
>  ubdb: unknown partition table
> Netdevice 0 (72:ef:3d:9f:c3:5a) :
> TUN/TAP backend -
> EXT4-fs (ubda): INFO: recovery required on readonly filesystem
> EXT4-fs (ubda): write access will be enabled during recovery
> EXT4-fs (ubda): recovery complete
> EXT4-fs (ubda): mounted filesystem with ordered data mode. Opts: (null)
> VFS: Mounted root (ext4 filesystem) readonly on device 98:0.
> devtmpfs: mounted
> INIT: version 2.88 booting
> =

>    OpenRC 0.12.4 is starting up Gentoo Linux (i686) [UML]
> =

>  * Mounting /proc ...                                                    =
   =

>                                          [ ok ] * Mounting /run ...
>  * /run/openrc: creating directory
>  * /run/lock: creating directory
>  * /run/lock: correcting owner
>  * Using /dev mounted from kernel ...                                    =
   =

>                                          [ ok ] * Mounting /dev/mqueue ..=
. =

>                                                                          =
  =

>              [ ok ] * Mounting /dev/pts ...                              =
  =

>                                                              [ ok ] *
> Mounting /dev/shm ...                                                    =
  =

>                                        [ ok ] * Mounting /sys ...        =
  =

>                                                                          =
  =

>            [ ok ] * Mounting cgroup filesystem ...                       =
  =

>                                                            [ ok ] * setti=
ng
> up tmpfiles.d entries for /dev ...                                       =
  =

>                                [ ok ] * Starting udev ...                =
  =

>                                                                          =
  =

>    [ ok ] * Generating a rule to create a /dev/root symlink ...          =
  =

>                                                    [ ok ] * Populating /d=
ev
> with existing devices through uevents ...                                =
  =

>                        [ ok ] * Waiting for uevents to be processed ...  =
  =

>                                                                        [ =
ok
> ] * Remounting root filesystem read/write ...                            =
  =

>                                            [ ok ] * Remounting filesystems
> ...                                                                      =
  =

>                 [ ok ] * Updating /etc/mtab ...                          =
  =

>                                                                 [ ok ] *
> Activating swap devices ...                                              =
  =

>                                        [ ok ] * Mounting local filesystems
> ...                                                                      =
  =

>             [ ok ] * Configuring kernel parameters ...                   =
  =

>                                                             [ ok ] *
> Creating user login records ...                                          =
  =

>                                        [ ok ] * Wiping /tmp directory ...=
  =

>                                                                          =
  =

>            [ ok ] * Setting up dm-crypt mappings ...
>  *   crypt-swap using: -c aes -h sha1 -d /dev/urandom create crypt-swap
> /dev/ubdb ...                                 [ ok ] *     pre_mount:
> mkswap ${dev} ...                                                        =
  =

>                         [ ok ] * Setting hostname to trinity ...         =
  =

>                                                                         [
> ok ] * Bringing up network interface lo ...                              =
  =

>                                               [ ok ] * Bringing up
> interface lo
>  *   127.0.0.1/8 ...                                                     =
   =

>                                          [ ok ] *   Adding routes
>  *     127.0.0.0/8 via 127.0.0.1 ...                                     =
   =

>                                          [ ok ] * Mounting misc binary
> format filesystem ...                                                    =
  =

>                   [ ok ] * Loading custom binary format handlers ...     =
  =

>                                                                   [ ok ] *
> Activating additional swap space ...                                     =
  =

>                                        [ ok ] * setting up tmpfiles.d
> entries ...                                                              =
  =

>                  [ ok ] * Initializing random number generator ...       =
  =

>                                                                  [ ok ]
> INIT: Entering runlevel: 3
>  * Checking your configfile (/etc/syslog-ng/syslog-ng.conf) ...          =
   =

>                                          [ ok ] * Starting syslog-ng ... =
  =

>                                                                          =
  =

>              [ ok ] * Starting DHCP Client Daemon ...
>  * Starting haveged ...                                                  =
   =

>                                          [ ok ] * Starting rngd ...      =
  =

>                                                                          =
  =

>              [ ok ] * Starting sshd ...                                  =
  =

>                                                              [ ok ] *
> Starting vixie-cron ...                                                  =
  =

>                                        [ ok ] * Starting local
> net.core.warnings =3D 0                                                  =
     =

>                                          [ ok ]
> =

> =

> =

> and syslog shows in another xterm :
> =

> =

> =

> Nov 30 19:38:28 trinity syslog-ng[1076]: syslog-ng starting up;
> version=3D'3.4.2' Nov 30 19:38:28 trinity kernel: Initializing cgroup sub=
sys
> cpu
> Nov 30 19:38:28 trinity kernel: Linux version 3.13.0-rc2 (tfoerste@n22) (=
gcc
> version 4.7.3 (Gentoo 4.7.3-r1 p1.3, pie-0.5.5) ) #1 Sat Nov 30 19:09:51
> CET 2013 Nov 30 19:38:28 trinity kernel: On node 0 totalpages: 265364
> Nov 30 19:38:28 trinity kernel: free_area_init_node: node 0, pgdat 085f8b=
00,
> node_mem_map 0a025000 Nov 30 19:38:28 trinity kernel: Normal zone: 2074
> pages used for memmap Nov 30 19:38:28 trinity kernel: Normal zone: 0 pages
> reserved
> Nov 30 19:38:28 trinity kernel: Normal zone: 265364 pages, LIFO batch:31
> Nov 30 19:38:28 trinity kernel: pcpu-alloc: s0 r0 d32768 u32768
> alloc=3D1*32768 Nov 30 19:38:28 trinity kernel: pcpu-alloc: [0] 0
> Nov 30 19:38:28 trinity kernel: Built 1 zonelists in Zone order, mobility
> grouping on.  Total pages: 263290 Nov 30 19:38:29 trinity kernel: Kernel
> command line: earlyprintk ubda=3D/home/tfoerste/virtual/uml/trinity
> ubdb=3D/mnt/ramdisk/trinity_swap eth0=3Dtuntap,tap0,72:ef:3d:9f:c3:5a mem=
=3D1025M
> con=3Dxterm rootfstype=3Dext4  root=3D98:0 Nov 30 19:38:29 trinity kernel:
> bootconsole [earlycon0] enabled
> Nov 30 19:38:29 trinity kernel: PID hash table entries: 4096 (order: 2,
> 16384 bytes) Nov 30 19:38:29 trinity kernel: Dentry cache hash table
> entries: 262144 (order: 8, 1048576 bytes) Nov 30 19:38:29 trinity kernel:
> Inode-cache hash table entries: 131072 (order: 7, 524288 bytes) Nov 30
> 19:38:29 trinity kernel: Sorting __ex_table...
> Nov 30 19:38:29 trinity kernel: Memory: 1025316K/1061456K available (3932K
> kernel code, 283K rwdata, 1516K rodata, 114K init, 180K bss, 36140K
> reserved) Nov 30 19:38:29 trinity kernel: SLUB: HWalign=3D64, Order=3D0-3,
> MinObjects=3D0, CPUs=3D1, Nodes=3D1 Nov 30 19:38:29 trinity kernel: NR_IR=
QS:15
> Nov 30 19:38:29 trinity kernel: Calibrating delay loop... 3822.38 BogoMIPS
> (lpj=3D19111936) Nov 30 19:38:29 trinity kernel: pid_max: default: 32768
> minimum: 301 Nov 30 19:38:29 trinity kernel: Mount-cache hash table
> entries: 512 Nov 30 19:38:29 trinity kernel: Checking for host processor
> cmov support...Yes Nov 30 19:38:29 trinity kernel: Checking that host ptys
> support output SIGIO...Yes Nov 30 19:38:29 trinity kernel: Checking that
> host ptys support SIGIO on close...No, enabling workaround Nov 30 19:38:29
> trinity kernel: devtmpfs: initialized
> Nov 30 19:38:29 trinity kernel: Using 2.6 host AIO
> Nov 30 19:38:29 trinity kernel: NET: Registered protocol family 16
> Nov 30 19:38:29 trinity kernel: bio: create slab <bio-0> at 0
> Nov 30 19:38:29 trinity kernel: Switched to clocksource itimer
> Nov 30 19:38:29 trinity kernel: NET: Registered protocol family 2
> Nov 30 19:38:29 trinity kernel: TCP established hash table entries: 16384
> (order: 4, 65536 bytes) Nov 30 19:38:29 trinity kernel: TCP bind hash tab=
le
> entries: 16384 (order: 4, 65536 bytes) Nov 30 19:38:29 trinity kernel: TC=
P:
> Hash tables configured (established 16384 bind 16384) Nov 30 19:38:29
> trinity kernel: TCP: reno registered
> Nov 30 19:38:29 trinity kernel: UDP hash table entries: 1024 (order: 2,
> 16384 bytes) Nov 30 19:38:29 trinity kernel: UDP-Lite hash table entries:
> 1024 (order: 2, 16384 bytes) Nov 30 19:38:29 trinity kernel: NET:
> Registered protocol family 1
> Nov 30 19:38:29 trinity kernel: RPC: Registered named UNIX socket transpo=
rt
> module. Nov 30 19:38:29 trinity kernel: RPC: Registered udp transport
> module. Nov 30 19:38:29 trinity kernel: RPC: Registered tcp transport
> module. Nov 30 19:38:29 trinity kernel: RPC: Registered tcp NFSv4.1
> backchannel transport module. Nov 30 19:38:29 trinity kernel: console
> [stderr0] disabled
> Nov 30 19:38:29 trinity kernel: mconsole (version 2) initialized on
> /home/tfoerste/.uml/uml_trinity/mconsole Nov 30 19:38:29 trinity kernel:
> Checking host MADV_REMOVE support...OK Nov 30 19:38:29 trinity kernel: UML
> Audio Relay (host dsp =3D /dev/sound/dsp, host mixer =3D /dev/sound/mixer=
) Nov
> 30 19:38:29 trinity kernel: Host TLS support detected
> Nov 30 19:38:29 trinity kernel: Detected host type: i386 (GDT indexes 6 to
> 9) Nov 30 19:38:29 trinity kernel: audit: initializing netlink socket
> (disabled) Nov 30 19:38:29 trinity kernel: type=3D2000
> audit(1385836664.270:1): initialized Nov 30 19:38:29 trinity kernel: zbud:
> loaded
> Nov 30 19:38:29 trinity kernel: NFS: Registering the id_resolver key type
> Nov 30 19:38:29 trinity kernel: Key type id_resolver registered
> Nov 30 19:38:29 trinity kernel: Key type id_legacy registered
> Nov 30 19:38:29 trinity kernel: nfs4filelayout_init: NFSv4 File Layout
> Driver Registering... Nov 30 19:38:29 trinity kernel: Installing knfsd
> (copyright (C) 1996 okir@monad.swb.de). Nov 30 19:38:29 trinity kernel:
> msgmni has been set to 2002
> Nov 30 19:38:29 trinity kernel: alg: No test for stdrng (krng)
> Nov 30 19:38:29 trinity kernel: Block layer SCSI generic (bsg) driver
> version 0.4 loaded (major 254) Nov 30 19:38:29 trinity kernel: io schedul=
er
> noop registered (default) Nov 30 19:38:29 trinity kernel: loop: module
> loaded
> Nov 30 19:38:29 trinity kernel: device-mapper: uevent: version 1.0.3
> Nov 30 19:38:29 trinity kernel: device-mapper: ioctl: 4.27.0-ioctl
> (2013-10-30) initialised: dm-devel@redhat.com Nov 30 19:38:29 trinity
> kernel: TCP: cubic registered
> Nov 30 19:38:29 trinity kernel: NET: Registered protocol family 10
> Nov 30 19:38:29 trinity kernel: sit: IPv6 over IPv4 tunneling driver
> Nov 30 19:38:29 trinity kernel: NET: Registered protocol family 17
> Nov 30 19:38:29 trinity kernel: Key type dns_resolver registered
> Nov 30 19:38:29 trinity kernel: Initialized stdio console driver
> Nov 30 19:38:29 trinity kernel: Console initialized on /dev/tty0
> Nov 30 19:38:29 trinity kernel: console [tty0] enabled
> Nov 30 19:38:29 trinity kernel: bootconsole [earlycon0] disabled
> Nov 30 19:38:29 trinity kernel: Initializing software serial port version=
 1
> Nov 30 19:38:29 trinity kernel: console [mc-1] enabled
> Nov 30 19:38:29 trinity kernel: ubda: unknown partition table
> Nov 30 19:38:29 trinity kernel: ubdb: unknown partition table
> Nov 30 19:38:29 trinity kernel: Netdevice 0 (72:ef:3d:9f:c3:5a) :
> Nov 30 19:38:29 trinity kernel: TUN/TAP backend -
> Nov 30 19:38:29 trinity kernel: EXT4-fs (ubda): INFO: recovery required on
> readonly filesystem Nov 30 19:38:29 trinity kernel: EXT4-fs (ubda): write
> access will be enabled during recovery Nov 30 19:38:29 trinity kernel:
> EXT4-fs (ubda): recovery complete
> Nov 30 19:38:29 trinity kernel: EXT4-fs (ubda): mounted filesystem with
> ordered data mode. Opts: (null) Nov 30 19:38:29 trinity kernel: VFS:
> Mounted root (ext4 filesystem) readonly on device 98:0. Nov 30 19:38:29
> trinity kernel: devtmpfs: mounted
> Nov 30 19:38:29 trinity kernel[536]: starting version 204
> Nov 30 19:38:29 trinity kernel: random: nonblocking pool is initialized
> Nov 30 19:38:29 trinity kernel: EXT4-fs (ubda): re-mounted. Opts: (null)
> Nov 30 19:38:29 trinity kernel: bio: create slab <bio-1> at 1
> Nov 30 19:38:29 trinity kernel: Adding 262140k swap on
> /dev/mapper/crypt-swap.  Priority:-1 extents:1 across:262140k FS Nov 30
> 19:38:29 trinity kernel: type=3D1006 audit(1385836708.020:2): pid=3D1074 =
uid=3D0
> old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D1 res=
=3D1 Nov 30
> 19:38:29 trinity dhcpcd[1098]: version 5.6.4 starting
> Nov 30 19:38:30 trinity dhcpcd[1098]: sit0: unsupported interface type 30=
8,
> falling back to ethernet Nov 30 19:38:31 trinity dhcpcd[1098]: sit0:
> broadcasting for a lease Nov 30 19:38:31 trinity dhcpcd[1098]: eth0:
> sending IPv6 Router Solicitation Nov 30 19:38:31 trinity dhcpcd[1098]:
> eth0: checking for 169.254.229.237 Nov 30 19:38:35 trinity dhcpcd[1098]:
> eth0: sending IPv6 Router Solicitation Nov 30 19:38:36 trinity
> dhcpcd[1098]: eth0: using IPv4LL address 169.254.229.237 Nov 30 19:38:37
> trinity dhcpcd[1098]: forked to background, child pid 1138 Nov 30 19:38:38
> trinity haveged: haveged starting up
> Nov 30 19:38:39 trinity haveged: haveged: ver: 1.7a; arch: x86; vend:
> GenuineIntel; opts: (T); collect: 128K Nov 30 19:38:39 trinity haveged:
> haveged: cpu: (L4 VC); data: 32K (L4); inst: 32K (L4); idx: 18/40; sz:
> 32190/69480 Nov 30 19:38:39 trinity haveged: haveged: tot tests: BA8: A:1=
/0
> B: 1/0; continuous tests: B: A:0/0 B: 0/0; last entropy estimate 7.99992
> Nov 30 19:38:39 trinity haveged: haveged: fills: 0, generated: 0
> Nov 30 19:38:39 trinity dhcpcd[1138]: eth0: sending IPv6 Router Solicitat=
ion
> Nov 30 19:38:41 trinity dhcpcd[1138]: eth0: broadcasting for a lease Nov =
30
> 19:38:44 trinity dhcpcd[1138]: eth0: sending IPv6 Router Solicitation Nov
> 30 19:38:44 trinity dhcpcd[1138]: eth0: no IPv6 Routers available Nov 30
> 19:38:45 trinity cron[1228]: (CRON) STARTUP (V5.0)
> Nov 30 19:38:45 trinity kernel: [sched_delayed] sched: RT throttling
> activated Nov 30 19:40:01 trinity cron[1257]: (root) CMD (test -x
> /usr/sbin/run-crons && /usr/sbin/run-crons)
> =

> =

> after another minute now all xterms are away ....

So, it does not crash immediately.
Please do not use xterm for con0. Such that we can see the kernel output
after a crash.
Maybe there are some error message before...

Thanks,
//richard


---------------------------------------------------------------------------=
---
Rapidly troubleshoot problems before they affect your business. Most IT =

organizations don't have a clear picture of how application performance =

affects their revenue. With AppDynamics, you get 100% visibility into your =

Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics P=
ro!
http://pubads.g.doubleclick.net/gampad/clk?id=3D84349351&iu=3D/4140/ostg.cl=
ktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

