Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HAN55-0003Dj-A3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jan 2007 01:09:11 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HAN53-0002qi-8p
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jan 2007 01:09:11 -0800
Date: Fri, 26 Jan 2007 04:07:05 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.64.0701260101250.5924@sparrow>
MIME-Version: 1.0
Subject: [uml-devel] Possible hostfs uml kernel data corruption with missing
	host directory (fc6, 2.6.20-rc5-git3 on opteron)
Reply-To: William Stearns <wstearns@pobox.com>
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
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>

Good evening, all,
 	As an update, I've have very good luck with an x86_64 distribution 
(Fedora core 6) on a dual opteron machine with 2.6.20-rc5-git3; I've 
gotten it to boot completely with networking.
 	_Thank_ _you_ to everyone who has worked so hard to get it to 
where it is today.  I'm sincerely impressed at how well it works, 
including, it would appear, tls support.

 	There's a wierd bug that appears to be related to hostfs.  In the 
course of building a root filesystem for fc_6_x86_64, I got two root 
filesystems; when I boot one with that kernel, everything boots fine. 
When I booted the other root filesystem with the exact same kernel, the 
kernel crashes at the command: "ip link set dev lo up".  I included some 
of the kernel panic messages and strace info below, but I'll save you some 
time - I'm pretty sure it's not the fault of the ip command or the 
networking code.
 	After bisecting the difference between the two root filesystems, 
the critical change was a line in /etc/fstab:

none            /mirrors        hostfs  defaults,/home/mirrors  0 0

 	Woah.  Two _other_ similar hostfs lines do _not_ cause this crash. 
The problem is that unlike the other two hostfs lines, /home/mirrors 
didn't exist on the host - my mistake - but it caused a kernel crash in a 
completely different subsystem.
 	The unstripped kernel, System.map, and configuration are all at 
http://ford.stearns.org/uml/ (temporary url for them).  I did not apply 
any external uml patches to the 2.6.20-rc5-git3 tree.


 	(Again, following is my early wild goose chase.  :-)

Fedora Core release 6 (Zod)
Kernel 2.6.20-rc5-git3 on an x86_64

Unauthorized access to this system is strictly prohibited.
placeholder login: root
Password:
-bash-3.1# cd /etc/init.d
-bash-3.1# ./network start
Bringing up loopback interface:  Kernel panic - not syncing: Kernel mode 
fault at addr 0x403866d10, ip 0x404f6147

