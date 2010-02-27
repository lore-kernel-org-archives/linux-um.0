Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 43/66] arch/um/include/shared/sysrq.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:24 +0100
Message-Id: <1267289508-31031-44-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch/um/include/shared/sysrq.h:5: ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/include/shared/sysrq.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/include/shared/sysrq.h b/arch/um/include/shared/sysrq.h
index c8d332b..19181a9 100644
--- a/arch/um/include/shared/sysrq.h
+++ b/arch/um/include/shared/sysrq.h
@@ -2,6 +2,6 @@
 #define __UM_SYSRQ_H
 
 struct task_struct;
-extern void show_trace(struct task_struct* task, unsigned long *stack);
+extern void show_trace(struct task_struct *task, unsigned long *stack);
 
 #endif
-- 
1.7.0.90.g251a4

