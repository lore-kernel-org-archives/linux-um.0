Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GaDQs-00075L-OH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 08:34:14 -0700
Received: from rzcomm12.rz.tu-bs.de ([134.169.9.59])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GaDQo-0007H8-2A
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 08:34:14 -0700
Received: from [134.169.64.140] (imt12.imt.ing.tu-bs.de [134.169.64.140])
	by rzcomm12.rz.tu-bs.de (8.11.1/8.11.1) with ESMTP id k9IFXqS18031
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 Oct 2006 17:33:53 +0200 (METDST)
Message-ID: <4536495E.7010006@l4x.org>
Date: Wed, 18 Oct 2006 17:33:50 +0200
From: Jan Dittmer <jdi@l4x.org>
MIME-Version: 1.0
Subject: [uml-devel] Programs in guest segfault, amd64 host and guest
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
To: user-mode-linux-devel@lists.sourceforge.net

- Guest 2.6.19-rc1-git11
- Host Debian 2.6.18-1-amd64
- Debian etch for host and guest
- both using ext3
- command to start the guest
./linux-2.6.19-rc1-git11 ubd0=umlblob.cow,etch-amd64.img \
    eth0=daemon,10:00:00:00:00:02,unix,/var/run/uml-utilities/uml_switch.ctl \
         mem=128M \
         con=null umid=umlprey \
         >/dev/null 2>&1 &


$ strace btlaunchmany /tmp/
...
mmap(NULL, 8392704, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40, 
-1, 0) = 0x41c4e000
mprotect(0x41c4e000, 4096, PROT_NONE)   = 0
clone(Process 484 attached
child_stack=0x4244e280, 
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, 
parent_tidptr=0x4244e9f0, tls=0x4244e960, child_tidptr=0x4244e9f0) = 484
[pid   483] rt_sigprocmask(SIG_SETMASK, [],  <unfinished ...>
[pid   484] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
Process 484 detached
<... rt_sigprocmask resumed> NULL, 8)   = 0
+++ killed by SIGSEGV +++
Process 483 detached

$ strace mlnet -stdout
...
gettimeofday({1161185543, 817872}, NULL) = 0
mmap(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, 
MAP_PRIVATE|MAP_ANONYMOUS|0x40, -1, 0) = 0x41ccd000
mprotect(0x41ccd000, 4096, PROT_NONE)   = 0
clone(child_stack=0x424cd270, 
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, 
parent_tidptr=0x424cd9f0, tls=0x424cd960, child_tidptr=0x424cd9f0) = 502
gettimeofday({1161185543, 820912}, NULL) = 0
poll([{fd=7, events=POLLIN}, {fd=6, events=POLLIN}, {fd=5, events=POLLIN}, 
{fd=4, events=POLLIN}, {fd=3, events=POLLIN}], 5, 96) = -1 EINTR 
(Interrupted system call)
+++ killed by SIGSEGV +++
Process 501 detached

Additionally I'm having build failure compiling ARCH=um SUBARCH=i386.

Thanks for any pointers,

Jan


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
