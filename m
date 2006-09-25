Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRvIo-0004LQ-Sc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:35:38 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GRvIo-0005wm-4S
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:35:38 -0700
Message-Id: <200609251834.k8PIYWLu005031@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 25 Sep 2006 14:34:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/8] UML - Fix missing x86_64 register definitions
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The UML/x86_64 headers were missing ptrace support for some segment
registers.  The underlying problem was that the x86_64 kernel uses
user_regs_struct rather than the ptrace register definitions in
ptrace.  This patch switches UML/x86_64 to using user_regs_struct
for its definitions of the host's registers.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/sysdep-x86_64/ptrace.h	2006-09-22 11:36:43.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/sysdep-x86_64/ptrace.h	2006-09-22 13:19:12.000000000 -0400
@@ -50,6 +50,21 @@
 #define HOST_FS 25
 #define HOST_GS 26
 
+/* Also defined in asm/ptrace-x86_64.h, but not in libc headers.  So, these
+ * are already defined for kernel code, but not for userspace code.
+ */
+#ifndef FS_BASE
+/* These aren't defined in ptrace.h, but exist in struct user_regs_struct,
+ * which is what x86_64 ptrace actually uses.
+ */
+#define FS_BASE (HOST_FS_BASE * sizeof(long))
+#define GS_BASE (HOST_GS_BASE * sizeof(long))
+#define DS (HOST_DS * sizeof(long))
+#define ES (HOST_ES * sizeof(long))
+#define FS (HOST_FS * sizeof(long))
+#define GS (HOST_GS * sizeof(long))
+#endif
+
 #define REGS_FS_BASE(r) ((r)[HOST_FS_BASE])
 #define REGS_GS_BASE(r) ((r)[HOST_GS_BASE])
 #define REGS_DS(r) ((r)[HOST_DS])
