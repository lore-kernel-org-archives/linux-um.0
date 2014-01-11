Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1W1w5v-00058y-IQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Jan 2014 10:47:11 +0000
Received: from mout.gmx.net ([212.227.17.22])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1W1w5u-0006xg-0p
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Jan 2014 10:47:11 +0000
Received: from [192.168.178.21] ([78.54.173.153]) by mail.gmx.com (mrgmx001)
	with ESMTPSA (Nemesis) id 0M1Fe4-1VDYSt1ARU-00tDdp for
	<user-mode-linux-devel@lists.sourceforge.net>; Sat, 11 Jan 2014 11:47:03
	+0100
Message-ID: <52D12125.9060001@gmx.de>
Date: Sat, 11 Jan 2014 11:47:01 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060309090600000502040604"
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] negative pid -516 possible ?
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060309090600000502040604
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I do fuzz testing with trinity (latest git version) a stable 32 bit Gentoo Linux user mode linux image.
The host is a stable 32 bit vanilla 3.12.7 kernel, the guest runs latest git tree + 2 patches (attached).

The trinity call in the UML guest is :
$> trinity -q -l off -N 10000 -C 2 -x move_pages -x mremap -v /mnt/ramdisk

After a while there's no progress on the command line seen at the host system - the trinity process seems to just hangs/idling. When this does occur I cannot longer ssh into the system. The system however runs furthermore. In another terminal I still see the output of this command:

$> ssh root@trinity "tail -f /var/log/messages"

That's why I do know that the system does not hang completely. The output of top at the host system gives me the pid of the linux exe. A gdb call gives for that pid :

$ date; sudo gdb /home/tfoerste/devel/linux/linux 25224 -n -batch -ex 'bt full'
Sat Jan 11 11:36:47 CET 2014

warning: Could not load shared library symbols for linux-gate.so.1.
Do you need "set solib-search-path" or "set sysroot"?
0xb7800424 in __kernel_vsyscall ()
#0  0xb7800424 in __kernel_vsyscall ()
No symbol table info available.
#1  0x083d63ff in __nanosleep_nocancel ()
No symbol table info available.
#2  0x0807266c in idle_sleep (nsecs=602496380195307520) at arch/um/os-Linux/time.c:183
        ts = {tv_sec = 0, tv_nsec = 8436602}
#3  0x0805fc0f in arch_cpu_idle () at arch/um/kernel/process.c:208
No locals.
#4  0x080a8971 in cpu_idle_loop () at kernel/cpu/idle.c:98
No locals.
#5  cpu_startup_entry (state=CPUHP_ONLINE) at kernel/cpu/idle.c:140
No locals.
#6  0x084215e9 in rest_init () at init/main.c:402
        pid = -516
        __func__ = "rest_init"
#7  0x080487e1 in start_kernel () at init/main.c:656
        command_line = 0x85b8400 <command_line> "earlyprintk ubda=/home/tfoerste/virtual/uml/trinity ubdb=/mnt/ramdisk/trinity_swap eth0=tuntap,tap0,72:ef:3d:9f:c3:5a mem=1025M con0=fd:0,fd:1 con=pts rootfstype=ext4  root=98:0"
#8  0x08049e42 in start_kernel_proc (unused=0x0) at arch/um/kernel/skas/process.c:48
        pid = -516
        __func__ = "start_kernel_proc"
#9  0x0805f7cb in new_thread_handler () at arch/um/kernel/process.c:129
        fn = 0x0
#10 0x00000000 in ?? ()
No symbol table info available.



Please note that BUG_ON was not triggered. For completeness here are the gdb traces from all linux processes currently running at the host:


$ pgrep linux | xargs -n1 -I {} sudo gdb /home/tfoerste/devel/linux/linux {} -n -batch -ex 'bt'          
warning: process 1613 is already traced by process 25224                                                                                               
ptrace: Operation not permitted.                                                                                                                       
/home/tfoerste/1613: No such file or directory.                                                                                                        
No stack.                                                                                                                                              
warning: process 21849 is already traced by process 25224
ptrace: Operation not permitted.
/home/tfoerste/21849: No such file or directory.
No stack.

warning: Could not load shared library symbols for linux-gate.so.1.
Do you need "set solib-search-path" or "set sysroot"?
0xb7800424 in __kernel_vsyscall ()
#0  0xb7800424 in __kernel_vsyscall ()
#1  0x083d63ff in __nanosleep_nocancel ()
#2  0x0807266c in idle_sleep (nsecs=602496380205307520) at arch/um/os-Linux/time.c:183
#3  0x0805fc0f in arch_cpu_idle () at arch/um/kernel/process.c:208
#4  0x080a8971 in cpu_idle_loop () at kernel/cpu/idle.c:98
#5  cpu_startup_entry (state=CPUHP_ONLINE) at kernel/cpu/idle.c:140
#6  0x084215e9 in rest_init () at init/main.c:402
#7  0x080487e1 in start_kernel () at init/main.c:656
#8  0x08049e42 in start_kernel_proc (unused=0x0) at arch/um/kernel/skas/process.c:48
#9  0x0805f7cb in new_thread_handler () at arch/um/kernel/process.c:129
#10 0x00000000 in ?? ()

warning: process 25231 is a cloned process

