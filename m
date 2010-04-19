Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jan.kiszka@web.de>) id 1O3yuF-000094-Tf
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 21:53:27 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O3yuE-00024R-U6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 21:53:27 +0000
From: Jan Kiszka <jan.kiszka@web.de>
Date: Mon, 19 Apr 2010 23:53:05 +0200
Message-Id: <74c7d668690f283cf3b8aed92004dc72e872f7ce.1271713955.git.jan.kiszka@web.de>
In-Reply-To: <cover.1271713955.git.jan.kiszka@web.de>
References: <cover.1271713955.git.jan.kiszka@web.de>
In-Reply-To: <cover.1271713955.git.jan.kiszka@web.de>
References: <cover.1271713955.git.jan.kiszka@web.de>
Subject: [uml-devel] [PATCH 2/5] uml: Drop private round_down definition
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
To: trivial@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Already defined in kernel.h. The official version assumes that 'n' is
power of two - which it is in our case.

Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
---
 arch/um/sys-x86_64/signal.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
index 1a899a7..07797d1 100644
--- a/arch/um/sys-x86_64/signal.c
+++ b/arch/um/sys-x86_64/signal.c
@@ -165,8 +165,6 @@ struct rt_sigframe
 	struct _fpstate fpstate;
 };
 
-#define round_down(m, n) (((m) / (n)) * (n))
-
 int setup_signal_stack_si(unsigned long stack_top, int sig,
 			  struct k_sigaction *ka, struct pt_regs * regs,
 			  siginfo_t *info, sigset_t *set)
-- 
1.6.0.2


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

