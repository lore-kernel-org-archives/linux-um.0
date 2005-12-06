Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EjjMD-0004VQ-Rm for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Dec 2005 12:24:13 -0800
Received: from courier.cs.helsinki.fi ([128.214.9.1] helo=mail.cs.helsinki.fi)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EjjMD-0006Uf-7Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Dec 2005 12:24:13 -0800
From: Pekka Enberg <penberg@cs.helsinki.fi>
Message-Id: <1133900650.3279.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [PATCH] um: fix compile error for tt
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 06 Dec 2005 22:24:09 +0200
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net

Without the included patch, I get the following compile error for um:

arch/um/kernel/tt/uaccess.c: In function `copy_from_user_tt':
arch/um/kernel/tt/uaccess.c:11: error: `FIXADDR_USER_START' undeclared (first use in this function)
arch/um/kernel/tt/uaccess.c:11: error: (Each undeclared identifier is reported only once
arch/um/kernel/tt/uaccess.c:11: error: for each function it appears in.)

The error only happens when I disable CONFIG_MODE_SKAS.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 uaccess-tt.h |    1 +
 1 file changed, 1 insertion(+)

Index: 2.6/arch/um/kernel/tt/include/uaccess-tt.h
===================================================================
--- 2.6.orig/arch/um/kernel/tt/include/uaccess-tt.h
+++ 2.6/arch/um/kernel/tt/include/uaccess-tt.h
@@ -8,6 +8,7 @@
 
 #include "linux/string.h"
 #include "linux/sched.h"
+#include "asm/fixmap.h"
 #include "asm/processor.h"
 #include "asm/errno.h"
 #include "asm/current.h"




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
