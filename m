Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFFLC-0005Ik-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 08:08:06 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AFFLC-0003ex-AW
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 30 Oct 2003 08:08:06 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20031030162036.GD19575@bytesex.org>
References: <20031030155757.GA19575@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031030155757.GA19575@bytesex.org>
Subject: [uml-devel] [patch] kernel cmd line parser fix
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 30 Oct 2003 17:20:36 +0100
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

This patch passes up the line_setup return value.  That makes
the kernel try the next __setup() handler in case line_setup
didn't manage to parse the argument, which is especially
important for the "console=ttyS0" argument (which is simply
ignored without this patch).

  Gerd

--- 2.6.0-test9/arch/um/drivers/stdio_console.c.arg	2003-10-30 15:02:53.000000000 +0100
+++ 2.6.0-test9/arch/um/drivers/stdio_console.c	2003-10-30 15:03:30.000000000 +0100
@@ -230,7 +230,8 @@
 
 static int console_chan_setup(char *str)
 {
-	line_setup(vts, sizeof(vts)/sizeof(vts[0]), str, 1);
+	if (0 != line_setup(vts, sizeof(vts)/sizeof(vts[0]), str, 1))
+		return 0;
 	return(1);
 }
 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