Pid: 2247, comm: ip Not tainted 2.6.20-rc5-git3
RIP: 0033:[<00000000404f6147>]
RSP: 0000007f7fa21ee8  EFLAGS: 00000246
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: ffffffffffffffff
RDX: 0000007f7fa21f20 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000007f7fa21f22 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000001 R14: 0000007f7fa21f20 R15: 0000000000000000
Call Trace:
71a9b2d8:  [<60017c13>] panic_exit+0x2f/0x49
71a9b2f8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
71a9b328:  [<6003d356>] atomic_notifier_call_chain+0x9/0xb
71a9b338:  [<60030924>] panic+0xe4/0x173
71a9b398:  [<6028462b>] __up_read+0x7f/0x84
71a9b3b8:  [<60045e11>] up_read+0x9/0xb
71a9b3c8:  [<6001727f>] handle_page_fault+0x1d3/0x225
71a9b428:  [<60017470>] segv+0x133/0x251
71a9b458:  [<600284f1>] sig_handler_common_skas+0xe5/0xff
71a9b4e8:  [<600172d1>] segv_handler+0x0/0x6c
71a9b508:  [<60017337>] segv_handler+0x66/0x6c
71a9b548:  [<600284f1>] sig_handler_common_skas+0xe5/0xff
71a9b588:  [<60024fba>] sig_handler+0x46/0x55
71a9b5b8:  [<600270e1>] hard_handler+0x15/0x18
71a9b5c8:  [<60394c40>] __restore_rt+0x0/0x10
71a9b678:  [<600652bf>] transfer_objects+0x3b/0x4d
71a9b708:  [<600271b6>] run_syscall_stub+0xd2/0xde
71a9b9a8:  [<60066959>] do_tune_cpucache+0xca/0xd7
71a9ba08:  [<60025350>] set_signals+0x1f/0x35
71a9ba18:  [<6006619d>] cache_alloc_refill+0x78/0x1a9
71a9ba68:  [<6006649f>] kmem_cache_alloc+0x45/0x5c
71a9ba98:  [<6031907e>] fn_hash_insert+0x217/0x38f
71a9baf8:  [<6031748e>] fib_magic+0xb3/0xca
71a9bb98:  [<60317517>] fib_add_ifaddr+0x72/0x132
71a9bbd8:  [<603178d9>] fib_inetaddr_event+0x1f/0x51
71a9bbf8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
71a9bc28:  [<6003d42d>] blocking_notifier_call_chain+0x32/0x49
71a9bc58:  [<603102d9>] __inet_insert_ifa+0x117/0x122
71a9bc88:  [<603102f1>] inet_insert_ifa+0xd/0xf
71a9bc98:  [<603110f9>] inetdev_event+0x124/0x1b4
71a9bcc8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
71a9bcf8:  [<6003d463>] raw_notifier_call_chain+0x9/0xb
71a9bd08:  [<602c9623>] dev_open+0x72/0x7a
71a9bd28:  [<602caada>] dev_change_flags+0x60/0x133
71a9bd58:  [<60310979>] devinet_ioctl+0x250/0x536
71a9be08:  [<6031269f>] inet_ioctl+0x71/0x8f
71a9be18:  [<602c08a6>] sock_ioctl+0x216/0x242
71a9be28:  [<600173e5>] segv+0xa8/0x251
71a9be58:  [<60073597>] do_ioctl+0x1b/0x50
71a9be68:  [<600739d9>] vfs_ioctl+0x231/0x24e
71a9bea8:  [<60073a38>] sys_ioctl+0x42/0x66
71a9bef8:  [<600184dd>] handle_syscall+0x65/0x80
71a9bf08:  [<60017337>] segv_handler+0x66/0x6c
71a9bf28:  [<600279cd>] handle_trap+0xd0/0xdb
71a9bf68:  [<60027e48>] userspace+0x139/0x181
71a9bfc8:  [<6001820c>] fork_handler+0x73/0x7a

 	If I bring the vm up without networking, add "set -x" to the top 
of /etc/init.d/network and /etc/sysconfig/network-scripts/ifup to trace 
their commands, here's the last few traced lines before the panic:

+ '[' '' = yes ']'
+ '[' '' = bootp -o '' = dhcp ']'
+ '[' -x /sbin/ifup-pre-local ']'
+ OTHERSCRIPT=/etc/sysconfig/network-scripts/ifup-lo
+ '[' '!' -x /etc/sysconfig/network-scripts/ifup-lo ']'
+ OTHERSCRIPT=/etc/sysconfig/network-scripts/ifup-eth
+ exec /etc/sysconfig/network-scripts/ifup-eth ifcfg-lo
Kernel panic - not syncing: Kernel mode fault at addr 0x410237bd0, ip 
0x404f6147

