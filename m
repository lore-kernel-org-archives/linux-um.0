Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx9I9-0003G6-4X for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 11:38:57 -0800
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cx9I7-0006re-P6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 11:38:57 -0800
Message-ID: <4203CF43.20703@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070607010000030806070102"
Subject: [uml-devel] Fix compilation of UML after the stack-randomization
	patches
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
Date: Fri, 04 Feb 2005 12:38:43 -0700
To: Andrew Morton <akpm@osdl.org>, UML Devel <user-mode-linux-devel@lists.sourceforge.net>, "Frank Denis (Jedi/Sector One)" <lkml@pureftpd.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>

This is a multi-part message in MIME format.
--------------070607010000030806070102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The stack randomization patches that went into 2.6.11-rc3-mm1 broke 
compilation of ARCH=um.  This patch fixes compiling by adding 
arch_align_stack back in.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>
Acked-By: Jeff Dike <jdike@addtoit.com>

Frank
-- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com

--------------070607010000030806070102
Content-Type: text/plain;
 name="um-2.6.11-randomization-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="um-2.6.11-randomization-fix"

diff -Naur linux-2.6.11-rc3-mm1_bak/arch/um/kernel/process_kern.c linux-2.6.11-rc3-mm1/arch/um/kernel/process_kern.c
--- linux-2.6.11-rc3-mm1_bak/arch/um/kernel/process_kern.c	2005-02-04 12:09:03.000000000 -0700
+++ linux-2.6.11-rc3-mm1/arch/um/kernel/process_kern.c	2005-02-04 12:16:59.000000000 -0700
@@ -21,6 +21,7 @@
 #include "linux/spinlock.h"
 #include "linux/proc_fs.h"
 #include "linux/ptrace.h"
+#include "linux/random.h"
 #include "asm/unistd.h"
 #include "asm/mman.h"
 #include "asm/segment.h"
@@ -479,6 +480,14 @@
 	return 2;
 }
 
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (randomize_va_space)
+		sp -= get_random_int() % 8192;
+	return sp & ~0xf;
+}
+
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically

--------------070607010000030806070102--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
