Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGhqj-0003bH-7A for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 14:04:49 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IGhqi-0000cK-7c
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 14:04:49 -0700
Date: Thu, 2 Aug 2007 17:04:36 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070802210436.GA11169@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/6] UML - Stop using libc asm/page.h
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

Remove includes of asm/page.h from libc code.  This header seems to be
disappearing, and UML doesn't make much use of it anyway.

The one use, PAGE_SHIFT in stub.h, is handled by copying the constant
from the kernel side of the house in common_offsets.h.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/common-offsets.h   |    1 +
 arch/um/include/sysdep-i386/stub.h |    3 +--
 arch/um/os-Linux/main.c            |    1 -
 arch/um/os-Linux/skas/mem.c        |    1 -
 arch/um/os-Linux/start_up.c        |    1 -
 arch/um/os-Linux/tt.c              |    1 -
 6 files changed, 2 insertions(+), 6 deletions(-)

Index: linux-2.6.21-mm/arch/um/include/sysdep-i386/stub.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/sysdep-i386/stub.h	2007-08-02 16:43:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/sysdep-i386/stub.h	2007-08-02 16:43:20.000000000 -0400
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
--- linux-2.6.21-mm.orig/arch/um/os-Linux/main.c	2007-08-02 16:43:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/main.c	2007-08-02 16:43:20.000000000 -0400
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
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/mem.c	2007-08-02 16:43:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/mem.c	2007-08-02 16:43:20.000000000 -0400
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
--- linux-2.6.21-mm.orig/arch/um/os-Linux/start_up.c	2007-08-02 16:43:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/start_up.c	2007-08-02 16:43:20.000000000 -0400
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
--- linux-2.6.21-mm.orig/arch/um/os-Linux/tt.c	2007-08-02 16:43:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/tt.c	2007-08-02 16:43:20.000000000 -0400
@@ -17,7 +17,6 @@
 #include <sys/mman.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
-#include <asm/page.h>
 #include "kern_util.h"
 #include "user.h"
 #include "signal_kern.h"
Index: linux-2.6.21-mm/arch/um/include/common-offsets.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/common-offsets.h	2007-08-02 16:43:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/common-offsets.h	2007-08-02 16:43:20.000000000 -0400
@@ -10,6 +10,7 @@ OFFSET(HOST_TASK_PID, task_struct, pid);
 
 DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
 DEFINE(UM_KERN_PAGE_MASK, PAGE_MASK);
+DEFINE(UM_KERN_PAGE_SHIFT, PAGE_SHIFT);
 DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 
 DEFINE_STR(UM_KERN_EMERG, KERN_EMERG);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
