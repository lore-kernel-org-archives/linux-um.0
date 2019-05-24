Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hUHwL-00073k-A3
 for linux-um@lists.infradead.org; Fri, 24 May 2019 21:41:27 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] arch: um: remove drivers/ssl.h
Date: Fri, 24 May 2019 23:41:15 +0200
Message-Id: <20190524214115.1000-1-johannes@sipsolutions.net>
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
To: linux-um@lists.infradead.org
Cc: j@w1.fi, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Johannes Berg <johannes.berg@intel.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Johannes Berg <johannes.berg@intel.com>

This file just contains two unused prototypes, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/ssl.c |  1 -
 arch/um/drivers/ssl.h | 13 -------------
 2 files changed, 14 deletions(-)
 delete mode 100644 arch/um/drivers/ssl.h

diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index b8d14fa52059..7ae407d5337e 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -12,7 +12,6 @@
 #include <linux/console.h>
 #include <asm/termbits.h>
 #include <asm/irq.h>
-#include "ssl.h"
 #include "chan.h"
 #include <init.h>
 #include <irq_user.h>
diff --git a/arch/um/drivers/ssl.h b/arch/um/drivers/ssl.h
deleted file mode 100644
index 314d17725ce6..000000000000
--- a/arch/um/drivers/ssl.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SSL_H__
-#define __SSL_H__
-
-extern int ssl_read(int fd, int line);
-extern void ssl_receive_char(int line, char ch);
-
-#endif
-
-- 
2.17.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

