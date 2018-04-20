Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] um: add IRQENTRY and SOFTIRQENTRY points.
Date: Fri, 20 Apr 2018 14:37:10 +0530
Message-Id: <1524215230-44763-1-git-send-email-maninder1.s@samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <CGME20180420090931epcas5p47799b0f1aef5b1bb70e33118bc167c84@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, kstewart@linuxfoundation.org, tglx@linutronix.de, gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com, Maninder Singh <maninder1.s@samsung.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This patchs add sections for IRQENTRY and SOFTIRQENTRY.
Initially added by below kernel patch for all architecture,
but missed in um.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=be7635e7287e0e8013af3c89a6354a9e0182594c

We need to add both sections because if someone has to use
stackdepot feature for stacktrace and want to filter IRQ stack
entries, it will break build for um.

Below patch is breaking build break for um.
mm/page_owner: ignore everything below the IRQ entry point.
V2:- https://lkml.org/lkml/2018/3/26/178
V3:- https://lkml.org/lkml/2018/3/27/357

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/um/kernel/dyn.lds.S | 2 ++
 arch/um/kernel/uml.lds.S | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index d417e38..0fb2d3a 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -71,6 +71,8 @@ SECTIONS
     SCHED_TEXT
     CPUIDLE_TEXT
     LOCK_TEXT
+    IRQENTRY_TEXT
+    SOFTIRQENTRY_TEXT
     *(.fixup)
     *(.stub .text.* .gnu.linkonce.t.*)
     /* .gnu.warning sections are handled specially by elf32.em.  */
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 3d6ed6b..f12b856 100644
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
1.9.1


