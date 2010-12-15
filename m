Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Dec 2010 16:26:35 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] uml: mmapper_kern needs MODULE_LICENSE
Message-Id: <20101214162635.dd87b0d9.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, akpm <akpm@linux-foundation.org>, Greg Lonnon <glonnon@ridgerun.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Randy Dunlap <randy.dunlap@oracle.com>

Add missing MODULE_LICENSE():

WARNING: modpost: missing MODULE_LICENSE() in arch/um/drivers/mmapper_kern.o

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Greg Lonnon <glonnon@ridgerun.com>
---
 arch/um/drivers/mmapper_kern.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20101214.orig/arch/um/drivers/mmapper_kern.c
+++ linux-next-20101214/arch/um/drivers/mmapper_kern.c
@@ -137,3 +137,4 @@ module_exit(mmapper_exit);
 
 MODULE_AUTHOR("Greg Lonnon <glonnon@ridgerun.com>");
 MODULE_DESCRIPTION("DSPLinux simulator mmapper driver");
+MODULE_LICENSE("GPL");
