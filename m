Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1INFfl-0000P3-9x for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2007 15:24:34 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1INFfk-0002EK-Jj
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2007 15:24:33 -0700
Date: Mon, 20 Aug 2007 12:05:37 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070820160537.GA3874@localhost.localdomain>
References: <200708191142.57281.toralf.foerster@gmx.de>
	<200708191812.35947.toralf.foerster@gmx.de>
	<20070820141102.GA5833@c2.user-mode-linux.org>
	<200708201730.37648.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200708201730.37648.toralf.foerster@gmx.de>
Subject: Re: [uml-devel] build error of an UML kernel with 2.6.2x sources
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Aug 20, 2007 at 05:30:37PM +0200, Toralf F=F6rster wrote:
> I found this in /usr/include/sys/user.h (the file was installed from
> glibc-2.5-r4): =


sys/user works for me - try the patch below.

				Jeff

-- =

Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/arch/um/sys-i386/user-offsets.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22.orig/arch/um/sys-i386/user-offsets.c
+++ linux-2.6.22/arch/um/sys-i386/user-offsets.c
@@ -2,9 +2,9 @@
 #include <stddef.h>
 #include <signal.h>
 #include <sys/poll.h>
+#include <sys/user.h>
 #include <sys/mman.h>
 #include <asm/ptrace.h>
-#include <asm/user.h>
 =

 #define DEFINE(sym, val) \
 	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -48,8 +48,8 @@ void foo(void)
 	OFFSET(HOST_SC_FP_ST, _fpstate, _st);
 	OFFSET(HOST_SC_FXSR_ENV, _fpstate, _fxsr_env);
 =

-	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_i387_struct));
-	DEFINE_LONGS(HOST_XFP_SIZE, sizeof(struct user_fxsr_struct));
+	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_fpregs_struct));
+	DEFINE_LONGS(HOST_XFP_SIZE, sizeof(struct user_fpxregs_struct));
 =

 	DEFINE(HOST_IP, EIP);
 	DEFINE(HOST_SP, UESP);
Index: linux-2.6.22/arch/um/sys-x86_64/user-offsets.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22.orig/arch/um/sys-x86_64/user-offsets.c
+++ linux-2.6.22/arch/um/sys-x86_64/user-offsets.c
@@ -3,17 +3,10 @@
 #include <signal.h>
 #include <sys/poll.h>
 #include <sys/mman.h>
+#include <sys/user.h>
 #define __FRAME_OFFSETS
 #include <asm/ptrace.h>
 #include <asm/types.h>
-/* For some reason, x86_64 defines u64 and u32 only in <pci/types.h>, whic=
h I
- * refuse to include here, even though they're used throughout the headers.
- * These are used in asm/user.h, and that include can't be avoided because=
 of
- * the sizeof(struct user_regs_struct) below.
- */
-typedef __u64 u64;
-typedef __u32 u32;
-#include <asm/user.h>
 =

 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
