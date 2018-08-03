Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1flgEW-0006as-V2
 for linux-um@lists.infradead.org; Fri, 03 Aug 2018 19:59:34 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w73Jx6E2134885
 for <linux-um@lists.infradead.org>; Fri, 3 Aug 2018 15:59:09 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kmrxtty89-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-um@lists.infradead.org>; Fri, 03 Aug 2018 15:59:08 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-um@lists.infradead.org> from <rppt@linux.vnet.ibm.com>;
 Fri, 3 Aug 2018 20:59:06 +0100
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/7] of: ignore sub-page memory regions
Date: Fri,  3 Aug 2018 22:58:45 +0300
In-Reply-To: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-Id: <1533326330-31677-3-git-send-email-rppt@linux.vnet.ibm.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-hexagon@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, nios2-dev@lists.rocketboards.org, Richard Weinberger <richard@nod.at>, Ley Foon Tan <lftan@altera.com>, Richard Kuo <rkuo@codeaurora.org>, Guan Xuetao <gxt@pku.edu.cn>

Memory region size is rounded down to page boundary and with sub-page
region it becomes 0 and there is no point to add an empty region.
Moreover, when the base is less than PAGE_SIZE we get a bogus size as
(base + size - 1) evaluates to -1.

The commit 8cccffc52694 ("of: check for size < 0 after rounding in
early_init_dt_add_memory_arch") introduced a test for wrap around for the
case when base is not page aligned, the same test can be used to ignore
sub-page region sizes.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6da20b9..e866745 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1134,12 +1134,13 @@ void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 	const u64 phys_offset = MIN_MEMBLOCK_ADDR;
 
+	if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
+		pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
+			base, base + size);
+		return;
+	}
+
 	if (!PAGE_ALIGNED(base)) {
-		if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
-			pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
-				base, base + size);
-			return;
-		}
 		size -= PAGE_SIZE - (base & ~PAGE_MASK);
 		base = PAGE_ALIGN(base);
 	}
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

