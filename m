Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9NWR-0001vl-Jl for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 08:57:35 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I9NWO-0007Ap-95
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 08:57:35 -0700
Date: Fri, 13 Jul 2007 11:57:23 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070713155723.GA7468@c2.user-mode-linux.org>
References: <46975CD0.5020709@nagafix.co.uk> <46976A09.9070906@nagafix.co.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46976A09.9070906@nagafix.co.uk>
Subject: Re: [uml-devel] ARCH=um SUBARCH=i386 breakage?
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
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jul 13, 2007 at 01:03:21PM +0100, Antoine Martin wrote:
> I had updated the kernel headers and these include files have been removed.
> Until UML uses some other trick, this works for me for the 64-bit build:
> 
> cp /usr/src/linux-2.6.22.1/include/asm/user.h /usr/include/asm/user.h
> cp /usr/src/linux-2.6.22.1/include/asm/page.h /usr/include/asm/page.h
> cp /usr/src/linux-2.6.22.1/include/linux/const.h /usr/include/linux/const.h

asm/user,h looks like a problem.  The only other way I see to get the
size of the FP registers is elf_fpregset_t and elf_fpxregset_t in
asm/elf.h, which is exported.  However, those are defined in terms of
user_i387_struct and user_fxsr_struct in user.h, and it gets them with

	#include <asm/user.h>

So, we seem to have a situation where an exported header includes a
non-exported one, or the include is filtered out and we have a type
with an unknown size.

Could you check this there by seeing if something like this builds
(with user.h removed):

#include <asm/elf.h>

int main(void){
	printf("%d %d\n", sizeof(elf_fpregset_t), sizeof(elf_fpxregset_t));
}

> cp /usr/src/linux-2.6.22.1/include/asm/page.h /usr/include/asm/page.h

This one is easily fixed.

> cp /usr/src/linux-2.6.22.1/include/linux/const.h /usr/include/linux/const.h

What's with this?  I don't include that anywhere in UML.

Can you get rid of page.h and const.h (you'll have to leave user.h
unfortunately) again and try the patch below?  It builds for me on
both i386 and x86_64.

				Jeff

Index: linux-2.6.21-mm/arch/um/include/sysdep-i386/stub.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/sysdep-i386/stub.h	2007-02-04 13:44:54.000000000 -0500
+++ linux-2.6.21-mm/arch/um/include/sysdep-i386/stub.h	2007-07-13 11:42:00.000000000 -0400
@@ -9,7 +9,6 @@
 #include <sys/mman.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
-#include <asm/page.h>
 #include "stub-data.h"
 #include "kern_constants.h"
 #include "uml-config.h"
@@ -19,7 +18,7 @@ extern void stub_clone_handler(void);
 
 #define STUB_SYSCALL_RET EAX
 #define STUB_MMAP_NR __NR_mmap2
-#define MMAP_OFFSET(o) ((o) >> PAGE_SHIFT)
+#define MMAP_OFFSET(o) ((o) >> UM_KERN_PAGE_SHIFT)
 
 static inline long stub_syscall0(long syscall)
 {
Index: linux-2.6.21-mm/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/main.c	2007-07-06 13:03:34.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/main.c	2007-07-13 11:07:07.000000000 -0400
@@ -12,7 +12,6 @@
 #include <sys/resource.h>
 #include <sys/mman.h>
 #include <sys/user.h>
-#include <asm/page.h>
 #include "kern_util.h"
 #include "as-layout.h"
 #include "mem_user.h"
Index: linux-2.6.21-mm/arch/um/os-Linux/skas/mem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/mem.c	2007-07-02 21:29:06.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/mem.c	2007-07-13 11:07:20.000000000 -0400
@@ -9,7 +9,6 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
-#include <asm/page.h>
 #include <asm/unistd.h>
 #include "mem_user.h"
 #include "mem.h"
Index: linux-2.6.21-mm/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/start_up.c	2007-07-13 10:18:42.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/start_up.c	2007-07-13 11:07:29.000000000 -0400
@@ -19,7 +19,6 @@
 #include <sys/mman.h>
 #include <sys/resource.h>
 #include <asm/unistd.h>
-#include <asm/page.h>
 #include <sys/types.h>
 #include "kern_util.h"
 #include "user.h"
Index: linux-2.6.21-mm/arch/um/os-Linux/tt.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/tt.c	2007-06-28 11:39:48.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/tt.c	2007-07-13 11:07:44.000000000 -0400
@@ -17,7 +17,6 @@
 #include <sys/mman.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
-#include <asm/page.h>
 #include "kern_util.h"
 #include "user.h"
 #include "signal_kern.h"
Index: linux-2.6.21-mm/arch/um/sys-i386/ptrace_user.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-i386/ptrace_user.c	2007-07-06 13:03:34.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-i386/ptrace_user.c	2007-07-13 11:00:07.000000000 -0400
@@ -8,8 +8,6 @@
 #include <errno.h>
 #include <unistd.h>
 #include "ptrace_user.h"
-/* Grr, asm/user.h includes asm/ptrace.h, so has to follow ptrace_user.h */
-#include <asm/user.h>
 #include "kern_util.h"
 #include "sysdep/thread.h"
 #include "user.h"
Index: linux-2.6.21-mm/arch/um/include/common-offsets.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/common-offsets.h	2007-06-28 16:11:24.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/common-offsets.h	2007-07-13 11:41:51.000000000 -0400
@@ -10,6 +10,7 @@ OFFSET(HOST_TASK_PID, task_struct, pid);
 
 DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
 DEFINE(UM_KERN_PAGE_MASK, PAGE_MASK);
+DEFINE(UM_KERN_PAGE_SHIFT, PAGE_SHIFT);
 DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 
 DEFINE_STR(UM_KERN_EMERG, KERN_EMERG);

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
