Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCFze-00067o-Ew for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2005 03:50:18 -0800
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DCFzc-0000lF-LR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2005 03:50:18 -0800
From: Anton Altaparmakov <aia21@cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0503181145540.28979@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] [PATCH UML 2.6] Fix compilation due to mismerge.
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
Date: Fri, 18 Mar 2005 11:50:04 +0000 (GMT)
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, jdike@karaya.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Hi Linus/Andrew/Jeff,

The recent slew of UML updates that appeared in BK seems to have gone 
wrong somewhere.  The file "arch/um/kernel/syscall_user.c" contains 
identical content twice over, thus breaking compilation.

Below is a patch to fix this.  Please apply.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- ntfs-2.6-devel/arch/um/kernel/syscall_user.c.old	2005-03-18 11:40:12.544681735 +0000
+++ ntfs-2.6-devel/arch/um/kernel/syscall_user.c	2005-03-18 11:37:42.732441897 +0000
@@ -46,51 +46,3 @@ void record_syscall_end(int index, long 
  * c-file-style: "linux"
  * End:
  */
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdlib.h>
-#include <sys/time.h>
-#include "kern_util.h"
-#include "syscall_user.h"
-
-struct {
-	int syscall;
-	int pid;
-	long result;
-	struct timeval start;
-	struct timeval end;
-} syscall_record[1024];
-
-int record_syscall_start(int syscall)
-{
-	int max, index;
-
-	max = sizeof(syscall_record)/sizeof(syscall_record[0]);
-	index = next_syscall_index(max);
-
-	syscall_record[index].syscall = syscall;
-	syscall_record[index].pid = current_pid();
-	syscall_record[index].result = 0xdeadbeef;
-	gettimeofday(&syscall_record[index].start, NULL);
-	return(index);
-}
-
-void record_syscall_end(int index, long result)
-{
-	syscall_record[index].result = result;
-	gettimeofday(&syscall_record[index].end, NULL);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
