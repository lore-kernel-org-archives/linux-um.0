Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkxOr-0008El-Gq
 for linux-um@lists.infradead.org; Mon, 15 Jun 2020 22:16:18 +0000
Received: by mail-qk1-f197.google.com with SMTP id d187so15408361qke.4
 for <linux-um@lists.infradead.org>; Mon, 15 Jun 2020 15:16:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
Subject: [PATCH 01/25] mm/um: Fix extra accounting for page fault retries
Date: Mon, 15 Jun 2020 18:15:43 -0400
Message-Id: <20200615221607.7764-2-peterx@redhat.com>
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

When page fault retried, we should only do the accounting once rather than once
for each page fault retry.

CC: Jeff Dike <jdike@addtoit.com>
CC: Richard Weinberger <richard@nod.at>
CC: Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC: linux-um@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/um/kernel/trap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 8f18cf56b3dd..d162168490d1 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -34,6 +34,7 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	pte_t *pte;
 	int err = -EFAULT;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+	vm_fault_t fault, major = 0;
 
 	*code_out = SEGV_MAPERR;
 
@@ -73,9 +74,8 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	}
 
 	do {
-		vm_fault_t fault;
-
 		fault = handle_mm_fault(vma, address, flags);
+		major |= fault & VM_FAULT_MAJOR;
 
 		if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
 			goto out_nosemaphore;
@@ -92,10 +92,6 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 			BUG();
 		}
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			if (fault & VM_FAULT_MAJOR)
-				current->maj_flt++;
-			else
-				current->min_flt++;
 			if (fault & VM_FAULT_RETRY) {
 				flags |= FAULT_FLAG_TRIED;
 
@@ -103,6 +99,11 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 			}
 		}
 
+		if (major)
+			current->maj_flt++;
+		else
+			current->min_flt++;
+
 		pgd = pgd_offset(mm, address);
 		p4d = p4d_offset(pgd, address);
 		pud = pud_offset(p4d, address);
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

