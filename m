Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwT54-0003nm-NT for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 13:30:06 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AwSvT-0004S1-Rj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 13:20:12 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040226212655.GA5191@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] module symbol fix
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
Date: Thu, 26 Feb 2004 22:26:55 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

recent gcc versions need this one ...

  Gerd

--- linux-um-2.6.3/arch/um/kernel/user_syms.c.uml	2004-02-26 21:20:51.202244050 +0100
+++ linux-um-2.6.3/arch/um/kernel/user_syms.c	2004-02-26 21:21:06.599701859 +0100
@@ -57,6 +57,7 @@
 	__attribute__((section("__ksymtab_strings")))		\
 	= MODULE_SYMBOL_PREFIX #sym;                    	\
 	static const struct kernel_symbol __ksymtab_##sym	\
+	__attribute_used__					\
 	__attribute__((section("__ksymtab" sec), unused))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
