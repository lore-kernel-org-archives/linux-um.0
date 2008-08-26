Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KY2yK-0004v4-0j for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 11:08:52 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KY2yI-0007yT-Oj for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 11:08:51 -0700
Message-ID: <48B44658.8010403@meduna.org>
Date: Tue, 26 Aug 2008 20:07:20 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <4898AC10.3010602@meduna.org>
	<7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>
	<48995D1A.6030203@meduna.org> <489AC525.3060305@meduna.org>
	<489AE6DD.2000200@meduna.org> <489C3D9B.7070605@meduna.org>
	<20080825215124.GB12626@c2.user-mode-linux.org>
	<48B3AED8.5040904@meduna.org>
	<20080826174600.GA24342@c2.user-mode-linux.org>
In-Reply-To: <20080826174600.GA24342@c2.user-mode-linux.org>
Subject: Re: [uml-devel] FP registers corruption
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:

> It's not.  Any 2.6 UML should run on a any 2.6 host.  If you are
> having problems that look like version skew problems, say what they
> are.

My host is current Ubuntu and I was unable to test 2.6.25.x
there due to
   Locating the top of the address space ... Address 0x0 no good?
which AFAIK was a known problem caused by some ubuntu-specific
patch.

2.6.26 crashes here with

Locating the bottom of the address space ... 0x10000
Locating the top of the address space ... Checking that ptrace can change system call 
numbers...0xc0000000
Core dump limits :
         soft - 0
         hard - NONE
OK
Checking syscall emulation patch for ptrace...0xc0000000
Core dump limits :
         soft - 0
         hard - NONE
OK
Checking advanced syscall emulation patch for ptrace...0xc0000000
Core dump limits :
         soft - 0
         hard - NONE
OK
0xc0000000
Core dump limits :
         soft - 0
         hard - NONE
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
   - /proc/mm...not found: No such file or directory
   - PTRACE_FAULTINFO...not found
OK
   - PTRACE_LDT...not found