@@ -89,9 +104,12 @@ union uml_pt_regs {
 #endif
 #ifdef UML_CONFIG_MODE_SKAS
 	struct skas_regs {
-		/* XXX */
-		unsigned long regs[27];
-		unsigned long fp[65];
+		/* x86_64 ptrace uses sizeof(user_regs_struct) as its register
+		 * file size, while i386 uses FRAME_SIZE.  Therefore, we need
+		 * to use UM_FRAME_SIZE here instead of HOST_FRAME_SIZE.
+		 */
+		unsigned long regs[UM_FRAME_SIZE];
+		unsigned long fp[HOST_FP_SIZE];
                 struct faultinfo faultinfo;
 		long syscall;
 		int is_user;
@@ -120,11 +138,16 @@ extern int mode_tt;
 #define UPT_R14(r) __CHOOSE_MODE(SC_R14(UPT_SC(r)), REGS_R14((r)->skas.regs))
 #define UPT_R15(r) __CHOOSE_MODE(SC_R15(UPT_SC(r)), REGS_R15((r)->skas.regs))
 #define UPT_CS(r) __CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
+#define UPT_FS_BASE(r) \
+	__CHOOSE_MODE(SC_FS_BASE(UPT_SC(r)), REGS_FS_BASE((r)->skas.regs))
 #define UPT_FS(r) __CHOOSE_MODE(SC_FS(UPT_SC(r)), REGS_FS((r)->skas.regs))
+#define UPT_GS_BASE(r) \
+	__CHOOSE_MODE(SC_GS_BASE(UPT_SC(r)), REGS_GS_BASE((r)->skas.regs))
 #define UPT_GS(r) __CHOOSE_MODE(SC_GS(UPT_SC(r)), REGS_GS((r)->skas.regs))
 #define UPT_DS(r) __CHOOSE_MODE(SC_DS(UPT_SC(r)), REGS_DS((r)->skas.regs))
 #define UPT_ES(r) __CHOOSE_MODE(SC_ES(UPT_SC(r)), REGS_ES((r)->skas.regs))
 #define UPT_CS(r) __CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
+#define UPT_SS(r) __CHOOSE_MODE(SC_SS(UPT_SC(r)), REGS_SS((r)->skas.regs))
 #define UPT_ORIG_RAX(r) \
 	__CHOOSE_MODE((r)->tt.orig_rax, REGS_ORIG_RAX((r)->skas.regs))
 
@@ -183,6 +206,13 @@ struct syscall_args {
                 case RBP: val = UPT_RBP(regs); break; \
                 case ORIG_RAX: val = UPT_ORIG_RAX(regs); break; \
                 case CS: val = UPT_CS(regs); break; \
+                case SS: val = UPT_SS(regs); break; \
+		case FS_BASE: val = UPT_FS_BASE(regs); break; \
+                case GS_BASE: val = UPT_GS_BASE(regs); break; \
+                case DS: val = UPT_DS(regs); break; \
+                case ES: val = UPT_ES(regs); break; \
+                case FS : val = UPT_FS (regs); break; \
+		case GS: val = UPT_GS(regs); break;	    \
                 case EFLAGS: val = UPT_EFLAGS(regs); break; \
                 default :  \
                         panic("Bad register in UPT_REG : %d\n", reg);  \
@@ -214,6 +244,13 @@ struct syscall_args {
                 case RBP: UPT_RBP(regs) = __upt_val; break; \
                 case ORIG_RAX: UPT_ORIG_RAX(regs) = __upt_val; break; \
                 case CS: UPT_CS(regs) = __upt_val; break; \
+                case SS: UPT_SS(regs) = __upt_val; break; \
+                case FS_BASE: UPT_FS_BASE(regs) = __upt_val; break; \
+                case GS_BASE: UPT_GS_BASE(regs) = __upt_val; break; \
+                case DS: UPT_DS(regs) = __upt_val; break; \
+                case ES: UPT_ES(regs) = __upt_val; break; \
+                case FS: UPT_FS(regs) = __upt_val; break; \
+                case GS: UPT_GS(regs) = __upt_val; break; \
                 case EFLAGS: UPT_EFLAGS(regs) = __upt_val; break; \
                 default :  \
                         panic("Bad register in UPT_SET : %d\n", reg);  \
Index: linux-2.6.18-mm/arch/um/include/sysdep-x86_64/sc.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/sysdep-x86_64/sc.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/sysdep-x86_64/sc.h	2006-09-22 13:19:12.000000000 -0400
@@ -35,11 +35,11 @@
 #define SC_GS(sc) SC_OFFSET(sc, SC_GS)
 #define SC_EFLAGS(sc) SC_OFFSET(sc, SC_EFLAGS)
 #define SC_SIGMASK(sc) SC_OFFSET(sc, SC_SIGMASK)
+#define SC_SS(sc) SC_OFFSET(sc, SC_SS)
 #if 0
 #define SC_ORIG_RAX(sc) SC_OFFSET(sc, SC_ORIG_RAX)
 #define SC_DS(sc) SC_OFFSET(sc, SC_DS)
 #define SC_ES(sc) SC_OFFSET(sc, SC_ES)
-#define SC_SS(sc) SC_OFFSET(sc, SC_SS)
 #endif
 
 #endif
Index: linux-2.6.18-mm/include/asm-um/ptrace-x86_64.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/ptrace-x86_64.h	2006-09-22 11:34:59.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/ptrace-x86_64.h	2006-09-22 13:19:12.000000000 -0400
@@ -16,12 +16,15 @@
 
 #define HOST_AUDIT_ARCH AUDIT_ARCH_X86_64
 
+/* Also defined in sysdep/ptrace.h, so may already be defined. */
+#ifndef FS_BASE
 #define FS_BASE (21 * sizeof(unsigned long))
 #define GS_BASE (22 * sizeof(unsigned long))
 #define DS (23 * sizeof(unsigned long))
 #define ES (24 * sizeof(unsigned long))
 #define FS (25 * sizeof(unsigned long))
 #define GS (26 * sizeof(unsigned long))
+#endif
 
 #define PT_REGS_RBX(r) UPT_RBX(&(r)->regs)
 #define PT_REGS_RCX(r) UPT_RCX(&(r)->regs)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
