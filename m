Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J1mvi-0007GN-D8 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Dec 2007 10:00:34 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J1mvh-0006Uj-Ic
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Dec 2007 10:00:34 -0800
Date: Mon, 10 Dec 2007 13:00:08 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071210180008.GA9343@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/5] UML - Eliminate setjmp_wrapper
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

setjmp_wrapper existed to provide setjmp to kernel code when UML used
libc's setjmp and longjmp.  Now that UML has its own implementation,
this isn't needed and kernel code can invoke setjmp directly.

do_buffer_op is massively cleaned up since it is no longer a callback
from setjmp_wrapper and given a va_list from which it must extract its
arguments.

The actual setjmp is moved from buffer_op to do_op_one_page because
the copy operation is inside an atomic section (kmap_atomic to
kunmap_atomic) and it shouldn't be longjmp-ed out of.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/os.h          |    1 
 arch/um/kernel/skas/uaccess.c |   73 +++++++++++++++---------------------------
 arch/um/os-Linux/util.c       |   15 --------
 3 files changed, 27 insertions(+), 62 deletions(-)

Index: linux-2.6-git/arch/um/include/os.h
===================================================================
--- linux-2.6-git.orig/arch/um/include/os.h	2007-12-10 12:37:04.000000000 -0500
+++ linux-2.6-git/arch/um/include/os.h	2007-12-10 12:37:59.000000000 -0500
@@ -237,7 +237,6 @@ extern void stack_protections(unsigned l
 extern int raw(int fd);
 extern void setup_machinename(char *machine_out);
 extern void setup_hostinfo(char *buf, int len);
-extern int setjmp_wrapper(void (*proc)(void *, void *), ...);
 extern void os_dump_core(void);
 
 /* time.c */
Index: linux-2.6-git/arch/um/kernel/skas/uaccess.c
===================================================================
--- linux-2.6-git.orig/arch/um/kernel/skas/uaccess.c	2007-12-10 12:36:31.000000000 -0500
+++ linux-2.6-git/arch/um/kernel/skas/uaccess.c	2007-12-10 12:37:59.000000000 -0500
@@ -58,9 +58,10 @@ static pte_t *maybe_map(unsigned long vi
 static int do_op_one_page(unsigned long addr, int len, int is_write,
 		 int (*op)(unsigned long addr, int len, void *arg), void *arg)
 {
+	jmp_buf buf;
 	struct page *page;
 	pte_t *pte;
-	int n;
+	int n, faulted;
 
 	pte = maybe_map(addr, is_write);
 	if (pte == NULL)
@@ -70,82 +71,62 @@ static int do_op_one_page(unsigned long 
 	addr = (unsigned long) kmap_atomic(page, KM_UML_USERCOPY) +
 		(addr & ~PAGE_MASK);
 
-	n = (*op)(addr, len, arg);
+	current->thread.fault_catcher = &buf;
+
+	faulted = UML_SETJMP(&buf);
+	if (faulted == 0)
+		n = (*op)(addr, len, arg);
+	else
+		n = -1;
+
+	current->thread.fault_catcher = NULL;
 
 	kunmap_atomic(page, KM_UML_USERCOPY);
 
 	return n;
 }
 
-static void do_buffer_op(void *jmpbuf, void *arg_ptr)
+static int buffer_op(unsigned long addr, int len, int is_write,
+		     int (*op)(unsigned long, int, void *), void *arg)
 {
-	va_list args;
-	unsigned long addr;
-	int len, is_write, size, remain, n;
-	int (*op)(unsigned long, int, void *);
-	void *arg;
-	int *res;
-
-	va_copy(args, *(va_list *)arg_ptr);
-	addr = va_arg(args, unsigned long);
-	len = va_arg(args, int);
-	is_write = va_arg(args, int);
-	op = va_arg(args, void *);
-	arg = va_arg(args, void *);
-	res = va_arg(args, int *);
-	va_end(args);
+	int size, remain, n;
+
 	size = min(PAGE_ALIGN(addr) - addr, (unsigned long) len);
 	remain = len;
 
-	current->thread.fault_catcher = jmpbuf;
 	n = do_op_one_page(addr, size, is_write, op, arg);
 	if (n != 0) {
-		*res = (n < 0 ? remain : 0);
+		remain = (n < 0 ? remain : 0);
 		goto out;
 	}
 
 	addr += size;
 	remain -= size;
-	if (remain == 0) {
-		*res = 0;
+	if (remain == 0)
 		goto out;
-	}
 
-	while(addr < ((addr + remain) & PAGE_MASK)) {
+	while (addr < ((addr + remain) & PAGE_MASK)) {
 		n = do_op_one_page(addr, PAGE_SIZE, is_write, op, arg);
 		if (n != 0) {
-			*res = (n < 0 ? remain : 0);
+			remain = (n < 0 ? remain : 0);
 			goto out;
 		}
 
 		addr += PAGE_SIZE;
 		remain -= PAGE_SIZE;
 	}
-	if (remain == 0) {
-		*res = 0;
+	if (remain == 0)
 		goto out;
-	}
 
 	n = do_op_one_page(addr, remain, is_write, op, arg);
-	if (n != 0)
-		*res = (n < 0 ? remain : 0);
-	else *res = 0;
- out:
-	current->thread.fault_catcher = NULL;
-}
-
-static int buffer_op(unsigned long addr, int len, int is_write,
-		     int (*op)(unsigned long addr, int len, void *arg),
-		     void *arg)
-{
-	int faulted, res;
-
-	faulted = setjmp_wrapper(do_buffer_op, addr, len, is_write, op, arg,
-				 &res);
-	if (!faulted)
-		return res;
+	if (n != 0) {
+		remain = (n < 0 ? remain : 0);
+		goto out;
+	}
 
-	return addr + len - (unsigned long) current->thread.fault_addr;
+	return 0;
+ out:
+	return remain;
 }
 
 static int copy_chunk_from_user(unsigned long from, int len, void *arg)
Index: linux-2.6-git/arch/um/os-Linux/util.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/util.c	2007-12-10 12:36:31.000000000 -0500
+++ linux-2.6-git/arch/um/os-Linux/util.c	2007-12-10 12:37:59.000000000 -0500
@@ -88,21 +88,6 @@ void setup_hostinfo(char *buf, int len)
 		 host.release, host.version, host.machine);
 }
 
-int setjmp_wrapper(void (*proc)(void *, void *), ...)
-{
-	va_list args;
-	jmp_buf buf;
-	int n;
-
-	n = UML_SETJMP(&buf);
-	if(n == 0){
-		va_start(args, proc);
-		(*proc)(&buf, &args);
-	}
-	va_end(args);
-	return n;
-}
-
 void os_dump_core(void)
 {
 	int pid;

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