warning: Could not load shared library symbols for linux-gate.so.1.
Do you need "set solib-search-path" or "set sysroot"?
0xb7800424 in __kernel_vsyscall ()
#0  0xb7800424 in __kernel_vsyscall ()
#1  0x083da446 in syscall ()
#2  0x0806e861 in io_getevents (events=<optimized out>, ctx_id=<optimized out>, min_nr=<optimized out>, nr=<optimized out>, timeout=<optimized out>) at arch/um/os-Linux/aio.c:49
#3  aio_thread (arg=0x0) at arch/um/os-Linux/aio.c:109
#4  0x083db56e in clone ()

warning: process 25232 is a cloned process

warning: Could not load shared library symbols for linux-gate.so.1.
Do you need "set solib-search-path" or "set sysroot"?
0xb7800424 in __kernel_vsyscall ()
#0  0xb7800424 in __kernel_vsyscall ()
#1  0x083d82c2 in __read_nocancel ()
#2  0x0806f3ff in read (__nbytes=<optimized out>, __buf=<optimized out>, __fd=<optimized out>) at /usr/include/bits/unistd.h:44
#3  os_read_file (fd=-512, buf=0xfffffe00, len=-512) at arch/um/os-Linux/file.c:253
#4  0x0806bafc in io_thread (arg=0x0) at arch/um/drivers/ubd_kern.c:1482
#5  0x083db56e in clone ()

warning: process 25233 is a cloned process

warning: Could not load shared library symbols for linux-gate.so.1.
Do you need "set solib-search-path" or "set sysroot"?
0xb7800424 in __kernel_vsyscall ()
#0  0xb7800424 in __kernel_vsyscall ()
#1  0x083d9132 in __poll_nocancel ()
#2  0x08071114 in poll (__timeout=<optimized out>, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/bits/poll2.h:46
#3  write_sigio_thread (unused=0x0) at arch/um/os-Linux/sigio.c:61
#4  0x083db56e in clone ()
warning: process 25234 is a zombie - the process has already terminated
ptrace: Operation not permitted.
/home/tfoerste/25234: No such file or directory.
No stack.
...


Please Cc: me I'm not subscribed.



- -- 
MfG/Sincerely
Toralf Förster
pgp finger print:1A37 6F99 4A9D 026F 13E2 4DCF C4EA CDDE 0076 E94E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLRISQACgkQxOrN3gB26U54pwD9Eq49Oog5KpSC4+e19t4HG6LA
5d3Oz4/qq98wCb+rF9UA/0j+fT4xjdHbYmLtc8Z0wctVO3DjdQG49/+n81s/gLx3
=eP08
-----END PGP SIGNATURE-----

--------------060309090600000502040604
Content-Type: text/x-patch;
 name="uml_filemap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="uml_filemap.patch"

diff --git a/mm/filemap.c b/mm/filemap.c
index b7749a92021c..622d49ac2a24 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1108,18 +1108,25 @@ static void do_generic_file_read(struct file *filp, loff_t *ppos,
 	pgoff_t prev_index;
 	unsigned long offset;      /* offset into pagecache page */
 	unsigned int prev_offset;
+	loff_t isize;
 	int error;
 
+	/* we need to trim desc->count to avoid expose stale data to user */
+	isize = i_size_read(inode);
+	if (*ppos + desc->count >= isize)
+		desc->count = isize - *ppos;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	prev_index = ra->prev_pos >> PAGE_CACHE_SHIFT;
 	prev_offset = ra->prev_pos & (PAGE_CACHE_SIZE-1);
 	last_index = (*ppos + desc->count + PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
+	if (desc->count == 0)
+		goto out;
+
 	for (;;) {
 		struct page *page;
 		pgoff_t end_index;
-		loff_t isize;
 		unsigned long nr, ret;
 
 		cond_resched();


--------------060309090600000502040604
Content-Type: text/x-patch;
 name="pid516.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pid516.patch"

diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 4da11b3..71a5828 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -38,6 +38,8 @@ static int __init start_kernel_proc(void *unused)
 	block_signals();
 	pid = os_getpid();
 
+	BUG_ON(pid == -516);
+
 	cpu_tasks[0].pid = pid;
 	cpu_tasks[0].task = current;
 #ifdef CONFIG_SMP
diff --git a/init/main.c b/init/main.c
index febc511..9ad68ab 100644
--- a/init/main.c
+++ b/init/main.c
@@ -386,6 +386,7 @@ static noinline void __init_refok rest_init(void)
 	kernel_thread(kernel_init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
 	pid = kernel_thread(kthreadd, NULL, CLONE_FS | CLONE_FILES);
+	BUG_ON(pid == -516);
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();


--------------060309090600000502040604
Content-Type: application/pgp-signature;
 name="uml_filemap.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="uml_filemap.patch.sig"

iF4EABEIAAYFAlLRISUACgkQxOrN3gB26U58/gD/XPYyvHaVVBs+nTjhcbFLEUhtgFlpzsbG
7uf0IbsovhsA/3vfvnqcB2VfTDrpRh5KyI7M4bJeIGCtamK9gvsDr09A
--------------060309090600000502040604
Content-Type: application/pgp-signature;
 name="pid516.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pid516.patch.sig"

iF4EABEIAAYFAlLRISUACgkQxOrN3gB26U7vNQD+OVOaF8hNcFqTNoQMOOUFKTUdYoQXn+qs
EwJJrEaVSIQBAIve9Ia8vTIA7iGjDFu8fO2Yp0MLjn5rQJloPP5Je1qF
--------------060309090600000502040604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
--------------060309090600000502040604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------060309090600000502040604--


