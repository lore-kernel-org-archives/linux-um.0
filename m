Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 50/66] arch/um/include/shared/irq_kern.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:31 +0100
Message-Id: <1267289508-31031-51-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, WANG Cong <xiyou.wangcong@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch/um/include/shared/irq_kern.h:14: ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/include/shared/irq_kern.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/shared/irq_kern.h b/arch/um/include/shared/irq_kern.h
index b05d22f..f5855e1 100644
--- a/arch/um/include/shared/irq_kern.h
+++ b/arch/um/include/shared/irq_kern.h
@@ -11,8 +11,7 @@
 
 extern int um_request_irq(unsigned int irq, int fd, int type,
 			  irq_handler_t handler,
-			  unsigned long irqflags,  const char * devname,
+			  unsigned long irqflags,  const char *devname,
 			  void *dev_id);
 
 #endif
-
-- 
1.7.0.90.g251a4

