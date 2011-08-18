Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7p1-0000w1-Jx
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:00:07 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7p0-0004dX-S1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:00:07 +0000
Date: Thu, 18 Aug 2011 19:59:59 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7ot-0007R0-66@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 06/91] um: PTRACE_[GS]ETFPXREGS had
	been wired on the wrong subarch
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


It's 32bit-only, not 64bit-only...  And while we are at it, it's
set_fpxregs(), not set_fpregs()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/sys-i386/ptrace.c   |   14 +++++++++++++-
 arch/um/sys-x86_64/ptrace.c |   14 +-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/um/sys-i386/ptrace.c b/arch/um/sys-i386/ptrace.c
index d23b2d3..49fd25a 100644
--- a/arch/um/sys-i386/ptrace.c
+++ b/arch/um/sys-i386/ptrace.c
@@ -206,5 +206,17 @@ int set_fpxregs(struct user_fxsr_struct __user *buf, struct task_struct *child)
 long subarch_ptrace(struct task_struct *child, long request,
 		    unsigned long addr, unsigned long data)
 {
-	return -EIO;
+	int ret = -EIO;
+	void __user *datap = (void __user *) data;
+
+	switch (request) {
+	case PTRACE_GETFPXREGS: /* Get the child FPU state. */
+		ret = get_fpxregs(datap, child);
+		break;
+	case PTRACE_SETFPXREGS: /* Set the child FPU state. */
+		ret = set_fpxregs(datap, child);
+		break;
+	}
+
+	return ret;
 }
diff --git a/arch/um/sys-x86_64/ptrace.c b/arch/um/sys-x86_64/ptrace.c
index f436136..7ed49ac 100644
--- a/arch/um/sys-x86_64/ptrace.c
+++ b/arch/um/sys-x86_64/ptrace.c
@@ -178,17 +178,5 @@ int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 long subarch_ptrace(struct task_struct *child, long request,
 		    unsigned long addr, unsigned long data)
 {
-	int ret = -EIO;
-	void __user *datap = (void __user *) data;
-
-	switch (request) {
-	case PTRACE_GETFPXREGS: /* Get the child FPU state. */
-		ret = get_fpregs(datap, child);
-		break;
-	case PTRACE_SETFPXREGS: /* Set the child FPU state. */
-		ret = set_fpregs(datap, child);
-		break;
-	}
-
-	return ret;
+	return -EIO;
 }
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