Pid: 2241, comm: ip Not tainted 2.6.20-rc5-git3
RIP: 0033:[<00000000404f6147>]
RSP: 0000007f7f9ee6b8  EFLAGS: 00000246
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: ffffffffffffffff
RDX: 0000007f7f9ee6f0 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000007f7f9ee6f2 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000001 R14: 0000007f7f9ee6f0 R15: 0000000000000000
Call Trace:
712132d8:  [<60017c13>] panic_exit+0x2f/0x49
712132f8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
71213328:  [<6003d356>] atomic_notifier_call_chain+0x9/0xb
71213338:  [<60030924>] panic+0xe4/0x173
71213398:  [<6028462b>] __up_read+0x7f/0x84
712133b8:  [<60045e11>] up_read+0x9/0xb
712133c8:  [<6001727f>] handle_page_fault+0x1d3/0x225
71213428:  [<60017470>] segv+0x133/0x251
712134e8:  [<600172d1>] segv_handler+0x0/0x6c
71213508:  [<60017337>] segv_handler+0x66/0x6c
71213548:  [<600284f1>] sig_handler_common_skas+0xe5/0xff
71213588:  [<60024fba>] sig_handler+0x46/0x55
712135b8:  [<600270e1>] hard_handler+0x15/0x18
712135c8:  [<60394c40>] __restore_rt+0x0/0x10
71213678:  [<600652bf>] transfer_objects+0x3b/0x4d
71213708:  [<600271b6>] run_syscall_stub+0xd2/0xde
712139a8:  [<60066959>] do_tune_cpucache+0xca/0xd7
71213a08:  [<60025350>] set_signals+0x1f/0x35
71213a18:  [<6006619d>] cache_alloc_refill+0x78/0x1a9
71213a68:  [<6006649f>] kmem_cache_alloc+0x45/0x5c
71213a98:  [<6031907e>] fn_hash_insert+0x217/0x38f
71213af8:  [<6031748e>] fib_magic+0xb3/0xca
71213b98:  [<60317517>] fib_add_ifaddr+0x72/0x132
71213bd8:  [<603178d9>] fib_inetaddr_event+0x1f/0x51
71213bf8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
71213c28:  [<6003d42d>] blocking_notifier_call_chain+0x32/0x49
71213c58:  [<603102d9>] __inet_insert_ifa+0x117/0x122
71213c88:  [<603102f1>] inet_insert_ifa+0xd/0xf
71213c98:  [<603110f9>] inetdev_event+0x124/0x1b4
71213cc8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
71213cf8:  [<6003d463>] raw_notifier_call_chain+0x9/0xb
71213d08:  [<602c9623>] dev_open+0x72/0x7a
71213d28:  [<602caada>] dev_change_flags+0x60/0x133
71213d58:  [<60310979>] devinet_ioctl+0x250/0x536
71213e08:  [<6031269f>] inet_ioctl+0x71/0x8f
71213e18:  [<602c08a6>] sock_ioctl+0x216/0x242
71213e28:  [<600173e5>] segv+0xa8/0x251
71213e58:  [<60073597>] do_ioctl+0x1b/0x50
71213e68:  [<600739d9>] vfs_ioctl+0x231/0x24e
71213ea8:  [<60073a38>] sys_ioctl+0x42/0x66
71213ef8:  [<600184dd>] handle_syscall+0x65/0x80
71213f08:  [<60017337>] segv_handler+0x66/0x6c
71213f28:  [<600279cd>] handle_trap+0xd0/0xdb
71213f68:  [<60027e48>] userspace+0x139/0x181
71213fc8:  [<6001820c>] fork_handler+0x73/0x7a



 	The problem seems to be in bringing up the loopback interface:

+ '[' -z 255.0.0.0 ']'
+ '[' -z '' ']'
++ /bin/ipcalc --prefix 127.0.0.1 255.0.0.0
+ eval PREFIX=8
++ PREFIX=8
+ '[' -z 127.255.255.255 ']'
+ '[' -z 127.0.0.0 ']'
+ '[' -n '' ']'
+ ip link set dev lo up
Kernel panic - not syncing: Kernel mode fault at addr 0x401647d10, ip 
0x404f6147

