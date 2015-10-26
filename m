Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZqeOO-0007dF-4U
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 09:48:40 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZqeON-0006EX-9f for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 09:48:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 26 Oct 2015 10:48:17 +0100
Message-Id: <1445852897-13102-7-git-send-email-richard@nod.at>
In-Reply-To: <1445852897-13102-1-git-send-email-richard@nod.at>
References: <1445852897-13102-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 7/7] um: Report host OOM more nicely
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

If UML runs on the host side out of memory, report this
condition more nicely.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/tlb.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 2077248..3777b82 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -50,6 +50,13 @@ struct host_vm_change {
 	   .index	= 0, \
 	   .force	= force })
 
+static void report_enomem(void)
+{
+	printk(KERN_ERR "UML ran out of memory on the host side! "
+			"This can happen due to a memory limitation or "
+			"vm.max_map_count has been reached.\n");
+}
+
 static int do_ops(struct host_vm_change *hvc, int end,
 		  int finished)
 {
@@ -81,6 +88,9 @@ static int do_ops(struct host_vm_change *hvc, int end,
 		}
 	}
 
+	if (ret == -ENOMEM)
+		report_enomem();
+
 	return ret;
 }
 
@@ -433,8 +443,12 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 	else if (pte_newprot(*pte))
 		err = protect(mm_id, address, PAGE_SIZE, prot, 1, &flush);
 
-	if (err)
+	if (err) {
+		if (err == -ENOMEM)
+			report_enomem();
+
 		goto kill;
+	}
 
 	*pte = pte_mkuptodate(*pte);
 
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

