Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DY7df-0000GI-CM	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 12:21:59 -0700
Received: from dynamic.62-99-255-84.adsl-line.inode.at ([62.99.255.84]
	helo=mercury.foo)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DY7db-0007L8-9t
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 12:21:59 -0700
From: Dominik Hackl <dominik@hackl.dhs.org>
Message-ID: <Pine.LNX.4.61.0505172033050.4083@mercury.foo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] [PATCH] page.h warning fix
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
Date: Tue, 17 May 2005 21:09:45 +0200 (CEST)
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net



This patch removes a warning, caused by a cast of different sized types. 
This patch simply adds a second cast to avoid the warning.

	Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>



--- linux-2.6.12-rc4.orig/include/asm-um/page.h	2005-05-15 09:44:29.000000000 +0200
+++ linux-2.6.12-rc4/include/asm-um/page.h	2005-05-17 19:07:34.000000000 +0200
@@ -98,7 +98,7 @@ extern unsigned long uml_physmem;
 
 extern unsigned long to_phys(void *virt);
 extern void *to_virt(unsigned long phys);
-#define __pa(virt) to_phys((void *) virt)
+#define __pa(virt) to_phys((void *)(unsigned long) virt)
 #define __va(phys) to_virt((unsigned long) phys)
 
 #define page_to_pfn(page) ((page) - mem_map)


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