Pid: 2243, comm: ip Not tainted 2.6.20-rc5-git3
RIP: 0033:[<00000000404f6147>]
RSP: 0000007f7f8b6578  EFLAGS: 00000246
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: ffffffffffffffff
RDX: 0000007f7f8b65b0 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000007f7f8b65b2 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000001 R14: 0000007f7f8b65b0 R15: 0000000000000000
Call Trace:
711db2d8:  [<60017c13>] panic_exit+0x2f/0x49
711db2f8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
711db328:  [<6003d356>] atomic_notifier_call_chain+0x9/0xb
711db338:  [<60030924>] panic+0xe4/0x173
711db398:  [<6028462b>] __up_read+0x7f/0x84
711db3b8:  [<60045e11>] up_read+0x9/0xb
711db3c8:  [<6001727f>] handle_page_fault+0x1d3/0x225
711db428:  [<60017470>] segv+0x133/0x251
711db4e8:  [<600172d1>] segv_handler+0x0/0x6c
711db508:  [<60017337>] segv_handler+0x66/0x6c
711db548:  [<600284f1>] sig_handler_common_skas+0xe5/0xff
711db588:  [<60024fba>] sig_handler+0x46/0x55
711db5b8:  [<600270e1>] hard_handler+0x15/0x18
711db5c8:  [<60394c40>] __restore_rt+0x0/0x10
711db678:  [<600652bf>] transfer_objects+0x3b/0x4d
711db708:  [<60025350>] set_signals+0x1f/0x35
711db728:  [<6006669c>] kmem_cache_free+0x8f/0x98
711db788:  [<60039a37>] update_wall_time+0xca/0xf4
711db9a8:  [<60066959>] do_tune_cpucache+0xca/0xd7
711dba08:  [<60025350>] set_signals+0x1f/0x35
711dba18:  [<6006619d>] cache_alloc_refill+0x78/0x1a9
711dba68:  [<6006649f>] kmem_cache_alloc+0x45/0x5c
711dba98:  [<6031907e>] fn_hash_insert+0x217/0x38f
711dbaf8:  [<6031748e>] fib_magic+0xb3/0xca
711dbb98:  [<60317517>] fib_add_ifaddr+0x72/0x132
711dbbd8:  [<603178d9>] fib_inetaddr_event+0x1f/0x51
711dbbf8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
711dbc28:  [<6003d42d>] blocking_notifier_call_chain+0x32/0x49
711dbc58:  [<603102d9>] __inet_insert_ifa+0x117/0x122
711dbc88:  [<603102f1>] inet_insert_ifa+0xd/0xf
711dbc98:  [<603110f9>] inetdev_event+0x124/0x1b4
711dbcc8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
711dbcf8:  [<6003d463>] raw_notifier_call_chain+0x9/0xb
711dbd08:  [<602c9623>] dev_open+0x72/0x7a
711dbd28:  [<602caada>] dev_change_flags+0x60/0x133
711dbd58:  [<60310979>] devinet_ioctl+0x250/0x536
711dbe08:  [<6031269f>] inet_ioctl+0x71/0x8f
711dbe18:  [<602c08a6>] sock_ioctl+0x216/0x242
711dbe28:  [<600173e5>] segv+0xa8/0x251
711dbe58:  [<60073597>] do_ioctl+0x1b/0x50
711dbe68:  [<600739d9>] vfs_ioctl+0x231/0x24e
711dbea8:  [<60073a38>] sys_ioctl+0x42/0x66
711dbef8:  [<600184dd>] handle_syscall+0x65/0x80
711dbf08:  [<60017337>] segv_handler+0x66/0x6c
711dbf28:  [<600279cd>] handle_trap+0xd0/0xdb
711dbf68:  [<60027e48>] userspace+0x139/0x181
711dbfc8:  [<6001820c>] fork_handler+0x73/0x7a


 	And now look at the specific "ip" invocation:


