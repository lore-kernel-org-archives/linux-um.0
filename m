Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeFU7-0000Xw-Hd for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 10:34:15 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GeFU4-0003lA-LO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 10:34:15 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 29 Oct 2006 19:34:05 +0100
Message-Id: <20061029183405.31657.44335.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 1/2] Fix "Remove the use of _syscallX macros in
	UML"
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix commit 5f4c6bc1f369f20807a8e753c2308d1629478c61: it spits out warnings about
missing syscall prototype (it is in <unistd.h>) and it does not recognize that
two uses of _syscallX are to be resolved against kernel headers in the source
tree, not against _syscallX; they in fact do not compile and would not work
anyway.

If _syscallX macros will be removed from the kernel tree altogether, the only
reasonable solution for that piece of code is switching to open-coded inline
assembly (it's remapping the whole executable from memory, except the page
containing this code).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/sys-i386/tls.c |    3 +++
 arch/um/os-Linux/tls.c          |    1 +
 arch/um/sys-i386/unmap.c        |   11 +++++++----
 arch/um/sys-x86_64/unmap.c      |   11 +++++++----
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/um/os-Linux/sys-i386/tls.c b/arch/um/os-Linux/sys-i386/tls.c
index 6e945ab..2565320 100644
--- a/arch/um/os-Linux/sys-i386/tls.c
+++ b/arch/um/os-Linux/sys-i386/tls.c
@@ -1,6 +1,9 @@
 #include <errno.h>
 #include <linux/unistd.h>
+
 #include <sys/syscall.h>
+#include <unistd.h>
+
 #include "sysdep/tls.h"
 #include "user_util.h"
 
diff --git a/arch/um/os-Linux/tls.c b/arch/um/os-Linux/tls.c
index a2de258..9f7999f 100644
--- a/arch/um/os-Linux/tls.c
+++ b/arch/um/os-Linux/tls.c
@@ -1,6 +1,7 @@
 #include <errno.h>
 #include <sys/ptrace.h>
 #include <sys/syscall.h>
+#include <unistd.h>
 #include <asm/ldt.h>
 #include "sysdep/tls.h"
 #include "uml-config.h"
diff --git a/arch/um/sys-i386/unmap.c b/arch/um/sys-i386/unmap.c
index 8e55cd5..1b0ad0e 100644
--- a/arch/um/sys-i386/unmap.c
+++ b/arch/um/sys-i386/unmap.c
@@ -5,17 +5,20 @@
 
 #include <linux/mman.h>
 #include <asm/unistd.h>
-#include <sys/syscall.h>
 
+static int errno;
+
+static inline _syscall2(int,munmap,void *,start,size_t,len)
+static inline _syscall6(void *,mmap2,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
 int switcheroo(int fd, int prot, void *from, void *to, int size)
 {
-	if (syscall(__NR_munmap, to, size) < 0){
+	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if (syscall(__NR_mmap2, to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
+	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
 		return(-1);
 	}
-	if (syscall(__NR_munmap, from, size) < 0){
+	if(munmap(from, size) < 0){
 		return(-1);
 	}
 	return(0);
diff --git a/arch/um/sys-x86_64/unmap.c b/arch/um/sys-x86_64/unmap.c
index 57c9286..f4a4bff 100644
--- a/arch/um/sys-x86_64/unmap.c
+++ b/arch/um/sys-x86_64/unmap.c
@@ -5,17 +5,20 @@
 
 #include <linux/mman.h>
 #include <asm/unistd.h>
-#include <sys/syscall.h>
 
+static int errno;
+
+static inline _syscall2(int,munmap,void *,start,size_t,len)
+static inline _syscall6(void *,mmap,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
 int switcheroo(int fd, int prot, void *from, void *to, int size)
 {
-	if (syscall(__NR_munmap, to, size) < 0){
+	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if (syscall(__NR_mmap, to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
+	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
 		return(-1);
 	}
-	if (syscall(__NR_munmap, from, size) < 0){
+	if(munmap(from, size) < 0){
 		return(-1);
 	}
 	return(0);
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
