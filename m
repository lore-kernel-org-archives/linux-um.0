Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhT9e-0002Ra-SU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 09:18:43 -0700
Received: from mail-gw3.sa.ew.hu ([212.108.200.82])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HhT9d-00042F-2z
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 09:18:42 -0700
MIME-version: 1.0
Message-Id: <E1HhT90-0001dW-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Apr 2007 18:18:02 +0200
Subject: [uml-devel] [patch] uml: fix cmpxchg warnings in -mm
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: 8bit
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Miklos Szeredi <mszeredi@suse.cz>

I get lot's of these on i386:

In file included from include/asm/atomic.h:10,
                 from include/linux/file.h:9,
                 from mm/fadvise.c:12:
include/asm/arch/atomic.h: In function ‘atomic_add_unless’:
include/asm/arch/atomic.h:240: warning: implicit declaration of function ‘cmpxchg’
[...]

The problem seems to be that <asm-i386/atomic.h> assumes that
<asm/processor.h> pulls in <asm/system.h>.

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
---

Index: linux/include/asm-um/processor-i386.h
===================================================================
--- linux.orig/include/asm-um/processor-i386.h	2007-04-26 15:16:47.000000000 +0200
+++ linux/include/asm-um/processor-i386.h	2007-04-27 17:58:25.000000000 +0200
@@ -9,6 +9,7 @@
 #include "linux/string.h"
 #include "asm/host_ldt.h"
 #include "asm/segment.h"
+#include "asm/system.h"
 
 extern int host_has_xmm;
 extern int host_has_cmov;

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
