Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhjlG-0002Nw-UJ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 04:07:11 -0700
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhjlF-0005Pf-DK
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 04:07:10 -0700
Received: from bramley.cl.cam.ac.uk ([128.232.1.192]:58701)
	by ppsw-5.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.155]:587)
	with esmtpsa (PLAIN:ig206) (TLSv1:AES128-SHA:128)
	id 1Jhjl6-0002TM-JD (Exim 4.67) for
	user-mode-linux-devel@lists.sourceforge.net
	(return-path <ig206@hermes.cam.ac.uk>); Fri, 04 Apr 2008 12:07:00 +0100
Message-Id: <55D2E517-4637-4FF9-A3E4-1FF4770DEE08@hermes.cam.ac.uk>
From: Ian Grant <ig206@hermes.cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 4 Apr 2008 12:07:00 +0100
Subject: [uml-devel] Makefile patch
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
To: user-mode-linux-devel@lists.sourceforge.net

 From at least 2006 the Makefile in arch/um uses $(shell cd ...) but  
the cd command outputs to stdout if CDPATH is in effect and this  
causes the Makefile to break with *** missing separator.

One fix is to suppress the stdout of the cd command. Another is to  
assign the result e.g.: JUNK := $(shell cd ... )

I think CDPATH is silly.

--- /usr/src/linux-2.6.22.17-0.1/arch/um/Makefile.orig  2008-04-04  
11:59:35.0000
00000 +0100
+++ /usr/src/linux-2.6.22.17-0.1/arch/um/Makefile       2008-04-04  
12:00:08.0000
00000 +0100
@@ -110,7 +110,7 @@
  ifneq ($(KBUILD_SRC),)
  $(shell mkdir -p $(ARCH_DIR) && ln -fsn $(srctree)/$(ARCH_DIR)/ 
Kconfig.$(SUBARC
H) $(ARCH_DIR)/Kconfig.arch)
  else
-$(shell cd $(ARCH_DIR) && ln -sf Kconfig.$(SUBARCH) Kconfig.arch)
+$(shell cd $(ARCH_DIR) > /dev/null && ln -sf Kconfig.$(SUBARCH)  
Kconfig.arch)
  endif

  archprepare: $(ARCH_SYMLINKS) $(ARCH_DIR)/include/user_constants.h


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
