Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H66nK-0008Ag-Q1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Jan 2007 06:57:14 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H66nJ-0008Cs-DB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Jan 2007 06:57:14 -0800
Date: Sun, 14 Jan 2007 15:57:11 +0100
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20070114145711.GZ7469@stusta.de>
References: <20070105235251.GW20714@stusta.de>
	<200701100043.18831.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200701100043.18831.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [FYI: 2.6.16 patch] fix the UML compilation
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 10, 2007 at 12:43:18AM +0100, Blaisorblade wrote:
> On Saturday 06 January 2007 00:52, Adrian Bunk wrote:
> > FYI:
> > I've applied the patch below to the 2.6.16 tree to fix the UML
> > compilation on systems with recent kernel headers.
> >
> > Please complain if anything is wrong with it.
> >
> > cu
> > Adrian
> >
> >
> > commit cc0e04780f51553c88a2eb1a33f709346f6d0281
> > Author: Adrian Bunk <bunk@stusta.de>
> > Date:   Fri Jan 5 03:17:11 2007 +0100
> >
> >     fix the UML compilation
> >
> >     Based on patches from Linus' tree.
> >
> >     Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> I reverted the below two hunks when they were applied on git tree, they're 
> wrong (even because this code is compiled using our headers, not using host 
> ones). In fact both in git HEAD and in 2.6.19 there is the correct code 
> version.
>...

Thanks, I missed this because in 2.6.16 it only affects the MODE_TT 
compilation (the tls.c's aren't in 2.6.16).

I've now additionally committed the patch below.

cu
Adrian


commit 12f5aa0834c6f2d55382daed856af509cd54b9f6
Author: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Date:   Sun Jan 14 15:42:49 2007 +0100

    UML: fix the MODE_TT compilation
    
    Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
    Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
