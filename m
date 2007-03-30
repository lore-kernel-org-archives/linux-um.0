Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXNZU-0001om-Dy for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 13:19:40 -0700
Received: from mx1.suse.de ([195.135.220.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HXNZT-0003t2-N2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 13:19:40 -0700
From: <gregkh@suse.de>
Date: Fri, 30 Mar 2007 13:18:02 -0700
In-Reply-To: <20070325165432.GA6232@c2.user-mode-linux.org>
Message-Id: <20070330201935.2E0D3CA0129@imap.suse.de>
Subject: [uml-devel] patch uml-fix-static-linking.patch queued to -stable tree
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com, JC.LAFOUCRIERE@CEA.FR, akpm@osdl.org, gregkh@suse.de, jdike@linux.intel.com, user-mode-linux-devel@lists.sourceforge.net
Cc: stable@kernel.org


This is a note to let you know that we have just queued up the patch titled

     Subject: UML - Fix static linking

to the 2.6.20-stable tree.  Its filename is

     uml-fix-static-linking.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


From stable-bounces@linux.kernel.org Sun Mar 25 09:58:58 2007
From: Jeff Dike <jdike@addtoit.com>
Date: Sun, 25 Mar 2007 12:54:32 -0400
Subject: UML - Fix static linking
To: Andrew Morton <akpm@osdl.org>, stable@kernel.org
Cc: <JC.LAFOUCRIERE@CEA.FR>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Message-ID: <20070325165432.GA6232@c2.user-mode-linux.org>
Content-Disposition: inline

From: Jeff Dike <jdike@addtoit.com>

During a static link, ld has started putting a .note section in the
.uml.setup.init section.  This has the result that the UML setups
begin with 32 bytes of garbage and UML crashes immediately on boot.

This patch creates a specific .note section for ld to drop this stuff
into.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.21-mm.orig/include/asm-um/common.lds.S	2007-03-05 13:03:47.000000000 -0500
+++ linux-2.6.21-mm/include/asm-um/common.lds.S	2007-03-23 23:03:53.000000000 -0400
@@ -15,6 +15,7 @@
   PROVIDE (_unprotected_end = .);
 
   . = ALIGN(4096);
+  .note : { *(note.*) }
   __start___ex_table = .;
   __ex_table : { *(__ex_table) }
   __stop___ex_table = .;

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable


Patches currently in stable-queue which might be from jdike@addtoit.com are


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
