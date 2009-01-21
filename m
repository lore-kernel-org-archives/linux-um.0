Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LPeoF-0002Hx-1Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2009 15:16:03 +0000
Received: from ug-out-1314.google.com ([66.249.92.171])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LPeoC-0004cF-BY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2009 15:16:02 +0000
Received: by ug-out-1314.google.com with SMTP id 36so490823uga.17
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Jan 2009 07:15:58 -0800 (PST)
Message-ID: <49773C2E.9090608@gmail.com>
Date: Wed, 21 Jan 2009 16:15:58 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] x86, um: fix GETREG/PUTREG macros
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
To: Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

When these macros aren't called with regs, e.g. with foo
this will incorectly expand to foo->foo.gp[*]

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
My other patch should probably as well have been sent to this list:
http://lkml.org/lkml/2009/1/21/203

diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
index 1a899a7..31d0e9c 100644
--- a/arch/um/sys-x86_64/signal.c
+++ b/arch/um/sys-x86_64/signal.c
@@ -49,8 +49,8 @@ static int copy_sc_from_user(struct pt_regs *regs,
 	struct user_i387_struct fp;
 	int err = 0;
 
-#define GETREG(regs, regno, sc, regname)				\
-	__get_user((regs)->regs.gp[(regno) / sizeof(unsigned long)],	\
+#define GETREG(_regs, regno, sc, regname)				\
+	__get_user((_regs)->regs.gp[(regno) / sizeof(unsigned long)],	\
 		   &(sc)->regname)
 
 	err |= GETREG(regs, R8, from, r8);
@@ -104,8 +104,8 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 	err |= __put_user(0, &to->gs);
 	err |= __put_user(0, &to->fs);
 
-#define PUTREG(regs, regno, sc, regname)				\
-	__put_user((regs)->regs.gp[(regno) / sizeof(unsigned long)],	\
+#define PUTREG(_regs, regno, sc, regname)				\
+	__put_user((_regs)->regs.gp[(regno) / sizeof(unsigned long)],	\
 		   &(sc)->regname)
 
 	err |= PUTREG(regs, RDI, to, di);


------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
