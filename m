Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTqx-005UJC-3y
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 15:56:02 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 02/27] um: Declare fix_range_common as a static function
Date: Wed,  3 Mar 2021 16:54:58 +0100
Message-Id: <20210303155523.124277-3-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
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
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>

It is only used within the same file.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/kernel/tlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..3c709e6146dc 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -314,8 +314,8 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
 	return ret;
 }
 
-void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
-		      unsigned long end_addr, int force)
+static void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
+			     unsigned long end_addr, int force)
 {
 	pgd_t *pgd;
 	struct host_vm_change hvc;
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

