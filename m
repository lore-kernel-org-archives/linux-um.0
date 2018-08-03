Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1flgEK-0006co-U2
 for linux-um@lists.infradead.org; Fri, 03 Aug 2018 19:59:22 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w73Jx5Nx026261
 for <linux-um@lists.infradead.org>; Fri, 3 Aug 2018 15:59:17 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kmuj3mmnc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-um@lists.infradead.org>; Fri, 03 Aug 2018 15:59:16 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-um@lists.infradead.org> from <rppt@linux.vnet.ibm.com>;
 Fri, 3 Aug 2018 20:59:14 +0100
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 5/7] um: setup_physmem: stop using global variables
Date: Fri,  3 Aug 2018 22:58:48 +0300
In-Reply-To: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-Id: <1533326330-31677-6-git-send-email-rppt@linux.vnet.ibm.com>
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

The setup_physmem() function receives uml_physmem and uml_reserved as
parameters and still used these global variables. Replace such usage with
local variables.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/physmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index f02596e..0eaec0e 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -86,7 +86,7 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	long map_size;
 	int err;
 
-	offset = uml_reserved - uml_physmem;
+	offset = reserve_end - start;
 	map_size = len - offset;
 	if(map_size <= 0) {
 		os_warn("Too few physical memory! Needed=%lu, given=%lu\n",
@@ -96,12 +96,12 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 
 	physmem_fd = create_mem_file(len + highmem);
 
-	err = os_map_memory((void *) uml_reserved, physmem_fd, offset,
+	err = os_map_memory((void *) reserve_end, physmem_fd, offset,
 			    map_size, 1, 1, 1);
 	if (err < 0) {
 		os_warn("setup_physmem - mapping %ld bytes of memory at 0x%p "
 			"failed - errno = %d\n", map_size,
-			(void *) uml_reserved, err);
+			(void *) reserve_end, err);
 		exit(1);
 	}
 
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

