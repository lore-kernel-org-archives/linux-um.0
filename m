Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H6wFz-00031h-5C for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jan 2007 13:54:15 -0800
Received: from crown.reflexsecurity.com ([72.54.139.163])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H6wFx-00016E-4A
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jan 2007 13:54:15 -0800
Date: Tue, 16 Jan 2007 16:54:00 -0500
From: Jason Lunz <lunz@falooley.org>
Message-ID: <20070116215400.GK28200@knob.reflex>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] skas3 update for linux 2.6.20-rc5
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


Between 2.6.19 and 2.6.20, an #else clause was added to the
#ifdef !__ASSEMBLY__ in arch/i386/desc.h. This results in the skas3
patch inserting a declaration into the assembly portion of the file.

This is fixed by moving the declaration back into the proper branch of
the #ifdef.

Jason


---
 include/asm-i386/desc.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc5/include/asm-i386/desc.h
===================================================================
--- linux-2.6.20-rc5.orig/include/asm-i386/desc.h
+++ linux-2.6.20-rc5/include/asm-i386/desc.h
@@ -185,6 +185,9 @@
 	return base;
 }
 
+extern int __modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
+		      unsigned long bytecount);
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -208,9 +211,6 @@
 	shll $16, base; \
 	movw idx*8+2(gdt), lo_w;
 
-extern int __modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
-		      unsigned long bytecount);
-
 #endif /* !__ASSEMBLY__ */
 
 #endif

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
