Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2ysb-0006KH-Ud for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 15:53:49 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H2ysa-0004E4-Tk
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 15:53:45 -0800
Date: Sat, 6 Jan 2007 00:52:52 +0100
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20070105235251.GW20714@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [FYI: 2.6.16 patch] fix the UML compilation
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
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net

FYI:
I've applied the patch below to the 2.6.16 tree to fix the UML 
compilation on systems with recent kernel headers.

Please complain if anything is wrong with it.

cu
Adrian


commit cc0e04780f51553c88a2eb1a33f709346f6d0281
Author: Adrian Bunk <bunk@stusta.de>
Date:   Fri Jan 5 03:17:11 2007 +0100

    fix the UML compilation
    
    Based on patches from Linus' tree.
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>

diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index d261888..a0afd10 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -11,6 +11,7 @@
 #include <linux/unistd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <sys/syscall.h>
 #include "ptrace_user.h"
 #include "os.h"
 #include "user.h"
@@ -139,11 +140,9 @@ void os_usr1_process(int pid)
  * syscalls, and also breaks with clone(), which does not unshare the TLS.
  */
 
-inline _syscall0(pid_t, getpid)
-
 int os_getpid(void)
 {
-	return(getpid());
+	return(syscall(__NR_getpid));
 }
 
 int os_getpgrp(void)
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index bbf34cb..215ef68 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -17,6 +17,7 @@
 #include <sys/time.h>
 #include <asm/unistd.h>
 #include <asm/types.h>
+#include <asm/page.h>
 #include "user.h"
 #include "sysdep/ptrace.h"
 #include "user_util.h"
diff --git a/arch/um/sys-i386/unmap.c b/arch/um/sys-i386/unmap.c
index 1b0ad0e..8e55cd5 100644
--- a/arch/um/sys-i386/unmap.c
+++ b/arch/um/sys-i386/unmap.c
@@ -5,20 +5,17 @@
 
 #include <linux/mman.h>
 #include <asm/unistd.h>
+#include <sys/syscall.h>
 
-static int errno;
-
-static inline _syscall2(int,munmap,void *,start,size_t,len)
-static inline _syscall6(void *,mmap2,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
 int switcheroo(int fd, int prot, void *from, void *to, int size)
 {
-	if(munmap(to, size) < 0){
+	if (syscall(__NR_munmap, to, size) < 0){
 		return(-1);
 	}
-	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
+	if (syscall(__NR_mmap2, to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
 		return(-1);
 	}
-	if(munmap(from, size) < 0){
+	if (syscall(__NR_munmap, from, size) < 0){
 		return(-1);
 	}
 	return(0);
diff --git a/arch/um/sys-x86_64/unmap.c b/arch/um/sys-x86_64/unmap.c
index f4a4bff..57c9286 100644
--- a/arch/um/sys-x86_64/unmap.c
+++ b/arch/um/sys-x86_64/unmap.c
@@ -5,20 +5,17 @@
 
 #include <linux/mman.h>
 #include <asm/unistd.h>
+#include <sys/syscall.h>
 
-static int errno;
-
-static inline _syscall2(int,munmap,void *,start,size_t,len)
-static inline _syscall6(void *,mmap,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
 int switcheroo(int fd, int prot, void *from, void *to, int size)
 {
-	if(munmap(to, size) < 0){
+	if (syscall(__NR_munmap, to, size) < 0){
 		return(-1);
 	}
-	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
+	if (syscall(__NR_mmap, to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
 		return(-1);
 	}
-	if(munmap(from, size) < 0){
+	if (syscall(__NR_munmap, from, size) < 0){
 		return(-1);
 	}
 	return(0);


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