-bash-3.1# strace ip link set dev lo up
execve("/sbin/ip", ["ip", "link", "set", "dev", "lo", "up"], [/* 17 vars 
*/]) = 0
brk(0)                                  = 0x62b000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x4001a000
uname({sys="Linux", node="placeholder.stearns.org", ...}) = 0
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=19724, ...}) = 0
mmap(NULL, 19724, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001b000
close(3)                                = 0
open("/lib64/libresolv.so.2", O_RDONLY) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\3603\0\0"..., 832) 
= 832
fstat(3, {st_mode=S_IFREG|0755, st_size=89792, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x40020000
mmap(NULL, 2181864, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) 
= 0x4021b000
mprotect(0x4022c000, 2097152, PROT_NONE) = 0
mmap(0x4042c000, 8192, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0x4042c000
mmap(0x4042e000, 6888, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4042e000
close(3)                                = 0
open("/lib64/libc.so.6", O_RDONLY)      = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@\333\1\0"..., 832) 
= 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1672928, ...}) = 0
mmap(NULL, 3461304, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) 
= 0x40430000
mprotect(0x40574000, 2097152, PROT_NONE) = 0
mmap(0x40774000, 20480, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x144000) = 0x40774000
mmap(0x40779000, 16568, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40779000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x40021000
arch_prctl(ARCH_SET_FS, 0x400217f0)     = 0
mprotect(0x40774000, 16384, PROT_READ)  = 0
mprotect(0x4042c000, 4096, PROT_READ)   = 0
mprotect(0x40219000, 4096, PROT_READ)   = 0
munmap(0x4001b000, 19724)               = 0
socket(PF_NETLINK, SOCK_RAW, 0)         = 3
setsockopt(3, SOL_SOCKET, SO_SNDBUF, [32768], 4) = 0
setsockopt(3, SOL_SOCKET, SO_RCVBUF, [32768], 4) = 0
bind(3, {sa_family=AF_NETLINK, pid=0, groups=00000000}, 12) = 0
getsockname(3, {sa_family=AF_NETLINK, pid=2211, groups=00000000}, 
[4621145941594865676]) = 0
time(NULL)                              = 1169794801
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
ioctl(4, SIOCGIFFLAGS, {ifr_name="lo", ifr_flags=IFF_LOOPBACK}) = 0
ioctl(4, SIOCSIFFLAGSKernel panic - not syncing: Kernel mode fault at addr 
0x408ecf5d0, ip 0x404f6147

Pid: 2211, comm: ip Not tainted 2.6.20-rc5-git3
RIP: 0033:[<00000000404f6147>]
RSP: 0000007f7fe72b08  EFLAGS: 00000246
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: ffffffffffffffff
RDX: 0000007f7fe72b40 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000007f7fe72b42 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000001 R14: 0000007f7fe72b40 R15: 0000000000000000
Call Trace:
717672d8:  [<60017c13>] panic_exit+0x2f/0x49
717672f8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
71767328:  [<6003d356>] atomic_notifier_call_chain+0x9/0xb
71767338:  [<60030924>] panic+0xe4/0x173
71767398:  [<6028462b>] __up_read+0x7f/0x84
717673b8:  [<60045e11>] up_read+0x9/0xb
717673c8:  [<6001727f>] handle_page_fault+0x1d3/0x225
71767428:  [<60017470>] segv+0x133/0x251
717674e8:  [<600172d1>] segv_handler+0x0/0x6c
71767508:  [<60017337>] segv_handler+0x66/0x6c
71767548:  [<600284f1>] sig_handler_common_skas+0xe5/0xff
71767588:  [<60024fba>] sig_handler+0x46/0x55
717675b8:  [<600270e1>] hard_handler+0x15/0x18
717675c8:  [<60394c40>] __restore_rt+0x0/0x10
71767678:  [<600652bf>] transfer_objects+0x3b/0x4d
717676b8:  [<60013eab>] reactivate_fd+0x57/0x62
717676c8:  [<602793c6>] end_request+0x3c/0x41
71767718:  [<60025275>] change_sig+0x58/0x70
71767758:  [<60013eab>] reactivate_fd+0x57/0x62
71767788:  [<6001f38f>] ubd_intr+0x9/0x10
717679a8:  [<60066959>] do_tune_cpucache+0xca/0xd7
71767a08:  [<60025350>] set_signals+0x1f/0x35
71767a18:  [<6006619d>] cache_alloc_refill+0x78/0x1a9
71767a68:  [<6006649f>] kmem_cache_alloc+0x45/0x5c
71767a98:  [<6031907e>] fn_hash_insert+0x217/0x38f
71767af8:  [<6031748e>] fib_magic+0xb3/0xca
71767b98:  [<60317517>] fib_add_ifaddr+0x72/0x132
71767bd8:  [<603178d9>] fib_inetaddr_event+0x1f/0x51
71767bf8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
71767c28:  [<6003d42d>] blocking_notifier_call_chain+0x32/0x49
71767c58:  [<603102d9>] __inet_insert_ifa+0x117/0x122
71767c88:  [<603102f1>] inet_insert_ifa+0xd/0xf
71767c98:  [<603110f9>] inetdev_event+0x124/0x1b4
71767cc8:  [<6003d2b4>] notifier_call_chain+0x26/0x3b
71767cf8:  [<6003d463>] raw_notifier_call_chain+0x9/0xb
71767d08:  [<602c9623>] dev_open+0x72/0x7a
71767d28:  [<602caada>] dev_change_flags+0x60/0x133
71767d58:  [<60310979>] devinet_ioctl+0x250/0x536
71767db8:  [<6003a40e>] recalc_sigpending+0x1c/0x1e
71767e08:  [<6031269f>] inet_ioctl+0x71/0x8f
71767e18:  [<602c08a6>] sock_ioctl+0x216/0x242
71767e58:  [<60073597>] do_ioctl+0x1b/0x50
71767e68:  [<600739d9>] vfs_ioctl+0x231/0x24e
71767ea8:  [<60073a38>] sys_ioctl+0x42/0x66
71767ef8:  [<600184dd>] handle_syscall+0x65/0x80
71767f28:  [<600279cd>] handle_trap+0xd0/0xdb
71767f68:  [<60027e48>] userspace+0x139/0x181
71767fc8:  [<6001820c>] fork_handler+0x73/0x7a




 	Cheers,
 	- Bill

---------------------------------------------------------------------------
 	"Love is a snowmobile racing across the tundra and then suddenly it
flips over, pinning you underneath.  At night, the ice weasels come."
 	-- Matt Groening
(Courtesy of Steve Dodd <dirk@loth.demon.co.uk>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
