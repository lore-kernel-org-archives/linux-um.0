Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B9Q1D-0007hA-6t for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Apr 2004 06:51:39 -0800
Received: from goliath.nmsrv.com ([69.28.204.18] helo=mail.praize.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B9Q1C-0002It-SL for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Apr 2004 06:51:38 -0800
Message-ID: <20040402145136.19157.qmail@praize.com>
From: "gboutwel" <gboutwel@praize.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
Subject: [uml-devel] Re: [PATCH] patch for linux-2.6.5-rc2
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
Date: 2 Apr 2004 14:51:36 -0000
To: user-mode-linux-devel@lists.sourceforge.net

> did you do a "make mrproper ARCH=um"? ...

>

> ok, after you patch, do this ...

>

> make mrproper ARCH=um

> make menuconfig ARCH=um

> make scripts

> make scripts ARCH=um

> make linux ARCH=um

> strip linux

> make modules ARCH=um



using same patches and same steps as I did for 2.6.4 I was able
to build an SKAS host no problem.  After the following 1 line
patch (which is in Jeffs patch, but the only part of his patch
that I used to get it working), I'm able to compile ans 2.6.5-rc3
(moved up to rc3) uml guest kernel without problems.  Again,
I'm using the same patches and same steps that I used when I
built my 2.6.4 (ie. not needing to make scripts and make scripts
ARCH=um)



--- ./arch/um/Makefile-i386.orig        2004-04-02 09:07:45.000000000
-0600

+++ ./arch/um/Makefile-i386     2004-04-02 09:08:07.000000000
-0600

@@ -30,7 +30,7 @@

 $(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread

        $(call filechk,$@)



-$(SYS_UTIL_DIR)/mk_sc: scripts/fixdep include/config/MARKER
FORCE ;

+$(SYS_UTIL_DIR)/mk_sc: scripts/basic/fixdep include/config/MARKER
FORCE ;

        $(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@



 $(SYS_UTIL_DIR)/mk_thread: $(ARCH_SYMLINKS) $(GEN_HEADERS) sys_prepare
FORCE ;





------------------------------------

Want to talk to other Christians?

Get the Christian Instant Messenger

http://www.praize.com/IM/ 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
