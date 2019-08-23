Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i19Gd-0004uH-KJ
 for linux-um@lists.infradead.org; Fri, 23 Aug 2019 13:06:12 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] arch: um: place (soft)irq text with macros
Date: Fri, 23 Aug 2019 15:06:06 +0200
Message-Id: <20190823130606.15951-1-johannes@sipsolutions.net>
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

Otherwise it gets placed without the start/end markers.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/dyn.lds.S | 2 ++
 arch/um/kernel/uml.lds.S | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index 5568cf882371..f5001481010c 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -70,6 +70,8 @@ SECTIONS
     SCHED_TEXT
     CPUIDLE_TEXT
     LOCK_TEXT
+    IRQENTRY_TEXT
+    SOFTIRQENTRY_TEXT
     *(.fixup)
     *(.stub .text.* .gnu.linkonce.t.*)
     /* .gnu.warning sections are handled specially by elf32.em.  */
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 36b07ec09742..9f21443be2c9 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -31,6 +31,8 @@ SECTIONS
     SCHED_TEXT
     CPUIDLE_TEXT
     LOCK_TEXT
+    IRQENTRY_TEXT
+    SOFTIRQENTRY_TEXT
     *(.fixup)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

