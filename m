Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IsY1l-0008GL-I6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 22:16:37 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IsY1k-0007wP-S1
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 22:16:37 -0800
Date: Wed, 14 Nov 2007 22:14:44 -0800
From: Greg KH <gregkh@suse.de>
Message-ID: <20071115061444.GH7980@kroah.com>
References: <20071115054813.977066477@mini.kroah.org>
MIME-Version: 1.0
Content-Disposition: inline; filename="uml-stop-using-libc-asm-page.h.patch"
In-Reply-To: <20071115061415.GA7980@kroah.com>
Subject: [uml-devel] [patch 07/19] UML - Stop using libc asm/page.h
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
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, akpm@linux-foundation.org, Jeff Dike <jdike@linux.intel.com>, torvalds@linux-foundation.org, alan@lxorguk.ukuu.org.uk

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jeff Dike <jdike@addtoit.com>

commit 71f926f2ea61994470a53c9e11d3ef993197cada in mainline.

uml: stop using libc asm/page.h

Remove includes of asm/page.h from libc code.  This header seems to be
disappearing, and UML doesn't make much use of it anyway.

The one use, PAGE_SHIFT in stub.h, is handled by copying the constant from the
kernel side of the house in common_offsets.h.

[ jdike - added arch/um/kernel/skas/clone.c for -stable ]

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/include/common-offsets.h   |    1 +
 arch/um/include/sysdep-i386/stub.h |    3 +--
 arch/um/kernel/skas/clone.c        |    1 -
 arch/um/os-Linux/main.c            |    1 -
 arch/um/os-Linux/skas/mem.c        |    1 -
 arch/um/os-Linux/start_up.c        |    1 -
 arch/um/os-Linux/tt.c              |    1 -
 7 files changed, 2 insertions(+), 7 deletions(-)

--- a/arch/um/include/common-offsets.h
+++ b/arch/um/include/common-offsets.h
@@ -10,6 +10,7 @@ OFFSET(HOST_TASK_PID, task_struct, pid);
 
 DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
 DEFINE(UM_KERN_PAGE_MASK, PAGE_MASK);
+DEFINE(UM_KERN_PAGE_SHIFT, PAGE_SHIFT);
 DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 
 DEFINE_STR(UM_KERN_EMERG, KERN_EMERG);
--- a/arch/um/include/sysdep-i386/stub.h
+++ b/arch/um/include/sysdep-i386/stub.h
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
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -3,7 +3,6 @@
 #include <sys/mman.h>
 #include <sys/time.h>
 #include <asm/unistd.h>
-#include <asm/page.h>
 #include "ptrace_user.h"
 #include "skas.h"
 #include "stub-data.h"
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -12,7 +12,6 @@
 #include <sys/resource.h>
 #include <sys/mman.h>
 #include <sys/user.h>
-#include <asm/page.h>
 #include "kern_util.h"
 #include "as-layout.h"
 #include "mem_user.h"
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -9,7 +9,6 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
-#include <asm/page.h>
 #include <asm/unistd.h>
 #include "mem_user.h"
 #include "mem.h"
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -19,7 +19,6 @@
 #include <sys/mman.h>
 #include <sys/resource.h>
 #include <asm/unistd.h>
-#include <asm/page.h>
 #include <sys/types.h>
 #include "kern_util.h"
 #include "user.h"
--- a/arch/um/os-Linux/tt.c
+++ b/arch/um/os-Linux/tt.c
@@ -17,7 +17,6 @@
 #include <sys/mman.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
-#include <asm/page.h>
 #include "kern_util.h"
 #include "user.h"
 #include "signal_kern.h"

-- 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
