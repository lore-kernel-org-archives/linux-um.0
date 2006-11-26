Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GoR9M-0004yN-2U for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 13:02:56 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user54890)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GoR9L-0001Je-0U
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 13:02:55 -0800
From: Nix <nix@esperi.org.uk>
Date: Sun, 26 Nov 2006 21:02:52 +0000
Message-ID: <871wnpapkz.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: [uml-devel] PATCH [01/02]: [SKAS] split the skas part of ptrace.h
	into its own header
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: blaisorblade@yahoo.it

This diff applies against a kernel with the skas patch applied. It
splits ptrace.h into two pieces, one SKAS and one non-SKAS, and removes
a now-unused #define: I can reroll the skas patch accordingly if you
want, but the change is so trivial that it may not be worth it. It
needs to be on the guest anyway, as far as I can tell (rather icky:
perhaps there is a better way than this?)

I've tested the i386 and UM parts but can't test the x86-64 parts.

I haven't touched PPC or IA64 because I can't remember if they're still
meant to work or not. If they are, the same changes should be trivial
to apply to them.

Signed-off-by: Nick Alcock <nix@esperi.org.uk>

 include/asm-i386/Kbuild        |    1 +
 include/asm-i386/ptrace-skas.h |   29 +++++++++++++++++++++++++++++
 include/asm-i386/ptrace.h      |   29 +----------------------------
 3 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/include/asm-i386/Kbuild b/include/asm-i386/Kbuild
index b75a348..03f1fa1 100644
--- a/include/asm-i386/Kbuild
+++ b/include/asm-i386/Kbuild
@@ -8,3 +8,4 @@ header-y += ucontext.h
 unifdef-y += mtrr.h
 unifdef-y += setup.h
 unifdef-y += vm86.h
+unifdef-y += ptrace-skas.h
diff --git a/include/asm-i386/ptrace-skas.h b/include/asm-i386/ptrace-skas.h
new file mode 100644
index 0000000..6842650
--- /dev/null
+++ b/include/asm-i386/ptrace-skas.h
@@ -0,0 +1,29 @@
+#ifndef _I386_PTRACE_SKAS_H
+#define _I386_PTRACE_SKAS_H
+
+/*For SKAS3 support.*/
+
+#define PTRACE_FAULTINFO	  52
+/* 53 was used for PTRACE_SIGPENDING, don't reuse it. */
+#define PTRACE_LDT		  54
+#define PTRACE_SWITCH_MM 	  55
+#define PTRACE_EX_FAULTINFO	  56
+
+struct ptrace_faultinfo {
+	int is_write;
+	unsigned long addr;
+};
+
+struct ptrace_ex_faultinfo {
+	int is_write;
+	unsigned long addr;
+	int trap_no;
+};
+
+struct ptrace_ldt {
+	int func;
+  	void *ptr;
+	unsigned long bytecount;
+};
+
+#endif
diff --git a/include/asm-i386/ptrace.h b/include/asm-i386/ptrace.h
index 4be7518..da9eeb5 100644
--- a/include/asm-i386/ptrace.h
+++ b/include/asm-i386/ptrace.h
@@ -87,33 +87,6 @@ extern unsigned long profile_pc(struct p
 #endif
 #endif /* __KERNEL__ */
 
-/*For SKAS3 support.*/
-#ifndef _LINUX_PTRACE_STRUCT_DEF
-#define _LINUX_PTRACE_STRUCT_DEF
-
-#define PTRACE_FAULTINFO	  52
-/* 53 was used for PTRACE_SIGPENDING, don't reuse it. */
-#define PTRACE_LDT		  54
-#define PTRACE_SWITCH_MM 	  55
-#define PTRACE_EX_FAULTINFO	  56
-
-struct ptrace_faultinfo {
-	int is_write;
-	unsigned long addr;
-};
-
-struct ptrace_ex_faultinfo {
-	int is_write;
-	unsigned long addr;
-	int trap_no;
-};
-
-struct ptrace_ldt {
-	int func;
-  	void *ptr;
-	unsigned long bytecount;
-};
-
-#endif /*ifndef _LINUX_PTRACE_STRUCT_DEF*/
+#include <asm/ptrace-skas.h>
 
 #endif



!-------------------------------------------------------------flip-


Likewise for x86-64.

 include/asm-x86_64/Kbuild        |    1 +
 include/asm-x86_64/ptrace-skas.h |   27 +++++++++++++++++++++++++++
 include/asm-x86_64/ptrace.h      |   18 +-----------------
 3 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/asm-x86_64/Kbuild b/include/asm-x86_64/Kbuild
index 40f2f13..d49d004 100644
--- a/include/asm-x86_64/Kbuild
+++ b/include/asm-x86_64/Kbuild
@@ -19,3 +19,4 @@ header-y += vsyscall32.h
 unifdef-y += mce.h
 unifdef-y += mtrr.h
 unifdef-y += vsyscall.h
+unifdef-y += ptrace-skas.h
diff --git a/include/asm-x86_64/ptrace-skas.h b/include/asm-x86_64/ptrace-skas.h
new file mode 100644
index 0000000..7f8ac4b
--- /dev/null
+++ b/include/asm-x86_64/ptrace-skas.h
@@ -0,0 +1,27 @@
+#ifndef _X86_64_PTRACE_SKAS_H
+#define _X86_64_PTRACE_SKAS_H
+
+#define PTRACE_FAULTINFO 52
+/* 53 was used for PTRACE_SIGPENDING, don't reuse it. */
+#define PTRACE_LDT 54
+#define PTRACE_SWITCH_MM 55
+#define PTRACE_EX_FAULTINFO	  56
+
+struct ptrace_faultinfo {
+	int is_write;
+	unsigned long addr;
+};
+
+struct ptrace_ex_faultinfo {
+	int is_write;
+	unsigned long addr;
+	int trap_no;
+};
+
+struct ptrace_ldt {
+	int func;
+  	void *ptr;
+	unsigned long bytecount;
+};
+
+#endif
diff --git a/include/asm-x86_64/ptrace.h b/include/asm-x86_64/ptrace.h
index 3216236..46e6216 100644
--- a/include/asm-x86_64/ptrace.h
+++ b/include/asm-x86_64/ptrace.h
@@ -70,6 +70,7 @@ there is a nasty ciclic include chain.
 */
 
 #include <asm/types.h>
+#include <asm/ptrace-skas.h>
 
 #define		compat_int_t	s32
 #define		compat_long_t	s32
@@ -94,23 +95,6 @@ struct ptrace_ldt32 {
 	compat_ulong_t bytecount;
 };
 
-struct ptrace_faultinfo {
-	int is_write;
-	unsigned long addr;
-};
-
-struct ptrace_ex_faultinfo {
-	int is_write;
-	unsigned long addr;
-	int trap_no;
-};
-
-struct ptrace_ldt {
-	int func;
-  	void *ptr;
-	unsigned long bytecount;
-};
-
 #undef	compat_int_t
 #undef	compat_long_t
 #undef	compat_uint_t



!-------------------------------------------------------------flip-



-- 
`The main high-level difference between Emacs and (say) UNIX, Windows,
 or BeOS... is that Emacs boots quicker.' --- PdS

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
