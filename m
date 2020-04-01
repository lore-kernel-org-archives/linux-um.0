Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJkwq-0001HR-Nt
 for linux-um@lists.infradead.org; Wed, 01 Apr 2020 21:30:58 +0000
Message-ID: <a1f6271e7c72e49fd863efc4b7126be6598fd4f6.camel@zv.io>
Subject: [PATCH] um: add include: memset() and memcpy() are in <string.h>
From: Zach van Rijn <me@zv.io>
Date: Wed, 01 Apr 2020 16:30:48 -0500
Mime-Version: 1.0
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
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

These two functions are otherwise unknown to the pedantic compiler.
Include the correct header to enable the build to succeed.

Signed-off-by: Zach van Rijn <me@zv.io>
---
 arch/um/os-Linux/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 26ecbd64c409..044836ad7392 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
-- 
2.25.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

