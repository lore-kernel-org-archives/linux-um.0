Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPqEb-0003vW-2B
 for linux-um@lists.infradead.org; Thu, 22 Nov 2018 14:45:38 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] Remove unnecessary faulted check in uaccess.c
Date: Thu, 22 Nov 2018 14:45:13 +0000
Message-Id: <20181122144513.29518-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

It is not necessary to check if a fault has occured or not
after disabling pagefaults. kmap_atomic does that in all
cases and we can disable it for 64 bit where kmap is not needed
and a simple page_address would suffice.

dd if=/dev/zero of=/dev/null bs=1M count=1M
Before: 3.1GB/s. After: 3.5GB/s

There is a noticeable difference for file disk read and write
as well as less noticeable difference for network IO.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/kernel/skas/uaccess.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index d450797a3a7c..7f06fdbc7ee1 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -62,27 +62,28 @@ static int do_op_one_page(unsigned long addr, int len, int is_write,
 	jmp_buf buf;
 	struct page *page;
 	pte_t *pte;
-	int n, faulted;
+	int n;
 
 	pte = maybe_map(addr, is_write);
 	if (pte == NULL)
 		return -1;
 
 	page = pte_page(*pte);
+#ifdef CONFIG_64BIT
+	pagefault_disable();
+	addr = (unsigned long) page_address(page) +
+		(addr & ~PAGE_MASK);
+#else
 	addr = (unsigned long) kmap_atomic(page) +
 		(addr & ~PAGE_MASK);
+#endif
+	n = (*op)(addr, len, arg);
 
-	current->thread.fault_catcher = &buf;
-
-	faulted = UML_SETJMP(&buf);
-	if (faulted == 0)
-		n = (*op)(addr, len, arg);
-	else
-		n = -1;
-
-	current->thread.fault_catcher = NULL;
-
+#ifdef CONFIG_64BIT
+	pagefault_enable();
+#else
 	kunmap_atomic((void *)addr);
+#endif
 
 	return n;
 }
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

