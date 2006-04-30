Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FaCkJ-0001cr-Du for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:17:59 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FaCkJ-0001yZ-6u for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:17:59 -0700
Received: from host199-105.pool8255.interbusiness.it ([82.55.105.199]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FaCkI-0005YH-6M for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:17:59 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060430141614.9060.3376.stgit@zion.home.lan>
In-Reply-To: <20060430141512.9060.39338.stgit@zion.home.lan>
References: <20060430141512.9060.39338.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 3/7] uml: make copy_*_user atomic
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
Date: Sun, 30 Apr 2006 16:16:14 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Make __copy_*_user_inatomic really atomic to avoid "Sleeping function called in
atomic context" warnings, especially from futex code.

This is made by adding another kmap_atomic slot and making copy_*_user_skas use
kmap_atomic; also copy_*_user() becomes atomic, but that's true and is not a
problem for i386 (and we can always add might_sleep there as done elsewhere).
For TT mode kmap is not used, so there's no need for this.

I've had to use another slot since both KM_USER0 and KM_USER1 are used elsewhere
and could cause conflicts. Till now we reused the kmap_atomic slot list from the
subarch, but that's not needed as that list must contain the common ones (used
by generic code) + the ones used in architecture specific code (and Uml till now
used none); so I've taken the i386 one after comparing it with ones from other
archs, and added KM_UML_USERCOPY.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/skas/uaccess.c |   15 +++++++++------
 include/asm-um/kmap_types.h   |   20 +++++++++++++++++++-
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 5992c32..8912cec 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -8,6 +8,7 @@
 #include "linux/kernel.h"
 #include "linux/string.h"
 #include "linux/fs.h"
+#include "linux/hardirq.h"
 #include "linux/highmem.h"
 #include "asm/page.h"
 #include "asm/pgtable.h"
@@ -38,7 +39,7 @@ static unsigned long maybe_map(unsigned 
 	return((unsigned long) phys);
 }
 
-static int do_op(unsigned long addr, int len, int is_write,
+static int do_op_one_page(unsigned long addr, int len, int is_write,
 		 int (*op)(unsigned long addr, int len, void *arg), void *arg)
 {
 	struct page *page;
@@ -49,9 +50,11 @@ static int do_op(unsigned long addr, int
 		return(-1);
 
 	page = phys_to_page(addr);
-	addr = (unsigned long) kmap(page) + (addr & ~PAGE_MASK);
+	addr = (unsigned long) kmap_atomic(page, KM_UML_USERCOPY) + (addr & ~PAGE_MASK);
+
 	n = (*op)(addr, len, arg);
-	kunmap(page);
+
+	kunmap_atomic(page, KM_UML_USERCOPY);
 
 	return(n);
 }
@@ -77,7 +80,7 @@ static void do_buffer_op(void *jmpbuf, v
 	remain = len;
 
 	current->thread.fault_catcher = jmpbuf;
-	n = do_op(addr, size, is_write, op, arg);
+	n = do_op_one_page(addr, size, is_write, op, arg);
 	if(n != 0){
 		*res = (n < 0 ? remain : 0);
 		goto out;
@@ -91,7 +94,7 @@ static void do_buffer_op(void *jmpbuf, v
 	}
 
 	while(addr < ((addr + remain) & PAGE_MASK)){
-		n = do_op(addr, PAGE_SIZE, is_write, op, arg);
+		n = do_op_one_page(addr, PAGE_SIZE, is_write, op, arg);
 		if(n != 0){
 			*res = (n < 0 ? remain : 0);
 			goto out;
@@ -105,7 +108,7 @@ static void do_buffer_op(void *jmpbuf, v
 		goto out;
 	}
 
-	n = do_op(addr, remain, is_write, op, arg);
+	n = do_op_one_page(addr, remain, is_write, op, arg);
 	if(n != 0)
 		*res = (n < 0 ? remain : 0);
 	else *res = 0;
diff --git a/include/asm-um/kmap_types.h b/include/asm-um/kmap_types.h
index 0b22ad7..6c03acd 100644
--- a/include/asm-um/kmap_types.h
+++ b/include/asm-um/kmap_types.h
@@ -6,6 +6,24 @@
 #ifndef __UM_KMAP_TYPES_H
 #define __UM_KMAP_TYPES_H
 
-#include "asm/arch/kmap_types.h"
+/* No more #include "asm/arch/kmap_types.h" ! */
+
+enum km_type {
+	KM_BOUNCE_READ,
+	KM_SKB_SUNRPC_DATA,
+	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
+	KM_UML_USERCOPY,	/* UML specific, for copy_*_user - used in do_op_one_page */
+	KM_BIO_SRC_IRQ,
+	KM_BIO_DST_IRQ,
+	KM_PTE0,
+	KM_PTE1,
+	KM_IRQ0,
+	KM_IRQ1,
+	KM_SOFTIRQ0,
+	KM_SOFTIRQ1,
+	KM_TYPE_NR
+};
 
 #endif


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