OK
OK
UML running in SKAS0 mode
Linux version 2.6.26 (stano@maroon) (gcc version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #2 Mon Aug 
11 23:50:44 CEST 2008
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 6096
Kernel command line: root=/dev/ubda ubd0=/home/stano/uml/test.rootfs mem=24M con=pty 
con0=fd:0,fd:1 con1=xterm eth0=daemon,,unix,/var/run/uml-utilities/uml_switch.ctl
PID hash table entries: 128 (order: 7, 512 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 21684k available
SLUB: Genslabs=12, HWalign=128, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking that host ptys support output SIGIO...Yes
net_namespace: 624 bytes
NET: Registered protocol family 16
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
NET: Registered protocol family 1
mconsole (version 2) initialized on /home/stano/.uml/umltest/mconsole
Checking host MADV_REMOVE support...OK
ubd: Synchronous mode
UML Watchdog Timer
Host TLS support detected
Detected host type: i386 (GDT indexes 6 to 9)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 42
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
brd: module loaded
loop: module loaded
SoftDog: cannot register miscdev on minor=130 (err=-16)
Mirror/redirect action on
TCP cubic registered
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
console [tty0] enabled
Initializing software serial port version 1
Choosing a random ethernet address for device eth0
Netdevice 0 (9a:fd:f3:b2:aa:10) : daemon backend (uml_switch version 3) - 
unix:/var/run/uml-utilities/uml_switch.ctl
console [mc-1] enabled
  ubda: unknown partition table
VFS: Mounted root (ext2 filesystem) readonly.
Stub registers -
         0 - 0
         1 - 0
         2 - 0
         3 - 0
         4 - 0
         5 - 0
         6 - 0
         7 - 0
         8 - 0
         9 - 0
         10 - 0
         11 - ffffffff
         12 - 0
         13 - 73
         14 - 10202
         15 - 0
         16 - 7b
wait_stub_done : failed to wait for SIGTRAP, pid = 24625, n = 24625, errno = 25, status = 
0xb7f
Kernel panic - not syncing: Attempted to kill init!

EIP: 0073:[<08189151>] CPU: 0 Not tainted ESP: 007b:bfb22dc0 EFLAGS: 00000246
     Not tainted
EAX: 00000000 EBX: 0000602c ECX: 00000013 EDX: 0000602c
ESI: 00006028 EDI: 0828e818 EBP: bfb2379a DS: 007b ES: 007b
09463bd8:  [<0808322b>] notifier_call_chain+0x25/0x48
09463bfc:  [<08083283>] atomic_notifier_call_chain+0x15/0x19
09463c14:  [<0807011b>] panic+0x52/0xce
09463c30:  [<08072ec0>] do_exit+0x5c/0x5bf
09463c4c:  [<08078767>] recalc_sigpending+0x16/0x25
09463c64:  [<0807349c>] do_group_exit+0x79/0xa5
09463c7c:  [<0807af6d>] get_signal_to_deliver+0x286/0x29b
09463ca0:  [<08058dc6>] do_signal+0x230/0x2e7
09463d00:  [<0807961e>] send_signal+0x197/0x1ae
09463d1c:  [<08065a5a>] set_signals+0x18/0x28
09463d24:  [<080799f7>] force_sig_info+0x9f/0xa9
09463d44:  [<08079a10>] force_sig+0xf/0x13
09463d68:  [<0805a26d>] fatal_sigsegv+0x1b/0x20
09463d78:  [<08067df1>] wait_stub_done+0xa1/0xa7
09463da4:  [<08067681>] do_syscall_stub+0x9c/0x16b
09463dc4:  [<08068d6d>] write_ldt_entry+0xef/0x14f
09463e0c:  [<08069482>] init_new_ldt+0x193/0x2d5
09463e2c:  [<080935b5>] __alloc_pages_internal+0x7d/0x341
09463e88:  [<0805a6e3>] init_new_context+0xc7/0x108
09463ea4:  [<080ade0f>] bprm_mm_init+0x41/0x169
09463ed0:  [<080aea02>] do_execve+0x6b/0x19a
09463ed8:  [<080a9114>] do_sys_open+0x96/0xba
09463eec:  [<0805738d>] execve1+0x21/0x39
09463f0c:  [<080573f5>] um_execve+0x14/0x33
09463f14:  [<0805907a>] kernel_execve+0x2b/0x34
09463f30:  [<080570d5>] run_init_process+0x15/0x19
09463f40:  [<0805717e>] init_post+0xa5/0xcf
09463f48:  [<080485ab>] kernel_init+0x1e5/0x1ef
09463f58:  [<080553b6>] tcp_congestion_default+0x0/0xc
09463fbc:  [<08064cd4>] run_kernel_thread+0x38/0x3f
09463fd8:  [<08064cb7>] run_kernel_thread+0x1b/0x3f
09463fe4:  [<0805838e>] new_thread_handler+0x53/0x79
09463fe8:  [<080483c6>] kernel_init+0x0/0x1ef


2.6.26.2 has no problems.

> In an earlier email, you provide a nice test case.  However, I'm
> running that here, and getting page after page of successful key
> generation.

Same here with 2.6.26.2 :(

> Is there anything else that might be relevant to reproducing this?

Well - the difference to my test environment is that
- the host machine is a SMP one (I am running the host inside
   vmware)
- there are quite a few UML guests running (AFAIK 5 to 8 -
   no space for testing this here yet)

Config should be the same, I used /proc/config.gz from
the failing machine.

dirk:~# uname -a
Linux dirk 2.6.26 #1 Wed Jul 30 10:56:10 CEST 2008 i686 GNU/Linux
dirk:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : User Mode Linux
model name      : UML
mode            : skas
host            : Linux seldon-base 2.6.23.17 #2 SMP Sat Jun 21 15:04:22 CEST 2008 i686
bogomips        : 4771.02

-- 
                                         Stano

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
