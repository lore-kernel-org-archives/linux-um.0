Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <_kirpichev_@mail.ru>) id 1PJDEd-0007B4-Cb
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2010 22:45:43 +0000
Received: from smtp15.mail.ru ([94.100.176.133])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PJDEb-00079X-QS
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2010 22:45:43 +0000
Message-ID: <4CE5AC8B.1010101@mail.ru>
Date: Fri, 19 Nov 2010 01:45:31 +0300
From: ykirpichev <_kirpichev_@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030004020906000604040609"
Subject: [uml-devel] [PATCH] UML: Fixes problem with relocation sections
	under X86_64
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030004020906000604040609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  Hi,

This is patch for v 2.6.36 to fix problem that was obtained for UML with 
mem=512.

There is a problem with relocatable symbols.
If module is compiled with -mcmodel=kerenel then a lot of entries with type
R_X86_64_32S are generation by gcc in relocation section. As a result 
when module is loaded at address higher than 2Gb this doesn't work.

Therefore, suggested way to fix this problem is to don't make any 
assumption about addresses at which modules can be loaded.

However, when -mcmodel=large is used, gcc doesn't understand %c in "asm" 
instruction. So, arch/x86/include/asm/bug.h has been updated as well.

Perhaps, patch should be separated into two patches.

BR/ Yury

--------------030004020906000604040609
Content-Type: text/x-patch;
	name="0001-This-patch-changes-flags-used-for-compilation-of-mod.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-This-patch-changes-flags-used-for-compilation-of-mod.pa";
	filename*1="tch"

>>From d4311ee7c147925976b671a037c0c218059d7788 Mon Sep 17 00:00:00 2001
From: Yury Kirpichev <_kirpichev_@mail.ru>
Date: Fri, 19 Nov 2010 00:03:54 +0300
Subject: [PATCH] This patch changes flags used for compilation of modules for ARCH=um
 SUBARCH=x86_64. -mcmodel=large has been added as default in order to avoid problem with
 relocation seqtions.

---
 arch/um/Makefile-x86_64    |    2 ++
 arch/x86/include/asm/bug.h |    6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index a9cd7e7..88a9125 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -17,6 +17,8 @@ ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
 HEADER_ARCH := x86
 
+CFLAGS_MODULE += -mcmodel=large
+
 # Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
 
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index f654d1b..f4ec5ed 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -9,7 +9,7 @@
 #ifdef CONFIG_X86_32
 # define __BUG_C0	"2:\t.long 1b, %c0\n"
 #else
-# define __BUG_C0	"2:\t.long 1b - 2b, %c0 - 2b\n"
+# define __BUG_C0	"2:\t.long 1b - 2b, %P0 - 2b\n"
 #endif
 
 #define BUG()							\
@@ -17,8 +17,8 @@ do {								\
 	asm volatile("1:\tud2\n"				\
 		     ".pushsection __bug_table,\"a\"\n"		\
 		     __BUG_C0					\
-		     "\t.word %c1, 0\n"				\
-		     "\t.org 2b+%c2\n"				\
+		     "\t.word %P1, 0\n"				\
+		     "\t.org 2b+%P2\n"				\
 		     ".popsection"				\
 		     : : "i" (__FILE__), "i" (__LINE__),	\
 		     "i" (sizeof(struct bug_entry)));		\
-- 
1.7.1


--------------030004020906000604040609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
--------------030004020906000604040609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------030004020906000604040609--


