Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cycwa-0001a5-9y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 13:30:48 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CycwY-0001ND-L3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 13:30:48 -0800
Message-Id: <200502082221.j18MLqs0013717@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: [BUG report] UML linux-2.6 latest BK doesn't
	compile 
In-Reply-To: Your message of "Tue, 08 Feb 2005 18:48:46 +0100."
	<200502081848.46270.blaisorblade@yahoo.it> 
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<200502081122.22613.blaisorblade@yahoo.it>
	<1107859254.582.4.camel@imp.csi.cam.ac.uk>
	<200502081848.46270.blaisorblade@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 08 Feb 2005 17:21:52 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>

blaisorblade@yahoo.it said:
> the Makefiles were heavily changed, however, recently (after 2.6.10). 

There was a bug in that patch.  The fix is:

Index: 2.6.10/arch/um/Makefile
===================================================================
--- 2.6.10.orig/arch/um/Makefile        2005-02-08 12:33:23.000000000 -0500
+++ 2.6.10/arch/um/Makefile     2005-02-08 12:33:23.000000000 -0500
@@ -36,8 +36,8 @@
 MAKEFILES-INCL += $(foreach mode,$(um-modes-y),\
                   $(srctree)/$(ARCH_DIR)/Makefile-$(mode))
 
-ifneq ($(MAKEFILE-INCL),)
-  include $(MAKEFILE-INCL)
+ifneq ($(MAKEFILES-INCL),)
+  include $(MAKEFILES-INCL)
 endif
 
 ARCH_INCLUDE   := -I$(ARCH_DIR)/include

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
