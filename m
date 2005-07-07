Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dqb3s-0002Ab-Vx	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jul 2005 11:25:24 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2-new.sourceforge.net with smtp (Exim 4.44)
	id 1Dqb3r-0005AI-Cj	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jul 2005 11:25:25 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PUXzCXpFk2o0nx7"
Message-Id: <200507072031.43862.blaisorblade@yahoo.it>
Subject: [uml-devel] Please test 2.6.13-rc2 in TT mode! Big problem with
	syscall parameters clobbering
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
Date: Thu, 7 Jul 2005 20:31:43 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-user@lists.sourceforge.net, Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>

--Boundary-00=_PUXzCXpFk2o0nx7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

For this kernel (and for -rc1), I've been getting almost no reports (except a 
problem with GCC 2.95 I now solved) in TT mode, so I'd like some more 
testing, especially for users which have the latest SKAS patch installed. At 
least positive / negative reports.

But, for me, it hasn't been working at all, and fails with:

./vmlinux mode=tt
Checking PROT_EXEC mmap in /tmp...OK
switcheroo failed

, unless I apply this apparently 
silly patch:

diff -u linux-2.6.git-paolo/arch/um/sys-i386/unmap.c 
clean-linux-2.6.11-paolo/arch/um/sys-i386/unmap.c
--- linux-2.6.git-paolo/arch/um/sys-i386/unmap.c	2005-06-07 19:10:51.000000000 
+0200
+++ clean-linux-2.6.11-paolo/arch/um/sys-i386/unmap.c	2005-06-08 
20:01:21.000000000 +0200
@@ -15,7 +15,8 @@
 	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+	/* if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){ */
+	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
 		return(-1);
 	}
 	if(munmap(from, size) < 0){
diff -u linux-2.6.git-paolo/arch/um/sys-x86_64/unmap.c 
clean-linux-2.6.11-paolo/arch/um/sys-x86_64/unmap.c
--- linux-2.6.git-paolo/arch/um/sys-x86_64/unmap.c	2005-06-07 
19:10:51.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/sys-x86_64/unmap.c	2005-06-08 
20:01:18.000000000 +0200
@@ -15,7 +15,8 @@
 	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+	/* if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){ */
+	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
 		return(-1);
 	}
 	if(munmap(from, size) < 0){

It is silly because from the mmap2() API, kernel source, and so on, it will 
return either "to" or -1, and from strace output it always returns "to".

mmap2(0xa024f000, 532480, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|
MAP_FIXED, 3, 0) = 0xa024f000
//as you can see the return value is the first parameter!
write(1, "switcheroo failed\n", 18switcheroo failed
)     = 18
//but it does fail!

But on my system the comparison fails, because the compiler keeps "to" inside 
EBX and after the syscall return the content of EBX is altered!

So, this seems a kernel bug, but it does not happen in the previous form of 
the code (which didn't use a direct syscall but rather the glibc version)!

And my system works pretty well, I think;

* I get only some crashes from some KDE components, but I consider them 
normal,
* and a lot of problems with GDB and debugging (still looking for the cause).

This is with 2.6.11 + gentoo patchset + skas-v9-pre4 (which is used by many 
people). I've been suspicious of Gentoo, libc, gdb, the kernel, now I'm going 
to look at everything until I find something.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_PUXzCXpFk2o0nx7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="uml-fix-link-tt-mode-against-nptl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-link-tt-mode-against-nptl.patch"

diff -u linux-2.6.git-paolo/arch/um/sys-i386/unmap.c clean-linux-2.6.11-paolo/arch/um/sys-i386/unmap.c
--- linux-2.6.git-paolo/arch/um/sys-i386/unmap.c	2005-06-07 19:10:51.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/sys-i386/unmap.c	2005-06-08 20:01:21.000000000 +0200
@@ -15,7 +15,8 @@
 	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+	/* if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){ */
+	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
 		return(-1);
 	}
 	if(munmap(from, size) < 0){
diff -u linux-2.6.git-paolo/arch/um/sys-x86_64/unmap.c clean-linux-2.6.11-paolo/arch/um/sys-x86_64/unmap.c
--- linux-2.6.git-paolo/arch/um/sys-x86_64/unmap.c	2005-06-07 19:10:51.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/sys-x86_64/unmap.c	2005-06-08 20:01:18.000000000 +0200
@@ -15,7 +15,8 @@
 	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+	/* if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){ */
+	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
 		return(-1);
 	}
 	if(munmap(from, size) < 0){

--Boundary-00=_PUXzCXpFk2o0nx7--

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
