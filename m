Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1INgGa-0006V0-Ey for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Aug 2007 19:48:20 -0700
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1INgGa-0002wM-4k
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Aug 2007 19:48:20 -0700
Received: from landley.net (localhost [127.0.0.1])
	by grelber.thyrsus.com (Postfix) with ESMTP id 06EFA7392E
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 21 Aug 2007 22:50:24 -0400 (EDT)
From: Rob Landley <rob@landley.net>
Date: Tue, 21 Aug 2007 21:48:05 -0500
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200708212148.05392.rob@landley.net>
Subject: [uml-devel] UML doesn't build in 2.6.23-rc3.
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

I fixed it for me with the following patch, just in case anybody else had this 
problem:

--- linux-2.6.23-rc3/arch/um/kernel/smp.c	2007-08-12 23:25:24.000000000 -0500
+++ linux-2.6.23-new/arch/um/kernel/smp.c	2007-08-21 21:39:00.000000000 -0500
@@ -5,6 +5,7 @@
 
 #include "linux/percpu.h"
 #include "asm/pgalloc.h"
+#include "linux/pagemap.h"
 #include "asm/tlb.h"
 
 /* For some reason, mmu_gathers are referenced when CONFIG_SMP is off. */

-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
