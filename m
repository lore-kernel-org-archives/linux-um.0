Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1XGVt4-0003iS-C9
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Aug 2014 16:22:26 +0000
Received: from mout.gmx.net ([212.227.17.22])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XGVt3-0006ol-17
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Aug 2014 16:22:26 +0000
Received: from [192.168.178.21] ([78.54.145.19]) by mail.gmx.com (mrgmx103)
	with ESMTPSA (Nemesis) id 0MSdRI-1Wp78A2Nfg-00RZbw for
	<user-mode-linux-devel@lists.sourceforge.net>; Sun, 10 Aug 2014 18:22:18
	+0200
Message-ID: <53E79C39.3070606@gmx.de>
Date: Sun, 10 Aug 2014 18:22:17 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] 3.16.0-10436-g9138475 - first impression
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Well, might be too early to try the new kernel at a 32 bit Linux, but this is what I got today (just once, next attempt to start the kernel worked fine) :

tfoerste@n22 /mnt/ramdisk $ stresc Xterm.log.n22.2014.08.10.17.43.36.9202    
Locating the bottom of the address space ... 0x1000
Locating the top of the address space ... 0xc0000000
Core dump limits :
        soft - 0
        hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking environment variables for a tempdir...none found
Checking if /dev/shm is on tmpfs...OK
Checking PROT_EXEC mmap in /dev/shm...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found: No such file or directory
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Adding 3354624 bytes to physical memory to account for exec-shield gap
Kernel virtual memory size shrunk to 976224256 bytes
bootconsole [earlycon0] enabled
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Sorting __ex_table...
Memory: 2007004K/2051276K available (4824K kernel code, 304K rwdata, 1776K rodata, 118K init, 241K bss, 44272K reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:15
Calibrating delay loop... 898.66 BogoMIPS (lpj=4493312)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 4096 (order: 2, 16384 bytes)
Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes)
Checking for host processor cmov support...Yes
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
devtmpfs: initialized
Using 2.6 host AIO
xor: measuring software checksum speed
   8regs     :  1351.600 MB/sec
   8regs_prefetch:  1192.400 MB/sec
   32regs    :   740.400 MB/sec
   32regs_prefetch:   666.400 MB/sec
xor: using function: 8regs (1351.600 MB/sec)
prandom: seed boundary self test passed
prandom: 100 self tests passed
NET: Registered protocol family 16
raid6: int32x1    235 MB/s
raid6: int32x2    216 MB/s
raid6: int32x4    153 MB/s
raid6: int32x8    237 MB/s
raid6: using algorithm int32x8 (237 MB/s)
raid6: using intx1 recovery algorithm
Switched to clocksource itimer

EIP: 0073:[<0808028c>] CPU: 0 Not tainted ESP: 007b:84ca7e60 EFLAGS: 00010202
    Not tainted
EAX: 086f7970 EBX: 00000000 ECX: 00000001 EDX: 7d332fff
ESI: 84ca7e9c EDI: 085cc0b2 EBP: 84ca7e88 DS: 007b ES: 007b
Kernel panic - not syncing: Segfault with no mm
CPU: 0 PID: 1 Comm: swapper Not tainted 3.16.0-10436-g9138475 #3
Stack:
 086f7970 08364f4d 84c499c0 84cd08b0 00000000 7d332fff 086fee70 7d332fff
 ffffffff 08166980 84ca7ec4 080808ba 84ca7eb8 00000000 84ca7ea4 00000000
 7d332fff 84ca7ec4 80000200 84d5aa50 84d5aa50 84d5aaa9 086d5064 00000000
Call Trace:
 [<08364f4d>] ? ida_get_new_above+0x18d/0x1b0
 [<08166980>] ? kclist_add_private+0x0/0xb0
 [<080808ba>] walk_system_ram_range+0x8a/0xa0
 [<08166a69>] kcore_update_ram+0x39/0x160
 [<08166980>] ? kclist_add_private+0x0/0xb0
 [<08053ed4>] proc_kcore_init+0x87/0x8b
 [<08048a68>] do_one_initcall+0x115/0x1c3
 [<08053e4d>] ? proc_kcore_init+0x0/0x8b
 [<08507abc>] ? _raw_spin_unlock_irqrestore+0x1c/0x20
 [<08071c2e>] ? set_signals+0x1e/0x40
 [<08048239>] ? repair_env_string+0x1a/0x91
 [<08093654>] ? parse_args+0x214/0x360
 [<08048c0f>] kernel_init_freeable+0xf9/0x19d
 [<08053e4d>] ? proc_kcore_init+0x0/0x8b
 [<0804821f>] ? repair_env_string+0x0/0x91
 [<084ff00b>] kernel_init+0xb/0xe0
 [<0805f69b>] new_thread_handler+0x6b/0x90

/home/tfoerste/workspace/bin/start_uml.sh: line 110:  9231 Aborted                 $LINUX earlyprintk ubda=$ROOTFS ubdb=$SWAP eth0=$NET mem=$MEM $TTY umid=uml_$NAME rootfstype=ext4 "$ARGS"
                                                                                                        rase is backspace.



Usually something like the following I'd expected :

NET: Registered protocol family 2
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 6, 327680 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP: reno registered
UDP hash table entries: 1024 (order: 3, 49152 bytes)
UDP-Lite hash table entries: 1024 (order: 3, 49152 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.

-- 
Toralf


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

