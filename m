Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1flgEL-0006an-0C
 for linux-um@lists.infradead.org; Fri, 03 Aug 2018 19:59:22 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w73Jx5AV026215
 for <linux-um@lists.infradead.org>; Fri, 3 Aug 2018 15:59:07 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kmuj3mmbt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-um@lists.infradead.org>; Fri, 03 Aug 2018 15:59:07 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-um@lists.infradead.org> from <rppt@linux.vnet.ibm.com>;
 Fri, 3 Aug 2018 20:58:59 +0100
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH RESEND 0/7] switch several architectures NO_BOOTMEM
Date: Fri,  3 Aug 2018 22:58:43 +0300
Message-Id: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
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


Hi,

These patches perform conversion to NO_BOOTMEM of hexagon, nios2, uml and
unicore32. The architecture maintainers have acked the patches, but, since
I've got no confirmation the patches are going through the arch tree I'd
appreciate if the set would be applied to the -mm tree.

Mike Rapoport (7):
  hexagon: switch to NO_BOOTMEM
  of: ignore sub-page memory regions
  nios2: use generic early_init_dt_add_memory_arch
  nios2: switch to NO_BOOTMEM
  um: setup_physmem: stop using global variables
  um: switch to NO_BOOTMEM
  unicore32: switch to NO_BOOTMEM

 arch/hexagon/Kconfig      |  3 +++
 arch/hexagon/mm/init.c    | 20 +++++++-----------
 arch/nios2/Kconfig        |  3 +++
 arch/nios2/kernel/prom.c  | 17 ---------------
 arch/nios2/kernel/setup.c | 39 ++++++----------------------------
 arch/um/Kconfig.common    |  2 ++
 arch/um/kernel/physmem.c  | 22 +++++++++----------
 arch/unicore32/Kconfig    |  1 +
 arch/unicore32/mm/init.c  | 54 +----------------------------------------------
 drivers/of/fdt.c          | 11 +++++-----
 10 files changed, 41 insertions(+), 131 deletions(-)

-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

