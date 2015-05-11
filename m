Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YrwCD-0004gD-8b
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 22:29:09 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YrwCC-0005Wb-5N for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 22:29:09 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 12 May 2015 00:28:51 +0200
Message-Id: <1431383335-15315-2-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 1/5] um: Cleanup mem_32/64.c headers
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

Include only headers we really need.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/mem_32.c | 3 +--
 arch/x86/um/mem_64.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/um/mem_32.c b/arch/x86/um/mem_32.c
index f40281e..744afdc 100644
--- a/arch/x86/um/mem_32.c
+++ b/arch/x86/um/mem_32.c
@@ -7,8 +7,7 @@
  */
 
 #include <linux/mm.h>
-#include <asm/page.h>
-#include <asm/mman.h>
+#include <asm/elf.h>
 
 static struct vm_area_struct gate_vma;
 
diff --git a/arch/x86/um/mem_64.c b/arch/x86/um/mem_64.c
index f8fecad..7642e2e 100644
--- a/arch/x86/um/mem_64.c
+++ b/arch/x86/um/mem_64.c
@@ -1,6 +1,5 @@
 #include <linux/mm.h>
-#include <asm/page.h>
-#include <asm/mman.h>
+#include <asm/elf.h>
 
 const char *arch_vma_name(struct vm_area_struct *vma)
 {
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

