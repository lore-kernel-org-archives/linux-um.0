Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GagDj-0001cq-Qr for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Oct 2006 15:18:35 -0700
Received: from newcod.sandelman.ca ([192.139.46.42] helo=cod.sandelman.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GagDh-0004js-QZ
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Oct 2006 15:18:35 -0700
Received: from sandelman.ottawa.on.ca (desk.marajade.sandelman.ca
	[205.150.200.247])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "marajade.sandelman.ca.",
	Issuer "Michael Richardson" (verified OK))
	by cod.sandelman.ca (Postfix) with ESMTP id 72FA812DF3
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Thu, 19 Oct 2006 18:18:22 -0400 (EDT)
References: <v0r6x41bnb.fsf@marajade.sandelman.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Date: Thu, 19 Oct 2006 18:18:19 -0400
In-Reply-To: <v0r6x41bnb.fsf@marajade.sandelman.ca> (Michael Richardson's
	message of "Thu, 19 Oct 2006 13:03:04 -0400")
Message-ID: <v0vemg6jbo.fsf@marajade.sandelman.ca>
MIME-Version: 1.0
Subject: Re: [uml-devel] Xen 3.0.2 and UML guest
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: User-mode-linux-devel@lists.sourceforge.net


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Michael" == Michael Richardson <mcr@sandelman.ottawa.on.ca> writes:
    Michael> The fault may well be Xen's.  I'm looking for other experiences,
    Michael> yeah or nay.

I built a tree on my laptop as I normally do. It runs etch, and as does my
debian XenU.  With 2.6.15 UML guest on my laptop, everything is fine.

Same binary running under a XenU, goes into R state under XenU:

 5749 pts/1    Ss+    0:00 /bin/sh /0i/sandboxes/UMLPOOL/260ocf/umlbuild/east/st
 5750 pts/1    R+     2:33 /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux in
 5756 pts/1    S+     0:00 /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux in
 5757 pts/1    S+     0:00 /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux in
 5758 pts/1    S+     0:00 /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux in
 5759 pts/1    T+     1:19 [linux]

It looks like this happens as soon as the scheduler is enabled.
mode=tt WORKS.

Running uml_mconsole east sysrq t:

Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking PROT_EXEC mmap in /tmp...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode

    <BIG PAUSE ******>

