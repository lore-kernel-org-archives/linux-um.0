Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtW2r-0004gW-5Y	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 12:40:25 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1DtW2q-0000us-Ad
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 12:40:25 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
References: <200507122346.40320.rob@landley.net>
	<200507141530.11249.rob@landley.net>
	<200507151810.39548.blaisorblade@yahoo.it>
In-Reply-To: <200507151810.39548.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZEB2ClTgupd6JoA"
Message-Id: <200507151440.09913.rob@landley.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 15 Jul 2005 14:40:09 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_ZEB2ClTgupd6JoA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 15 July 2005 11:10, Blaisorblade wrote:
> On Thursday 14 July 2005 22:30, Rob Landley wrote:
> > On Thursday 14 July 2005 13:16, Rob Landley wrote:
> > > Bodo's patch seems to have fixed the problem (albeit in a way that
> > > reveals ubuntu is using thread-local storage, so I can't use it
> > > anyway).
> >
> > Hang on a sec, if TLS is screwing up -skas0, then why does -tt mode work?
> >
> > Is this expected?
>
> Hmm, I've seen TLS falling back on modify_ldt() at times, and it's surely a
> bit bogus in current trees (although I have a partial fix for it, but not
> sure whether it will work). Do you think init=/usr/bin/strace /bin/ls would
> work? Uncomprehensible kernel params are passed to init, so it could.

Here's the output of that under both -tt mode and -skas0 mode.  Exact same 
command line both times, except for the name of the output file being 
redirected to.  Only .config change was switching from tt to skas mode.

Rob

