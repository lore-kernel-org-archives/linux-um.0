Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7gWY-0007Ja-7q
 for linux-um@lists.infradead.org; Tue, 10 Sep 2019 13:49:39 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 2/5] um: use real DMA barriers
Date: Tue, 10 Sep 2019 15:49:27 +0200
Message-Id: <1568123305-Ieca0b50a173f8a587d412db861c7ae4d6bae97c4@changeid>
In-Reply-To: <20190910134930.22688-1-johannes@sipsolutions.net>
References: <20190910134930.22688-1-johannes@sipsolutions.net>
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

Since in any other case we don't really use DMA barriers, remove
their override completely so real barriers will get used. In the
future we might need them for other cases as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/x86/um/asm/barrier.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/um/asm/barrier.h b/arch/x86/um/asm/barrier.h
index eb0654f39fd2..165be7f9a964 100644
--- a/arch/x86/um/asm/barrier.h
+++ b/arch/x86/um/asm/barrier.h
@@ -23,9 +23,6 @@
 
 #endif /* CONFIG_X86_32 */
 
-#define dma_rmb()	barrier()
-#define dma_wmb()	barrier()
-
 #include <asm-generic/barrier.h>
 
 #endif
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

