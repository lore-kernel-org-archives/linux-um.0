Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HzDpO-0006T8-GZ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jun 2007 08:35:11 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HzDpM-0000zj-UM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jun 2007 08:35:10 -0700
Date: Fri, 15 Jun 2007 11:34:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070615153450.GA7725@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/2] UML - add asm/paravirt.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Arun Raghavan <arunsr@cse.iitk.ac.in>

Add asm-um/paravirt.h so that i386 headers that get pulled into UML
don't cause build failures when they want asm/paravirt.h.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 include/asm-um/paravirt.h |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6.21-mm/include/asm-um/paravirt.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.21-mm/include/asm-um/paravirt.h	2007-06-14 12:02:04.000000000 -0400
@@ -0,0 +1,6 @@
+#ifndef __UM_PARAVIRT_H
+#define __UM_PARAVIRT_H
+
+#include "asm/arch/paravirt.h"
+
+#endif

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
