Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EL3yu-0007qP-D4	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:22:12 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EL3yt-0000lw-9M
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:22:12 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8lAPD0Q32E+DYpf"
Message-Id: <200509291734.20977.blaisorblade@yahoo.it>
Subject: [uml-devel] TT mode and vsyscall checking
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
Date: Thu, 29 Sep 2005 17:34:20 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_8lAPD0Q32E+DYpf
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46rom what I can see, while in SKAS mode access_ok_skas() was changed to a=
llow=20
reading from vsyscall page, while TT mode wasn't.

I'm not sure it that happened:

*) because TT mode already allowed that (access_ok_tt() currently accepts a=
ny=20
read) or
*) because TT mode is different in this regard.

But the more I think the more I conclude it's the first reason.

Anyway, I wanted to make sure because I'm fixing access_ok. Attached is pat=
ch=20
1, which joins common code and adds missing checking.

Later I'll maybe drop what is unneeded, for instance, range wrapping checki=
ng=20
seems not to be done on i386, and we just need to fail in copy_from_user() =
in=20
that case.

Switching copy_*_user() to use an unsigned type for the size, maybe a long =
(I=20
don't expect anything to actually need 64-bit, even on x64, though), would =
be=20
nice too.
=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_8lAPD0Q32E+DYpf
Content-Type: text/x-diff;
  charset="us-ascii";
  name="uml-fix-access_ok-tt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-access_ok-tt.diff"

Uml: fix access_ok

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The access_ok_tt() macro is bogus, in that a read access is unconditionally
considered valid.

I couldn't find in SCM logs the introduction of this check, but I went back to
 2.4.20-1um and the definition was the same.

Possibly this was done to avoid problems with missing set_fs() calls, but there
can't be any I think because they would fail with SKAS mode. TT-specific code is
still to check.

Also, this patch joins common code together, and makes the "address range
wrapping" check happen for all cases, rather than for only some.

This may, possibly, be reoptimized at some time, but the current code doesn't
seem clever, just confused.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/um_uaccess.h               |   19 ++++++++++++++++++-
 arch/um/kernel/skas/include/uaccess-skas.h |   10 ++--------
 arch/um/kernel/tt/include/uaccess-tt.h     |    8 +-------
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/um/include/um_uaccess.h b/arch/um/include/um_uaccess.h
--- a/arch/um/include/um_uaccess.h
+++ b/arch/um/include/um_uaccess.h
@@ -17,8 +17,25 @@
 #include "uaccess-skas.h"
 #endif
 
+#define __under_task_size(addr, size) \
+	(((unsigned long) (addr) < TASK_SIZE) && \
+         (((unsigned long) (addr) + (size)) < TASK_SIZE))
+
+#define __access_ok_vsyscall(type, addr, size) \
+	 ((type == VERIFY_READ) && \
+	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
+	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
+	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr)))
+
+#define __addr_range_nowrap(addr, size) \
+	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
+
 #define access_ok(type, addr, size) \
-	CHOOSE_MODE_PROC(access_ok_tt, access_ok_skas, type, addr, size)
+	(__addr_range_nowrap(addr, size) && \
+	 (__under_task_size(addr, size) || \
+	  __access_ok_vsyscall(type, addr, size) || \
+	  segment_eq(get_fs(), KERNEL_DS) || \
+	  CHOOSE_MODE_PROC(access_ok_tt, access_ok_skas, type, addr, size)))
 
 static inline int copy_from_user(void *to, const void __user *from, int n)
 {
diff --git a/arch/um/kernel/skas/include/uaccess-skas.h b/arch/um/kernel/skas/include/uaccess-skas.h
--- a/arch/um/kernel/skas/include/uaccess-skas.h
+++ b/arch/um/kernel/skas/include/uaccess-skas.h
@@ -9,14 +9,8 @@
 #include "asm/errno.h"
 #include "asm/fixmap.h"
 
-#define access_ok_skas(type, addr, size) \
-	((segment_eq(get_fs(), KERNEL_DS)) || \
-	 (((unsigned long) (addr) < TASK_SIZE) && \
-	  ((unsigned long) (addr) + (size) <= TASK_SIZE)) || \
-	 ((type == VERIFY_READ ) && \
-	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
-	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
-	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr))))
+/* No SKAS-specific checking. */
+#define access_ok_skas(type, addr, size) 0
 
 extern int copy_from_user_skas(void *to, const void __user *from, int n);
 extern int copy_to_user_skas(void __user *to, const void *from, int n);
diff --git a/arch/um/kernel/tt/include/uaccess-tt.h b/arch/um/kernel/tt/include/uaccess-tt.h
--- a/arch/um/kernel/tt/include/uaccess-tt.h
+++ b/arch/um/kernel/tt/include/uaccess-tt.h
@@ -19,19 +19,13 @@
 extern unsigned long end_vm;
 extern unsigned long uml_physmem;
 
-#define under_task_size(addr, size) \
-	(((unsigned long) (addr) < TASK_SIZE) && \
-         (((unsigned long) (addr) + (size)) < TASK_SIZE))
-
 #define is_stack(addr, size) \
 	(((unsigned long) (addr) < STACK_TOP) && \
 	 ((unsigned long) (addr) >= STACK_TOP - ABOVE_KMEM) && \
 	 (((unsigned long) (addr) + (size)) <= STACK_TOP))
 
 #define access_ok_tt(type, addr, size) \
-	((type == VERIFY_READ) || (segment_eq(get_fs(), KERNEL_DS)) || \
-         (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
-          (under_task_size(addr, size) || is_stack(addr, size))))
+	(is_stack(addr, size))
 
 extern unsigned long get_fault_addr(void);
 

--Boundary-00=_8lAPD0Q32E+DYpf--


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
