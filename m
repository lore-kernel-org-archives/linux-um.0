Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFF3n-0001zo-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 07:50:07 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AFF3m-0002K7-OC
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 30 Oct 2003 07:50:06 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20031030160327.GB19575@bytesex.org>
References: <20031030155757.GA19575@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031030155757.GA19575@bytesex.org>
Subject: [uml-devel] [patch] fixmap fix
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
Date: Thu, 30 Oct 2003 17:03:27 +0100
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

This patch just adds a #ifdef for those archs which don't
have FIXADDR_START defined ...

  Gerd

--- linux-2.6.0-test9/mm/memory.c.fix	2003-10-27 15:53:16.000000000 +0100
+++ linux-2.6.0-test9/mm/memory.c	2003-10-27 15:53:46.000000000 +0100
@@ -682,7 +682,7 @@
 	return page;
 }
 
-
+#ifdef FIXADDR_START
 static struct vm_area_struct fixmap_vma = {
 	/* Catch users - if there are any valid
 	   ones, we can make this be "&init_mm" or
@@ -700,6 +700,7 @@
 }
 
 __initcall(init_fixmap_vma);
+#endif
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