Linux version 2.6.15 (mcr@marajade.sandelman.ca) (gcc version 4.1.2 20060901 (pr                      erelease) (Debian 4.1.1-13)) #2 Thu Oct 19 17:29:21 EDT 2006
Built 1 zonelists
Kernel command line: initrd=/0i/sandboxes/UMLPOOL/260ocf/umlbuild/initrd.uml uml                      root=/0i/sandboxes/UMLPOOL/260ocf/umlbuild/east/root root=/dev/ram0 rw ssl=pty e                      th0=mcast,10:00:00:dc:bc:ff,239.192.0.1,21200 eth1=mcast,10:00:00:64:64:23,239.1                      92.1.2,31200 eth2=mcast,10:00:00:32:64:23,239.192.3.2,31210 init=/linuxrc single
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 27336k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like a                      n initrd
Freeing initrd memory: 1228k freed
Using 2.6 host AIO
NET: Registered protocol family 16
Configured mcast device: 239.192.0.1:21200-1
Netdevice 0 (10:00:00:dc:bc:ff) : mcast backend multicast adddress: 239.192.0.1:                      21200, TTL:1 
Configured mcast device: 239.192.1.2:31200-1
Netdevice 1 (10:00:00:64:64:23) : mcast backend multicast adddress: 239.192.1.2:                      31200, TTL:1 
Configured mcast device: 239.192.3.2:31210-1
Netdevice 2 (10:00:00:32:64:23) : mcast backend multicast adddress: 239.192.3.2:                      31210, TTL:1 
mconsole (version 2) initialized on /home/mcr/.uml/east/mconsole
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
PPP generic driver version 2.4.2
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Netfilter messages via NETLINK v0.30.
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
klips_info:ipsec_init: KLIPS startup, Openswan KLIPS IPsec stack version: 2.6ocf                      .git-ge81dbb13-dirty
NET: Registered protocol family 15
klips_info:ipsec_alg_init: KLIPS alg v=0.8.1-0 (EALG_MAX=255, AALG_MAX=251)
klips_info:ipsec_alg_init: calling ipsec_alg_static_init()
ipsec_aes_init(alg_type=15 alg_id=12 name=aes): ret=0
ipsec_aes_init(alg_type=14 alg_id=9 name=aes_mac): ret=0
ipsec_3des_init(alg_type=15 alg_id=3 name=3des): ret=0
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.4 (213 buckets, 1704 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/proje                      cts/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
TCP westwood registered
TCP highspeed registered
TCP hybla registered
TCP htcp registered
TCP vegas registered
TCP scalable registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
Failed to open 'root_fs', errno = 2
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 1228KiB [1 disk] into ram disk... done.
VFS: Mounted root (cramfs filesystem) readonly.
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
linuxrc       R running     0     1      0     2               (NOTLB)
ksoftirqd/0   S 400017FF     0     2      1             3       (L-TLB)
a038fc58 00000001 a0388000 a09ce700 a09d6080 a038bb58 a038bab4 a00217d5 
       00000001 12002000 00000000 a038baf4 a01bfeb0 a038bb08 a038bb08 00000000 
       a038bb90 a0018d20 00000000 a038bb08 00000000 12002000 00000000 00000000 C                      all Trace: 
a038bb5c:  [<a00227bc>] switch_to_skas+0x3c/0x70
a038bb74:  [<a0016a03>] _switch_to+0x93/0xb0
a038bb9c:  [<a020a9cf>] schedule+0x30f/0x590
a038bbfc:  [<a00434c7>] ksoftirqd+0xb7/0xc0
a038bc18:  [<a0054fe6>] kthread+0xb6/0xc0
a038bc48:  [<a0030d15>] run_kernel_thread+0x35/0x40
a038bcf8:  [<a002288a>] new_thread_handler+0x9a/0xd0
a038bd1c:  [<bfffe420>] _etext+0x1fdf0ac0/0x0

watchdog/0    S 400017FF     0     3      1             4     2 (L-TLB)
a09cbb3c 00000001 a038c000 a09d6680 a09ce700 a038faf8 a038fa54 a00217d5 
       00000001 12002000 00000000 a038fa94 a01bfeb0 a038faa8 a038faa8 00000000 
       a038fb30 a0018d20 00000000 a038faa8 00000000 12002000 00000000 00000000 C                      all Trace: 
a038fafc:  [<a00227bc>] switch_to_skas+0x3c/0x70
a038fb14:  [<a0016a03>] _switch_to+0x93/0xb0
a038fb3c:  [<a020a9cf>] schedule+0x30f/0x590
a038fb9c:  [<a020b480>] schedule_timeout+0x50/0xc0
a038fbd4:  [<a020b511>] schedule_timeout_interruptible+0x21/0x30
a038fbe0:  [<a0049607>] msleep_interruptible+0x47/0x60
a038fbf4:  [<a005b51c>] watchdog+0x5c/0x90
a038fc18:  [<a0054fe6>] kthread+0xb6/0xc0
a038fc48:  [<a0030d15>] run_kernel_thread+0x35/0x40
a038fcf8:  [<a002288a>] new_thread_handler+0x9a/0xd0
a038fd1c:  [<bfffe420>] _etext+0x1fdf0ac0/0x0

events/0      S 400017FF     0     4      1             5     3 (L-TLB)
a09cbb3c 00000001 a0390000 a09d6680 a09ce100 a0393b04 a0393a60 a00217d5 
       00000001 12002000 00000000 a0393aa0 a01bfeb0 a0393ab4 a0393ab4 00000000 
       a0393b3c a0018d20 00000000 a0393ab4 00000000 12002000 00000000 00000000 C                      all Trace: 
a0393b08:  [<a00227bc>] switch_to_skas+0x3c/0x70
a0393b20:  [<a0016a03>] _switch_to+0x93/0xb0
a0393b48:  [<a020a9cf>] schedule+0x30f/0x590
a0393ba8:  [<a0050eea>] worker_thread+0x15a/0x280
a0393c18:  [<a0054fe6>] kthread+0xb6/0xc0
a0393c48:  [<a0030d15>] run_kernel_thread+0x35/0x40
a0393cf8:  [<a002288a>] new_thread_handler+0x9a/0xd0
a0393d1c:  [<bfffe420>] _etext+0x1fdf0ac0/0x0

khelper       S 400017FF     0     5      1             6     4 (L-TLB)
a0847c58 00000001 a0968000 a0972180 a0972780 a096bb04 a096ba60 a00217d5 
       00000001 12002000 00000000 a096baa0 a01bfeb0 a096bab4 a096bab4 00000000 
       a096bb3c a0018d20 00000000 a096bab4 00000000 12002000 00000000 00000000 C                      all Trace: 
a096bb08:  [<a00227bc>] switch_to_skas+0x3c/0x70
a096bb20:  [<a0016a03>] _switch_to+0x93/0xb0
a096bb48:  [<a020a9cf>] schedule+0x30f/0x590
a096bba8:  [<a0050eea>] worker_thread+0x15a/0x280
a096bc18:  [<a0054fe6>] kthread+0xb6/0xc0
a096bc48:  [<a0030d15>] run_kernel_thread+0x35/0x40
a096bcf8:  [<a002288a>] new_thread_handler+0x9a/0xd0
a096bd1c:  [<bfffe420>] _etext+0x1fdf0ac0/0x0

kthread       S 400017FF     0     6      1     7      10     5 (L-TLB)
a09cb9ac 00000001 a0844000 a09d6680 a0972180 a0847b04 a0847a60 a00217d5 
       00000001 12002000 00000000 a0847aa0 a01bfeb0 a0847ab4 a0847ab4 00000000 
       a0847b3c a0018d20 00000000 a0847ab4 00000000 12002000 00000000 00000000 C                      all Trace: 
a0847b08:  [<a00227bc>] switch_to_skas+0x3c/0x70
a0847b20:  [<a0016a03>] _switch_to+0x93/0xb0
a0847b48:  [<a020a9cf>] schedule+0x30f/0x590
a0847ba8:  [<a0050eea>] worker_thread+0x15a/0x280
a0847c18:  [<a0054fe6>] kthread+0xb6/0xc0
a0847c48:  [<a0030d15>] run_kernel_thread+0x35/0x40
a0847cf8:  [<a002288a>] new_thread_handler+0x9a/0xd0
a0847d1c:  [<bfffe420>] _etext+0x1fdf0ac0/0x0

kblockd/0     S 400017FF     0     7      6             8       (L-TLB)
a0847a68 00000001 a0abc000 a0972180 a0ab8800 a0abfb04 a0abfa60 a00217d5 
       00000001 12002000 00000000 a0abfaa0 a01bfeb0 a0abfab4 a0abfab4 00000000 
       a0abfb3c a0018d20 00000000 a0abfab4 00000000 12002000 00000000 00000000 C                      all Trace: 
a0abfb08:  [<a00227bc>] switch_to_skas+0x3c/0x70
a0abfb20:  [<a0016a03>] _switch_to+0x93/0xb0
a0abfb48:  [<a020a9cf>] schedule+0x30f/0x590
a0abfba8:  [<a0050eea>] worker_thread+0x15a/0x280
a0abfc18:  [<a0054fe6>] kthread+0xb6/0xc0
a0abfc48:  [<a0030d15>] run_kernel_thread+0x35/0x40
a0abfcf8:  [<a002288a>] new_thread_handler+0x9a/0xd0
a0abfd1c:  [<bfffe420>] _etext+0x1fdf0ac0/0x0

pdflush       S 400017FF     0     8      6             9     7 (L-TLB)
a0847a68 00000001 a085c000 a0972180 a0ab8200 a085fb28 a085fa84 a00217d5 
       00000001 12002000 00000000 a085fac4 a01bfeb0 a085fad8 a085fad8 00000000 
       a085fb60 a0018d20 00000000 a085fad8 00000000 12002000 00000000 00000000 C                      all Trace: 
a085fb2c:  [<a00227bc>] switch_to_skas+0x3c/0x70
a085fb44:  [<a0016a03>] _switch_to+0x93/0xb0
a085fb6c:  [<a020a9cf>] schedule+0x30f/0x590
a085fbcc:  [<a00637fe>] __pdflush+0x8e/0x180
a085fbe8:  [<a0063921>] pdflush+0x31/0x40
a085fc18:  [<a0054fe6>] kthread+0xb6/0xc0
a085fc48:  [<a0030d15>] run_kernel_thread+0x35/0x40
a085fcf8:  [<a002288a>] new_thread_handler+0x9a/0xd0
a085fd1c:  [<bfffe420>] _etext+0x1fdf0ac0/0x0

pdflush       S 400017FF     0     9      6            11     8 (L-TLB)
a09cbb3c 00000001 a0944000 a09d6680 a0940880 a0947b28 a0947a84 a00217d5 
       00000001 12002000 00000000 a0947ac4 a01bfeb0 a0947ad8 a0947ad8 00000000 
       a0947b60 a0018d20 00000000 a0947ad8 00000000 12002000 00000000 00000000 C                      all Trace: 
a0947b2c:  [<a00227bc>] switch_to_skas+0x3c/0x70
a0947b44:  [<a0016a03>] _switch_to+0x93/0xb0
a0947b6c:  [<a020a9cf>] schedule+0x30f/0x590
a0947bcc:  [<a00637fe>] __pdflush+0x8e/0x180
a0947be8:  [<a0063921>] pdflush+0x31/0x40
a0947c18:  [<a0054fe6>] kthread+0xb6/0xc0
a0947c48:  [<a0030d15>] run_kernel_thread+0x35/0x40
a0947cf8:  [<a002288a>] new_thread_handler+0x9a/0xd0
a0947d1c:  [<bfffe420>] _etext+0x1fdf0ac0/0x0

aio/0         S 400017FF     0    11      6            12     9 (L-TLB)
a0847a68 00000001 a094c000 a0972180 a0942900 a094fb04 a094fa60 a00217d5 
       00000001 12002000 00000000 a094faa0 a01bfeb0 a094fab4 a094fab4 00000000 
       a094fb3c a0018d20 00000000 a094fab4 00000000 12002000 00000000 00000000 C                      all Trace: 
a094fb08:  [<a00227bc>] switch_to_skas+0x3c/0x70
a094fb20:  [<a0016a03>] _switch_to+0x93/0xb0
a094fb48:  [<a020a9cf>] schedule+0x30f/0x590
a094fba8:  [<a0050eea>] worker_thread+0x15a/0x280
a094fc18:  [<a0054fe6>] kthread+0xb6/0xc0
a094fc48:  [<a0030d15>] run_kernel_thread+0x35/0x40
a094fcf8:  [<a002288a>] new_thread_handler+0x9a/0xd0
a094fd1c:  [<bfffe420>] _etext+0x1fdf0ac0/0x0

kswapd0       S 400017FF     0    10      1                   6 (L-TLB)
a09cb9c4 00000001 a0948000 a09d6680 a0940280 a094bb68 a094bac4 a00217d5 
       00000001 12002000 00000000 a094bb04 a01bfeb0 a094bb18 a094bb18 00000000 
       a094bba0 a0018d20 00000000 a094bb18 00000000 12002000 00000000 00000000 C                      all Trace: 
a094bb6c:  [<a00227bc>] switch_to_skas+0x3c/0x70
a094bb84:  [<a0016a03>] _switch_to+0x93/0xb0
a094bbac:  [<a020a9cf>] schedule+0x30f/0x590
a094bc0c:  [<a00691e4>] kswapd+0xd4/0xe0
a094bc48:  [<a0030d15>] run_kernel_thread+0x35/0x40
a094bcf8:  [<a002288a>] new_thread_handler+0x9a/0xd0
a094bd1c:  [<bfffe420>] _etext+0x1fdf0ac0/0x0

cqueue/0      S 400017FF     0    12      6                  11 (L-TLB)
a025fac8 00000001 a0adc000 a0260d60 a0942300 a0adfb04 a0adfa60 a00217d5 
       00000001 12002000 00000000 a0adfaa0 a01bfeb0 a0adfab4 a0adfab4 00000000 
       a0adfb3c a0018d20 00000000 a0adfab4 00000000 12002000 00000000 00000000 C                      all Trace: 
a0adfb08:  [<a00227bc>] switch_to_skas+0x3c/0x70
a0adfb20:  [<a0016a03>] _switch_to+0x93/0xb0
a0adfb48:  [<a020a9cf>] schedule+0x30f/0x590
a0adfba8:  [<a0050eea>] worker_thread+0x15a/0x280
a0adfc18:  [<a0054fe6>] kthread+0xb6/0xc0
a0adfc48:  [<a0030d15>] run_kernel_thread+0x35/0x40
a0adfcf8:  [<a002288a>] new_thread_handler+0x9a/0xd0
a0adfd1c:  [<bfffe420>] _etext+0x1fdf0ac0/0x0


- -- 
]            Bear: "Me, I'm just the shape of a bear."          |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQEVAwUBRTf1yYCLcPvd0N1lAQKrMwgAkGLSntN1c33uCn/bI+dN6WcnWPe3nltc
eAJpPA2edkSSfGHY+9GnNpe6ea2HT0gzCGGgmHbivSI6qflsG7wu2VAjSeB8TWOa
Y1ToLv01/kiakQSGAb9AYVXHEZjNJhBjdkgJNbzpOZ6FdUbdFgpvgun87bSBMJpu
Pae8VbK5UXry0pQDlDyQfcogJDFj675xCIRPwwrrIILbHvwtcNixG9Hp2Nst/6L7
DXA859W8m8P9MflX9DMv6De0E2lGWL4Ch9Lpt+4bz5T5pluZOXDcqUtSBUKV4nwp
6RJSk8fWulSlq3sUk/m9Nzb3/ZmygMcN7VqE3WxwKwH6OTyLpkqCzA==
=AcJ8
-----END PGP SIGNATURE-----

-- 
]            Bear: "Me, I'm just the shape of a bear."          |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
