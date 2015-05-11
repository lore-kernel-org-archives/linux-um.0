Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YrwCD-0006ED-8P
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 22:29:09 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YrwCC-00058k-9Y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 22:29:09 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 12 May 2015 00:28:54 +0200
Message-Id: <1431383335-15315-5-git-send-email-richard@nod.at>
In-Reply-To: <1431383335-15315-1-git-send-email-richard@nod.at>
References: <1431383335-15315-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 4/5] um: Add uaccess.h to ldt.c
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

...for userspace memory access.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/ldt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
index 5c0b711..9701a4f 100644
--- a/arch/x86/um/ldt.c
+++ b/arch/x86/um/ldt.c
@@ -6,6 +6,7 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <asm/unistd.h>
 #include <os.h>
 #include <skas.h>
-- 
1.8.4.5


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

