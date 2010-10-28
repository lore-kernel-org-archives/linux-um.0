Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <richard@nod.at>) id 1PBUcr-0003XQ-AS
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2010 15:42:49 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PBUcp-00041C-CW
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2010 15:42:49 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 28 Oct 2010 17:42:30 +0200
Message-Id: <1288280550-26997-1-git-send-email-richard@nod.at>
Subject: [uml-devel] [PATCH] um: fix ptrace build error
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org
Cc: namhyung@gmail.com, Richard Weinberger <richard@nod.at>, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Both 0a3d763 and 9b05a69 broke the um build.
This patch fixes the issues.

0a3d763 introduced the undeclared variable "datavp".
The patch seems completely untested. :-(

9b05a69 changed arch_ptrace()'s signature but did not
update um/include/asm/ptrace-generic.h.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/ptrace-generic.h |    4 ++--
 arch/um/kernel/ptrace.c              |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 2cd899f..b7c5bab 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -38,8 +38,8 @@ struct pt_regs {
 
 struct task_struct;
 
-extern long subarch_ptrace(struct task_struct *child, long request, long addr,
-			   long data);
+extern long subarch_ptrace(struct task_struct *child, long request,
+	unsigned long addr, unsigned long data);
 extern unsigned long getreg(struct task_struct *child, int regno);
 extern int putreg(struct task_struct *child, int regno, unsigned long value);
 extern int get_fpregs(struct user_i387_struct __user *buf,
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index a5e33f2..701b672 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -122,7 +122,7 @@ long arch_ptrace(struct task_struct *child, long request,
 		break;
 
 	case PTRACE_SET_THREAD_AREA:
-		ret = ptrace_set_thread_area(child, addr, datavp);
+		ret = ptrace_set_thread_area(child, addr, vp);
 		break;
 
 	case PTRACE_FAULTINFO: {
-- 
1.6.6.1


------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

