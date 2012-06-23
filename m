Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Cong Wang <amwang@redhat.com>
Date: Sat, 23 Jun 2012 18:04:18 +0800
Message-Id: <1340445863-16111-8-git-send-email-amwang@redhat.com>
In-Reply-To: <1340445863-16111-1-git-send-email-amwang@redhat.com>
References: <1340445863-16111-1-git-send-email-amwang@redhat.com>
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
Subject: [uml-devel] [PATCH 07/12] um: remove km_type definitions
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <amwang@redhat.com>, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

Signed-off-by: Cong Wang <amwang@redhat.com>
---
 arch/um/include/asm/kmap_types.h |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/arch/um/include/asm/kmap_types.h b/arch/um/include/asm/kmap_types.h
index 6c03acd..2e0a6b1 100644
--- a/arch/um/include/asm/kmap_types.h
+++ b/arch/um/include/asm/kmap_types.h
@@ -8,22 +8,6 @@
 
 /* No more #include "asm/arch/kmap_types.h" ! */
 
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_UML_USERCOPY,	/* UML specific, for copy_*_user - used in do_op_one_page */
-	KM_BIO_SRC_IRQ,
-	KM_BIO_DST_IRQ,
-	KM_PTE0,
-	KM_PTE1,
-	KM_IRQ0,
-	KM_IRQ1,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_TYPE_NR
-};
+#define KM_TYPE_NR 14
 
 #endif
-- 
1.7.7.6


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

