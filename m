Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEEgd-0003eK-T9 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Apr 2004 14:46:19 -0700
Received: from linuxhacker.ru
	([217.76.32.60] helo=shrek.linuxhacker.ru ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BEEgc-0007tQ-Vv
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Apr 2004 14:46:19 -0700
From: Oleg Drokin <green@linuxhacker.ru>
Message-ID: <20040415214629.GB207748@linuxhacker.ru>
References: <20040415210318.GA205486@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20040415210318.GA205486@linuxhacker.ru>
Subject: [uml-devel] Re: [PATCH] Fix for annoying problem with hostfs readdir
	problems.
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
Date: Fri, 16 Apr 2004 00:46:29 +0300
To: jdike@karaya.com, umka@namesys.com, user-mode-linux-devel@lists.sourceforge.net, sikkh@wp.pl



--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On Fri, Apr 16, 2004 at 12:03:18AM +0300, Oleg Drokin wrote:
>    So the annoying problem with readdir not working on hostfs (on 2.6 host
>    kernel only for me) was finally hunted to memory allocation
>    problem during opendir.
> 
>    The patch below is a working and tested attempt at fixing it.
>    It is againt 2.4.20-something, but is pretty straightforward and
>    probably should apply everywhere else.

This is corrected version that sets errno on malloc failure and as a bonus -
um_vmalloc is now also declared in header file and therefore no edtra warning in
main.c ;)

Bye,
    Oleg

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="malloc_fix.diff"

--- uml-2.4/arch/um/kernel/process_kern.c.orig	2004-04-15 23:26:49.000000000 +0300
+++ uml-2.4/arch/um/kernel/process_kern.c	2004-04-15 23:49:38.312250576 +0300
@@ -16,6 +16,7 @@
 #include "linux/module.h"
 #include "linux/init.h"
 #include "linux/capability.h"
+#include "linux/vmalloc.h"
 #include "asm/unistd.h"
 #include "asm/mman.h"
 #include "asm/segment.h"
@@ -279,6 +280,11 @@ void *um_kmalloc(int size)
 	return(kmalloc(size, GFP_KERNEL));
 }
 
+void *um_vmalloc(int size)
+{
+	return(vmalloc(size));
+}
+
 void *um_kmalloc_atomic(int size)
 {
 	return(kmalloc(size, GFP_ATOMIC));
--- uml-2.4/arch/um/main.c.orig	2004-04-15 23:58:28.786606216 +0300
+++ uml-2.4/arch/um/main.c	2004-04-16 00:35:35.074159064 +0300
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <signal.h>
+#include <errno.h>
 #include <sys/resource.h>
 #include <sys/mman.h>
 #include <sys/user.h>
@@ -160,10 +161,16 @@ extern void *__real_malloc(int);
 
 void *__wrap_malloc(int size)
 {
-	if(CAN_KMALLOC())
-		return(um_kmalloc(size));
-	else
+	if(CAN_KMALLOC()) {
+		/* glibc people insist that if malloc fails, errno should be
+		   set by malloc as well. So we do. */
+		void *ret = um_vmalloc(size);
+		if (!ret)
+			errno = ENOMEM;
+		return(ret);
+	} else {
 		return(__real_malloc(size));
+	}
 }
 
 void *__wrap_calloc(int n, int size)
@@ -179,7 +186,7 @@ extern void __real_free(void *);
 
 void __wrap_free(void *ptr)
 {
-	if(CAN_KMALLOC()) kfree(ptr);
+	if(CAN_KMALLOC()) vfree(ptr);
 	else __real_free(ptr);
 }
 
--- uml-2.4/arch/um/include/user.h.orig	2004-04-15 23:41:57.000000000 +0300
+++ uml-2.4/arch/um/include/user.h	2004-04-16 00:36:24.806598584 +0300
@@ -10,8 +10,10 @@ extern void panic(const char *fmt, ...);
 extern int printk(const char *fmt, ...);
 extern void schedule(void);
 extern void *um_kmalloc(int size);
+extern void *um_vmalloc(int size);
 extern void *um_kmalloc_atomic(int size);
 extern void kfree(void *ptr);
+extern void vfree(void *ptr);
 extern int in_aton(char *str);
 extern int open_gdb_chan(void);
 

--ADZbWkCsHQ7r3kzd--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
