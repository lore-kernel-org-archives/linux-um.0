Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e3g-0004fA-5a	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:08 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e3f-0000ju-CU
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:08 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182123.C896324E7DD@zion.home.lan>
Subject: [uml-devel] [patch 11/39] remap_file_pages protection support: add
	MAP_NOINHERIT flag
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
Date: Fri, 12 Aug 2005 20:21:23 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add the MAP_NOINHERIT flag to arch headers, for use with remap-file-pages.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-i386/mman.h   |    1 +
 linux-2.6.git-paolo/include/asm-ia64/mman.h   |    1 +
 linux-2.6.git-paolo/include/asm-ppc/mman.h    |    1 +
 linux-2.6.git-paolo/include/asm-ppc64/mman.h  |    1 +
 linux-2.6.git-paolo/include/asm-s390/mman.h   |    1 +
 linux-2.6.git-paolo/include/asm-x86_64/mman.h |    1 +
 6 files changed, 6 insertions(+)

diff -puN include/asm-i386/mman.h~rfp-map-noinherit include/asm-i386/mman.h
--- linux-2.6.git/include/asm-i386/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-i386/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -22,6 +22,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-ia64/mman.h~rfp-map-noinherit include/asm-ia64/mman.h
--- linux-2.6.git/include/asm-ia64/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ia64/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -30,6 +30,7 @@
 #define MAP_NORESERVE	0x04000		/* don't check for reservations */
 #define MAP_POPULATE	0x08000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-ppc64/mman.h~rfp-map-noinherit include/asm-ppc64/mman.h
--- linux-2.6.git/include/asm-ppc64/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ppc64/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -38,6 +38,7 @@
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MADV_NORMAL	0x0		/* default page-in behavior */
 #define MADV_RANDOM	0x1		/* page-in minimum required */
diff -puN include/asm-ppc/mman.h~rfp-map-noinherit include/asm-ppc/mman.h
--- linux-2.6.git/include/asm-ppc/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ppc/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -23,6 +23,7 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-s390/mman.h~rfp-map-noinherit include/asm-s390/mman.h
--- linux-2.6.git/include/asm-s390/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-s390/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -30,6 +30,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-x86_64/mman.h~rfp-map-noinherit include/asm-x86_64/mman.h
--- linux-2.6.git/include/asm-x86_64/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-x86_64/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -23,6 +23,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
