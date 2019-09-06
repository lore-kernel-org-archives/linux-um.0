Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6MJV-0001zt-7k
 for linux-um@lists.infradead.org; Fri, 06 Sep 2019 22:02:42 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC] um: have real DMA barriers with virtio
Date: Sat,  7 Sep 2019 00:02:33 +0200
Message-Id: <1567807353-Ieca0b50a173f8a587d412db861c7ae4d6bae97c4@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

When we have virtio enabled, we must have real barriers since we
may be running on an SMP machine (quite likely are, in fact), so
the other process can be on another CPU.

Make the override to compiler barriers depend on !virtio.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/x86/um/asm/barrier.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/um/asm/barrier.h b/arch/x86/um/asm/barrier.h
index eb0654f39fd2..fd90b3c7cba8 100644
--- a/arch/x86/um/asm/barrier.h
+++ b/arch/x86/um/asm/barrier.h
@@ -23,8 +23,16 @@
 
 #endif /* CONFIG_X86_32 */
 
+#if !IS_ENABLED(CONFIG_VIRTIO_UML)
+/*
+ * We can afford to just have compiler barriers here - unless
+ * virtio is enabled, because then we communicate with another
+ * process and (despite being UP internally) cannot assume we
+ * run on a UP system.
+ */
 #define dma_rmb()	barrier()
 #define dma_wmb()	barrier()
+#endif
 
 #include <asm-generic/barrier.h>
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

