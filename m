Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IsY1p-0008Gg-Gg for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 22:16:41 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IsY1o-0006aA-OO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 22:16:41 -0800
Date: Wed, 14 Nov 2007 22:14:51 -0800
From: Greg KH <gregkh@suse.de>
Message-ID: <20071115061451.GJ7980@kroah.com>
References: <20071115054813.977066477@mini.kroah.org>
MIME-Version: 1.0
Content-Disposition: inline; filename="uml-stop-using-libc-asm-user.h.patch"
In-Reply-To: <20071115061415.GA7980@kroah.com>
Subject: [uml-devel] [patch 09/19] UML - stop using libc asm/user.h
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

commit 189872f968def833727b6bfef83ebd7440c538e6 in mainline.

uml: don't use glibc asm/user.h

Stop including asm/user.h from libc - it seems to be disappearing from
distros.  It's replaced with sys/user.h which defines user_fpregs_struct and
user_fpxregs_struct instead of user_i387_struct and struct user_fxsr_struct on
i386.

As a bonus, on x86_64, I get to dump some stupid typedefs which were needed in
order to get asm/user.h to compile.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/sys-i386/user-offsets.c   |    6 +++---
 arch/um/sys-x86_64/user-offsets.c |    9 +--------
 2 files changed, 4 insertions(+), 11 deletions(-)

--- a/arch/um/sys-i386/user-offsets.c
+++ b/arch/um/sys-i386/user-offsets.c
@@ -2,9 +2,9 @@
 #include <stddef.h>
 #include <signal.h>
 #include <sys/poll.h>
+#include <sys/user.h>
 #include <sys/mman.h>
 #include <asm/ptrace.h>
-#include <asm/user.h>
 
 #define DEFINE(sym, val) \
 	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -48,8 +48,8 @@ void foo(void)
 	OFFSET(HOST_SC_FP_ST, _fpstate, _st);
 	OFFSET(HOST_SC_FXSR_ENV, _fpstate, _fxsr_env);
 
-	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_i387_struct));
-	DEFINE_LONGS(HOST_XFP_SIZE, sizeof(struct user_fxsr_struct));
+	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_fpregs_struct));
+	DEFINE_LONGS(HOST_XFP_SIZE, sizeof(struct user_fpxregs_struct));
 
 	DEFINE(HOST_IP, EIP);
 	DEFINE(HOST_SP, UESP);
--- a/arch/um/sys-x86_64/user-offsets.c
+++ b/arch/um/sys-x86_64/user-offsets.c
@@ -3,17 +3,10 @@
 #include <signal.h>
 #include <sys/poll.h>
 #include <sys/mman.h>
+#include <sys/user.h>
 #define __FRAME_OFFSETS
 #include <asm/ptrace.h>
 #include <asm/types.h>
-/* For some reason, x86_64 defines u64 and u32 only in <pci/types.h>, which I
- * refuse to include here, even though they're used throughout the headers.
- * These are used in asm/user.h, and that include can't be avoided because of
- * the sizeof(struct user_regs_struct) below.
- */
-typedef __u64 u64;
-typedef __u32 u32;
-#include <asm/user.h>
 
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))

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
