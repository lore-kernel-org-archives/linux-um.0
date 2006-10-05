Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVayt-0006Ym-CU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:42:15 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GVays-0002Dr-Pj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:42:15 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Thu, 05 Oct 2006 23:39:10 +0200
Message-Id: <20061005213910.17268.63692.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Subject: [uml-devel] [PATCH 11/14] uml: asm offsets duplication removal
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Unify macros common to x86 and x86_64 kernel-offsets.h files.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/common-offsets.h               |   10 ++++++++++
 arch/um/include/sysdep-i386/kernel-offsets.h   |    4 ----
 arch/um/include/sysdep-x86_64/kernel-offsets.h |    4 ----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/um/include/common-offsets.h b/arch/um/include/common-offsets.h
index 39bb210..461175f 100644
--- a/arch/um/include/common-offsets.h
+++ b/arch/um/include/common-offsets.h
@@ -1,9 +1,16 @@
 /* for use by sys-$SUBARCH/kernel-offsets.c */
 
+DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
+#ifdef CONFIG_MODE_TT
+OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
+#endif
+
 OFFSET(HOST_TASK_REGS, task_struct, thread.regs);
 OFFSET(HOST_TASK_PID, task_struct, pid);
+
 DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
 DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
+
 DEFINE_STR(UM_KERN_EMERG, KERN_EMERG);
 DEFINE_STR(UM_KERN_ALERT, KERN_ALERT);
 DEFINE_STR(UM_KERN_CRIT, KERN_CRIT);
@@ -12,7 +19,10 @@ DEFINE_STR(UM_KERN_WARNING, KERN_WARNING
 DEFINE_STR(UM_KERN_NOTICE, KERN_NOTICE);
 DEFINE_STR(UM_KERN_INFO, KERN_INFO);
 DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
+
 DEFINE(UM_ELF_CLASS, ELF_CLASS);
 DEFINE(UM_ELFCLASS32, ELFCLASS32);
 DEFINE(UM_ELFCLASS64, ELFCLASS64);
+
+/* For crypto assembler code. */
 DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
diff --git a/arch/um/include/sysdep-i386/kernel-offsets.h b/arch/um/include/sysdep-i386/kernel-offsets.h
index 2e58c4c..97ec9d8 100644
--- a/arch/um/include/sysdep-i386/kernel-offsets.h
+++ b/arch/um/include/sysdep-i386/kernel-offsets.h
@@ -18,9 +18,5 @@ #define OFFSET(sym, str, mem) \
 void foo(void)
 {
 	OFFSET(HOST_TASK_DEBUGREGS, task_struct, thread.arch.debugregs);
-	DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
-#ifdef CONFIG_MODE_TT
-	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
-#endif
 #include <common-offsets.h>
 }
diff --git a/arch/um/include/sysdep-x86_64/kernel-offsets.h b/arch/um/include/sysdep-x86_64/kernel-offsets.h
index 4cbfbb9..a307237 100644
--- a/arch/um/include/sysdep-x86_64/kernel-offsets.h
+++ b/arch/um/include/sysdep-x86_64/kernel-offsets.h
@@ -19,9 +19,5 @@ #define OFFSET(sym, str, mem) \
 
 void foo(void)
 {
-	DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
-#ifdef CONFIG_MODE_TT
-	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
-#endif
 #include <common-offsets.h>
 }
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
