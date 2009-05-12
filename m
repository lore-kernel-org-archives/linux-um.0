Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1M4078-0001sj-Mo
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 May 2009 22:06:18 +0000
Received: from mail-ew0-f169.google.com ([209.85.219.169])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M4074-0001ti-AD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 May 2009 22:06:18 +0000
Received: by ewy17 with SMTP id 17so369733ewy.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 May 2009 15:06:12 -0700 (PDT)
Message-ID: <4A09F2D3.9030006@gmail.com>
Date: Wed, 13 May 2009 00:06:11 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] uml: bad macro expansion, parameter is member
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

`ELF_CORE_COPY_REGS(x, y)' will make expansions like:
`(y)[0] = (x)->x.gp[0]' but correct is `(y)[0] = (x)->regs.gp[0]'

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/um/sys-x86_64/asm/elf.h b/arch/um/sys-x86_64/asm/elf.h
index 6e8a919..04b9e87 100644
--- a/arch/um/sys-x86_64/asm/elf.h
+++ b/arch/um/sys-x86_64/asm/elf.h
@@ -66,28 +66,28 @@ typedef struct user_i387_struct elf_fpregset_t;
 	PT_REGS_R15(regs) = 0; \
 } while (0)
 
-#define ELF_CORE_COPY_REGS(pr_reg, regs)		\
-	(pr_reg)[0] = (regs)->regs.gp[0];			\
-	(pr_reg)[1] = (regs)->regs.gp[1];			\
-	(pr_reg)[2] = (regs)->regs.gp[2];			\
-	(pr_reg)[3] = (regs)->regs.gp[3];			\
-	(pr_reg)[4] = (regs)->regs.gp[4];			\
-	(pr_reg)[5] = (regs)->regs.gp[5];			\
-	(pr_reg)[6] = (regs)->regs.gp[6];			\
-	(pr_reg)[7] = (regs)->regs.gp[7];			\
-	(pr_reg)[8] = (regs)->regs.gp[8];			\
-	(pr_reg)[9] = (regs)->regs.gp[9];			\
-	(pr_reg)[10] = (regs)->regs.gp[10];			\
-	(pr_reg)[11] = (regs)->regs.gp[11];			\
-	(pr_reg)[12] = (regs)->regs.gp[12];			\
-	(pr_reg)[13] = (regs)->regs.gp[13];			\
-	(pr_reg)[14] = (regs)->regs.gp[14];			\
-	(pr_reg)[15] = (regs)->regs.gp[15];			\
-	(pr_reg)[16] = (regs)->regs.gp[16];			\
-	(pr_reg)[17] = (regs)->regs.gp[17];			\
-	(pr_reg)[18] = (regs)->regs.gp[18];			\
-	(pr_reg)[19] = (regs)->regs.gp[19];			\
-	(pr_reg)[20] = (regs)->regs.gp[20];			\
+#define ELF_CORE_COPY_REGS(pr_reg, _regs)		\
+	(pr_reg)[0] = (_regs)->regs.gp[0];			\
+	(pr_reg)[1] = (_regs)->regs.gp[1];			\
+	(pr_reg)[2] = (_regs)->regs.gp[2];			\
+	(pr_reg)[3] = (_regs)->regs.gp[3];			\
+	(pr_reg)[4] = (_regs)->regs.gp[4];			\
+	(pr_reg)[5] = (_regs)->regs.gp[5];			\
+	(pr_reg)[6] = (_regs)->regs.gp[6];			\
+	(pr_reg)[7] = (_regs)->regs.gp[7];			\
+	(pr_reg)[8] = (_regs)->regs.gp[8];			\
+	(pr_reg)[9] = (_regs)->regs.gp[9];			\
+	(pr_reg)[10] = (_regs)->regs.gp[10];			\
+	(pr_reg)[11] = (_regs)->regs.gp[11];			\
+	(pr_reg)[12] = (_regs)->regs.gp[12];			\
+	(pr_reg)[13] = (_regs)->regs.gp[13];			\
+	(pr_reg)[14] = (_regs)->regs.gp[14];			\
+	(pr_reg)[15] = (_regs)->regs.gp[15];			\
+	(pr_reg)[16] = (_regs)->regs.gp[16];			\
+	(pr_reg)[17] = (_regs)->regs.gp[17];			\
+	(pr_reg)[18] = (_regs)->regs.gp[18];			\
+	(pr_reg)[19] = (_regs)->regs.gp[19];			\
+	(pr_reg)[20] = (_regs)->regs.gp[20];			\
 	(pr_reg)[21] = current->thread.arch.fs;			\
 	(pr_reg)[22] = 0;					\
 	(pr_reg)[23] = 0;					\

------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

