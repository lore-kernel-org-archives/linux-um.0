Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEsJn-0000iO-L2 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 09:37:39 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEsJc-0002ET-Ih for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 09:37:39 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041005162044.A6C11B005@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml: makefile fix for .lds scripts.
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
Date: Tue, 05 Oct 2004 18:20:43 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Remove uml.lds and dyn.lds from extra-y; this was a relict from the recent
past.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/Makefile~uml-makefiles-lds-script-fix arch/um/kernel/Makefile
--- linux-2.6.9-current/arch/um/kernel/Makefile~uml-makefiles-lds-script-fix	2004-10-05 18:20:08.097717672 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/Makefile	2004-10-05 18:20:08.099717368 +0200
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-extra-y := vmlinux.lds uml.lds dyn.lds
+extra-y := vmlinux.lds
 clean-files := vmlinux.lds.S
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
