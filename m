Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Qy4TF-0008Qk-Os
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:13:57 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qy4TE-0008EL-TW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:13:57 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 29 Aug 2011 18:13:37 +0200
Message-Id: <1314634419-24766-8-git-send-email-richard@nod.at>
In-Reply-To: <1314634419-24766-1-git-send-email-richard@nod.at>
References: <1314634419-24766-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 7/9] um: PTRACE_[GS]ETFPXREGS had been wired on
	the wrong subarch
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@ftp.linux.org.uk>

From: Al Viro <viro@ftp.linux.org.uk>

It's 32bit-only, not 64bit-only...  And while we are at it, it's
set_fpxregs(), not set_fpregs()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Richard Weinberger <richard@nod.at>
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
1.7.6.1


------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

