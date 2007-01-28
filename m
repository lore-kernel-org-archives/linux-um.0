Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBGOP-0003YP-Fs for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Jan 2007 12:12:49 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBGOD-0004oS-Am
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Jan 2007 12:12:39 -0800
Date: Sun, 28 Jan 2007 15:10:38 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.64.0701281447490.3498@sparrow>
MIME-Version: 1.0
Subject: [uml-devel] Thread (NPTL?) support, 2.6.20-rc5-git3, x86_64,
	reproducible segmentation fault and possible culprit
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
Cc: Vince Berk <vberk@ists.dartmouth.edu>, William Stearns <wstearns@pobox.com>

Good day, all,
 	Vince Berk pointed out what appears to be a thread issue with uml. 
The "host" command, part of the bind-utils package, uses threads and 
crashes when asked to do anything more complex than show its help screen:

-bash-3.1# rpm -q bind-libs bind-utils
bind-libs-9.3.3-0.1.rc3.fc6
bind-utils-9.3.3-0.1.rc3.fc6
-bash-3.1# host www.google.com.
Segmentation fault

 	(strace below)

 	I rebuilt the "bind" rpm (which creates bind-utils and bind-libs) 
with a one-line change to the spec file, specifically to the configure 
command:

[wstearns@spamgate SPECS]$ diff -bud bind.spec.orig bind.spec
--- bind.spec.orig      2006-12-06 09:55:51.000000000 -0500
+++ bind.spec   2007-01-28 13:13:54.000000000 -0500
@@ -320,7 +320,7 @@
  %configure \
         --with-libtool \
         --localstatedir=/var \
-       --enable-threads \
+       --disable-threads \
         --enable-ipv6 \
         --with-pic \
         --with-openssl=/usr \

 	The new packages work just fine inside uml:

-bash-3.1# rpm -e bind-libs bind-utils
-bash-3.1# rpm -Uvh /home/wstearns/rpm/RPMS/x86_64/bind-libs-9.3.3-0.1.rc3.x86_64.rpm /home/wstearns/rpm/RPMS/x86_64/bind-utils-9.3.3-0.1.rc3.x86_64.rpm
Preparing...                ###########################################
    1:bind-libs              ########################################### [
    2:bind-utils             ########################################### 
-bash-3.1# host www.google.com.
www.google.com is an alias for www.l.google.com.
www.l.google.com has address 64.233.161.99
www.l.google.com has address 64.233.161.104
www.l.google.com has address 64.233.161.147

 	The problem is completely reproducible; the root filesystem and 
kernel at http://ford.stearns.org/uml/ give a crash every time you 
actually try to look something up with "host".
 	Should I be talking to the glibc folks about this?

 	Vince, the non-thread packages under /shared/spamgate/ in your vm.
 	Cheers,
 	- Bill


 	Here are the last lines from "strace -f host www.google.com" 
using the stock (thread-enabled) "host" (no idea if this will help):


mmap(NULL, 8392704, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40, 
-1, 0) = 0x41e86000
mprotect(0x41e86000, 4096, PROT_NONE)   = 0
clone(Process 27121 attached
child_stack=0x42686240, 
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, 
parent_tidptr=0x426869d0, tls=0x42686940, child_tidptr=0x426869d0) = 27121
[pid 27120] mmap(NULL, 8392704, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_ANONYMOUS|0x40, -1, 0) = 0x42687000
[pid 27120] mprotect(0x42687000, 4096, PROT_NONE) = 0
[pid 27120] clone(Process 27122 attached
child_stack=0x42e87240, 
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, 
parent_tidptr=0x42e879d0, tls=0x42e87940, child_tidptr=0x42e879d0) = 27122
[pid 27120] pipe([3, 4])                = 0
[pid 27120] fcntl(3, F_GETFL)           = 0 (flags O_RDONLY)
[pid 27120] fcntl(3, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
[pid 27120] mmap(NULL, 8392704, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_ANONYMOUS|0x40, -1, 0) = 0x42e88000
[pid 27120] mprotect(0x42e88000, 4096, PROT_NONE) = 0
[pid 27120] clone(Process 27123 attached
child_stack=0x43688240, 
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, 
parent_tidptr=0x436889d0, tls=0x43688940, child_tidptr=0x436889d0) = 27123
[pid 27120] open("/usr/share/locale/C/libdst.cat", O_RDONLY) = -1 ENOENT 
(No such file or directory)
[pid 27120] open("/usr/share/locale/C/LC_MESSAGES/libdst.cat", O_RDONLY) = 
-1 ENOENT (No such file or directory)
[pid 27120] open("/usr/share/locale/C/libdst.cat", O_RDONLY) = -1 ENOENT 
(No such file or directory)
[pid 27120] open("/usr/share/locale/C/LC_MESSAGES/libdst.cat", O_RDONLY) = 
-1 ENOENT (No such file or directory)
[pid 27120] futex(0x40741ee0, FUTEX_WAKE, 2147483647) = 0
[pid 27120] open("/usr/share/locale/C/libisc.cat", O_RDONLY) = -1 ENOENT 
(No such file or directory)
[pid 27120] open("/usr/share/locale/C/LC_MESSAGES/libisc.cat", O_RDONLY 
<unfinished ...>
[pid 27121] set_robust_list(0x426869e0, 0x18 <unfinished ...>
[pid 27122] set_robust_list(0x42e879e0, 0x18 <unfinished ...>
[pid 27123] set_robust_list(0x436889e0, 0x18 <unfinished ...>
[pid 27120] <... open resumed> )        = -1 ENOENT (No such file or 
directory)
[pid 27121] <... set_robust_list resumed> ) = 0
[pid 27122] <... set_robust_list resumed> ) = 0
[pid 27123] <... set_robust_list resumed> ) = 0
[pid 27120] open("/usr/share/locale/C/libisc.cat", O_RDONLY <unfinished 
...>
[pid 27121] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
Process 27121 detached
[pid 27122] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
Process 27122 detached
[pid 27123] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
Process 27123 detached
<... open resumed> )                    = -1 ENOENT (No such file or 
directory)
+++ killed by SIGSEGV +++
Process 27120 detached
-bash-3.1#


---------------------------------------------------------------------------
         "While it may be true that a watched pot never boils, the one
you don't keep an eye on can make an awful mess of your stove."
         -- Edward Stevenson
(Courtesy of Slashdot)
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
