Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUpcr-0003oZ-4V for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 08:59:17 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CUpcp-00029Y-Uw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 08:59:17 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041118170115.9195255C98@zion.localdomain>
Subject: [uml-devel] [patch 1/1] Uml - update some copyright
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
Date: Thu, 18 Nov 2004 18:01:14 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Update/add some copyright notices.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/kernel/sigio_kern.c |    2 +-
 linux-2.6.10-rc-paolo/arch/um/sys-i386/sysrq.c    |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/sigio_kern.c~uml-comments arch/um/kernel/sigio_kern.c
--- linux-2.6.10-rc/arch/um/kernel/sigio_kern.c~uml-comments	2004-11-18 17:44:54.030790640 +0100
+++ linux-2.6.10-rc-paolo/arch/um/kernel/sigio_kern.c	2004-11-18 17:44:54.051787448 +0100
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2002 - 2003 Jeff Dike (jdike@addtoit.com)
  * Licensed under the GPL
  */
 
diff -puN arch/um/sys-i386/sysrq.c~uml-comments arch/um/sys-i386/sysrq.c
--- linux-2.6.10-rc/arch/um/sys-i386/sysrq.c~uml-comments	2004-11-18 17:44:54.047788056 +0100
+++ linux-2.6.10-rc-paolo/arch/um/sys-i386/sysrq.c	2004-11-18 17:44:54.051787448 +0100
@@ -1,3 +1,8 @@
+/*
+ * Copyright (C) 2001 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
 #include "linux/kernel.h"
 #include "linux/smp.h"
 #include "linux/sched.h"
_


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
