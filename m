Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8yDA-0005gn-Kk for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 05:56:01 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user20384)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8yD9-0002Q6-0e
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 05:56:00 -0700
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id
	l6CCtq4H003126 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 12 Jul 2007 13:55:52 +0100
From: Nix <nix@esperi.org.uk>
Date: Thu, 12 Jul 2007 13:55:51 +0100
Message-ID: <87odihsrvs.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: [uml-devel] block layer request length increases break 2.6.22.* COW
	ubd
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

My firewall has long been a UML instance sitting atop a COW-backed UBD,
with the UBD being marked immutable and sha1-checked against a copy
on a CD-R every boot.

Now 2.6.22.1 (and probably 2.6.22 as well) gives me a panic on boot
which 2.6.21.* did not. Here's the complete boot log, ending with the
panic:

loki:/home/firewall/run/esperi# /usr/bin/nice -n -10 su firewall -c "uml-esperi con=port:16380 con0=fd:0,fd:1 fakeide mem=96M ubd0=/mirror/uml/esperi-root-cow.image,/mirror/uml/esperi-root.image tty_log_dir=/home/firewall/log/esperi umid=esperi eth0=tuntap,tap0,00:60:97:79:E2:C1 eth1=tuntap,tap1"
Core dump limits :
        soft - 0
        hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
  - /proc/mm...found
  - PTRACE_FAULTINFO...found
  - PTRACE_LDT...found
UML running in SKAS3 mode
Linux version 2.6.22.1 (compiler@loki) (gcc version 4.1.2) #1 Thu Jul 12 12:19:15 BST 2007
Built 1 zonelists.  Total pages: 24384
Kernel command line: con=port:16380 con0=fd:0,fd:1 fakeide mem=96M ubd0=/mirror/uml/esperi-root-cow.image,/mirror/uml/esperi-root.image tty_log_dir=/home/firewall/log/esperi eth0=tuntap,tap0,00:60:97:79:E2:C1 eth1=tuntap,tap1 root=98:0
PID hash table entries: 512 (order: 9, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 94456k available
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Using 2.6 host AIO
NET: Registered protocol family 16
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
Checking host MADV_REMOVE support...OK
mconsole (version 2) initialized on /home/firewall/.uml/esperi/mconsole
Host TLS support detected
Detected host type: i386
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler deadline registered (default)
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
GACT probability NOT on
u32 classifier
    Performance counters on
    Actions configured
nf_conntrack version 0.5.0 (738 buckets, 5904 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
 ubda: unknown partition table
Warning: attempt to assign a globally valid ethernet address to a device
You should better enable the 2nd rightmost bit in the first byte of the MAC,
i.e. 02:60:97:79:e2:c1
Choosing a random ethernet address for device eth0
Netdevice 0 (02:1c:86:28:c2:df) : TUN/TAP backend -
Warning: attempt to assign a globally valid ethernet address to a device
You should better enable the 2nd rightmost bit in the first byte of the MAC,
i.e. 02:60:97:79:e2:c1
Choosing a random ethernet address for device eth1
Netdevice 1 (8e:00:d0:1e:a4:0d) : TUN/TAP backend -
VFS: Mounted root (ext2 filesystem) readonly.
Kernel panic - not syncing: Operation too long

EIP: 0073:[<b7f6c410>] CPU: 0 Not tainted ESP: 007b:b7f67fb8 EFLAGS: 00000292
    Not tainted
EAX: 00000000 EBX: 00006582 ECX: 00000013 EDX: 00006582
ESI: 0000657e EDI: 00000011 EBP: 00000000 DS: 007b ES: 007b
08267b94:  [<080780f3>] notifier_call_chain+0x25/0x4e
08267bb4:  [<08078191>] atomic_notifier_call_chain+0x15/0x19
08267bcc:  [<0806d0d6>] panic+0x52/0xd3
08267be8:  [<0805f27a>] cowify_req+0x38/0xcd
08267c08:  [<0805f4a5>] do_ubd_request+0xaa/0x137
08267c3c:  [<08105325>] generic_unplug_device+0x10/0x17
08267c48:  [<08105382>] blk_backing_dev_unplug+0x56/0x5e
08267c64:  [<0808a9d0>] sync_page+0x0/0x29
08267c68:  [<080be5a0>] block_sync_page+0x21/0x24
08267c74:  [<0808a9f0>] sync_page+0x20/0x29
08267c7c:  [<0819dfb0>] __wait_on_bit_lock+0x29/0x51
08267c94:  [<0808b014>] __lock_page+0x56/0x5c
08267cb0:  [<0807dc7a>] wake_bit_function+0x0/0x34
08267cc8:  [<0808bdc6>] filemap_nopage+0x1da/0x268
08267cdc:  [<0808e9bd>] __alloc_pages+0x4f/0x279
08267cf0:  [<08095570>] do_no_page+0x9a/0x2b0
08267d24:  [<08095952>] __handle_mm_fault+0xaa/0x181
08267d54:  [<080584c1>] handle_page_fault+0xe1/0x1e2
08267d84:  [<080595d2>] maybe_map+0x52/0x83
08267db4:  [<08059614>] do_op_one_page+0x11/0x6d
08267dc8:  [<08059703>] do_buffer_op+0x93/0x13c
08267dd8:  [<08059a35>] clear_chunk+0x0/0x21
08267de4:  [<08059a35>] clear_chunk+0x0/0x21
08267e04:  [<08064c80>] setjmp_wrapper+0x3f/0x48
08267e24:  [<08064c56>] setjmp_wrapper+0x15/0x48
08267e34:  [<080597d6>] buffer_op+0x2a/0x53
08267e38:  [<08059670>] do_buffer_op+0x0/0x13c
08267e48:  [<08059a35>] clear_chunk+0x0/0x21
08267e58:  [<080c66fe>] elf_map+0x78/0xb1
08267e64:  [<08059ad5>] clear_user_skas+0x65/0x70
08267e74:  [<08059a35>] clear_chunk+0x0/0x21
08267e88:  [<080c61aa>] padzero+0x1c/0x2c
08267e94:  [<080c7371>] load_elf_binary+0x816/0xbff
08267ee8:  [<080a3ef1>] copy_strings+0x1bd/0x207
08267f04:  [<080a4bee>] search_binary_handler+0x60/0xf5
08267f24:  [<080a4ddf>] do_execve+0x15c/0x1f4
08267f44:  [<08055952>] execve1+0x29/0x50
08267f64:  [<0805598e>] um_execve+0x15/0x3e
08267f7c:  [<08057928>] kernel_execve+0x2b/0x37
08267f98:  [<0805532d>] run_init_process+0x19/0x1d
08267fa8:  [<080553be>] init_post+0x8d/0xb7
08267fb0:  [<080497eb>] kernel_init+0x7b/0x80
08267fbc:  [<08063487>] run_kernel_thread+0x38/0x41
08267fd8:  [<0806346a>] run_kernel_thread+0x1b/0x41
08267fe4:  [<08058f1b>] new_thread_handler+0x53/0x79
08267fe8:  [<08049770>] kernel_init+0x0/0x80

A little instrumentation of the failing conditional shows:

Kernel panic - not syncing: Operation too long: length 23552, max 16384

So it seems that requests from the block layer are too long for
cowify_req() nowadays: there can be more sectors in them than there are
bits in an `unsigned long'. I'm not sure what the maximum bounds are
now: boosting the `sector_mask' to an `unsigned long long' doesn't help
because we just get a bigger request:

Kernel panic - not syncing: Operation too long: length 65536, max 32768

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