--Boundary-00=_ZEB2ClTgupd6JoA
Content-Type: text/plain;
  charset="iso-8859-1";
  name="out-tt.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="out-tt.txt"

Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.12.2-bb2-skas0 (landley@driftwood) (gcc version 3.3.5 (Debian 1:3.3.5-8ubuntu2)) #6 Fri Jul 15 14:35:24 CDT 2005
Built 1 zonelists
Kernel command line: rootfstype=hostfs rw init=/usr/bin/strace /bin/ls root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 29952k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Linux NoNET1.0 for Linux 2.6
io scheduler noop registered
loop: loaded (max 8 devices)
Initialized stdio console driver
Console initialized on /dev/tty0
VFS: Mounted root (hostfs filesystem).
execve("/bin/ls", ["/bin/ls"], [/* 2 vars */]) = 0
uname({sys="Linux", node="(none)", ...}) = 0
brk(0)                                  = 0x805b000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
old_mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=48890, ...}) = 0
old_mmap(NULL, 48890, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/i686/cmov/librt.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\33\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=23676, ...}) = 0
old_mmap(NULL, 26444, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40024000
old_mmap(0x4002a000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x5000) = 0x4002a000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libacl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\24"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=22040, ...}) = 0
old_mmap(NULL, 20956, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4002b000
old_mmap(0x40030000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x5000) = 0x40030000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/i686/cmov/libc.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\215Y\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1222116, ...}) = 0
old_mmap(NULL, 1232428, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40031000
old_mmap(0x40153000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x121000) = 0x40153000
old_mmap(0x4015c000, 7724, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4015c000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/i686/cmov/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\224E\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=78598, ...}) = 0
old_mmap(NULL, 65028, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4015e000
old_mmap(0x4016b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xc000) = 0x4016b000
old_mmap(0x4016c000, 7684, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4016c000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libattr.so.1", O_RDONLY)     = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\r\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=10872, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4016e000
old_mmap(NULL, 13876, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4016f000
old_mmap(0x40172000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2000) = 0x40172000
close(3)                                = 0
set_thread_area({entry_number:-1 -> -1, base_addr:0x4016eb60, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = -1 ENOSYS (Function not implemented)
modify_ldt(1, {entry_number:0, base_addr:0x4016eb60, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, 16) = 0
munmap(0x40018000, 48890)               = 0
set_tid_address(0x4016eba8)             = 11
rt_sigaction(SIGRTMIN, {0x40162514, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
brk(0)                                  = 0x805b000
brk(0x807c000)                          = 0x807c000
brk(0)                                  = 0x807c000
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, TIOCGWINSZ, {ws_row=0, ws_col=0, ws_xpixel=0, ws_ypixel=0}) = 0
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(3, /* 28 entries */, 4096)   = 744
getdents64(3, /* 0 entries */, 4096)    = 0
close(3)                                = 0
open("/etc/mtab", O_RDONLY)             = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=267, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000
read(3, "/dev/hda5 / ext3 rw,errors=remou"..., 4096) = 267
close(3)                                = 0
munmap(0x40018000, 4096)                = 0
open("/proc/meminfo", O_RDONLY)         = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0x40018000, 4096)                = 0
fstat64(1, {st_mode=S_IFCHR|0660, st_rdev=makedev(5, 1), ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000
write(1, "bin    dev   home.bak\t lib\t     "..., 51bin    dev   home.bak	 lib	     mnt	proc  srv  usr
) = 51
write(1, "boot   etc   initrd\t lost+found "..., 58boot   etc   initrd	 lost+found  notes.txt	root  sys  var
) = 58
write(1, "cdrom  home  initrd.img  media\t "..., 59cdrom  home  initrd.img  media	     opt	sbin  tmp  vmlinuz
) = 59
munmap(0x40018000, 4096)                = 0
exit_group(0)                           = ?
Kernel panic - not syncing: Attempted to kill init!
 
EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP: 007b:9fca5aec EFLAGS: 00200246
    Not tainted
EAX: ffffffda EBX: 00000000 ECX: 401472c7 EDX: 40147280
ESI: 40148c14 EDI: 00000000 EBP: 9fca5b18 DS: 007b ES: 007b
a08afb50:  [<a0032bbd>] notifier_call_chain+0x2d/0x50
a08afb60:  [<a009a8b6>] bust_spinlocks+0x46/0x50
a08afb70:  [<a0022f11>] panic+0x71/0x120
a08afb90:  [<a0025c30>] do_exit+0x190/0x310
a08afbc0:  [<a00316d6>] sys_rt_sigprocmask+0x86/0x120
a08afbe0:  [<a0025e41>] do_group_exit+0x51/0x100
a08afbec:  [<a00b9d05>] sigemptyset+0x25/0x40
a08afc00:  [<a0011ef5>] change_signals+0x65/0x90
a08afc10:  [<a00167a3>] execute_syscall_tt+0xa3/0xb0
a08afc90:  [<a00167df>] syscall_handler_tt+0x2f/0x60
a08afca0:  [<a0011f4f>] unblock_signals+0xf/0x20
a08afcb0:  [<a001798b>] sig_handler_common_tt+0xbb/0x150
a08afd10:  [<a001c337>] sig_handler+0x17/0x20
a08afd20:  [<a00b9bd8>] __restore+0x0/0x8

 tracing thread pid = 8885


--Boundary-00=_ZEB2ClTgupd6JoA
Content-Type: text/plain;
  charset="iso-8859-1";
  name="out-skas.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="out-skas.txt"

Checking for /proc/mm...not found
Checking for the skas3 patch in the host...not found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.12.2-bb2-skas0 (landley@driftwood) (gcc version 3.3.5 (Debian 1:3.3.5-8ubuntu2)) #7 Fri Jul 15 14:38:06 CDT 2005
Built 1 zonelists
Kernel command line: rootfstype=hostfs rw init=/usr/bin/strace /bin/ls root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 30688k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Linux NoNET1.0 for Linux 2.6
io scheduler noop registered
loop: loaded (max 8 devices)
Initialized stdio console driver
Console initialized on /dev/tty0
VFS: Mounted root (hostfs filesystem).
cannot set up thread-local storage: cannot set up LDT for thread-local storage

Kernel panic - not syncing: Attempted to kill init!
 
EIP: 0073:[<40010cdf>] CPU: 0 Not tainted ESP: 007b:bf57a1a8 EFLAGS: 00200246
    Not tainted
EAX: ffffffda EBX: 0000007f ECX: bf579f30 EDX: 00000003
ESI: 40012f40 EDI: 40012f00 EBP: bf57a300 DS: 007b ES: 007b
08177ae0:  [<0807ad9d>] notifier_call_chain+0x2d/0x50
08177af0:  [<080e25e6>] bust_spinlocks+0x46/0x50
08177b00:  [<0806b911>] panic+0x71/0x120
08177b20:  [<0806e500>] do_exit+0x190/0x310
08177b40:  [<080a26a8>] vfs_writev+0x58/0x70
08177b70:  [<0806e711>] do_group_exit+0x51/0x100
08177ba0:  [<0805fea7>] execute_syscall_skas+0xd7/0xe0
08177bc0:  [<0805ab65>] change_signals+0x65/0x90
08177c30:  [<0805fed1>] handle_syscall+0x21/0x40
08177c40:  [<0805e958>] handle_trap+0x28/0x130
08177c70:  [<0805efa4>] userspace+0x1c4/0x220
08177cd4:  [<08054e90>] init+0x0/0x110
08177ce0:  [<0805f8f2>] new_thread_handler+0xf2/0x130

 

--Boundary-00=_ZEB2ClTgupd6JoA--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
