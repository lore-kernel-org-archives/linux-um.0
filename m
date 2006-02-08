Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6iuh-0008To-Hc for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2006 22:34:51 -0800
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1F6iug-00046M-6X
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2006 22:34:51 -0800
Message-ID: <43E99128.6090202@jp.fujitsu.com>
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [PATCH] unify pfn_to_page take 2 [23/25] uml funcs
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
Date: Wed, 08 Feb 2006 15:35:20 +0900
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

UML can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-um/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-um/page.h
+++ test-layout-free-zone/include/asm-um/page.h
@@ -106,9 +106,6 @@ extern unsigned long uml_physmem;
  #define __pa(virt) to_phys((void *) (unsigned long) (virt))
  #define __va(phys) to_virt((unsigned long) (phys))

-#define page_to_pfn(page) ((page) - mem_map)
-#define pfn_to_page(pfn) (mem_map + (pfn))
-
  #define phys_to_pfn(p) ((p) >> PAGE_SHIFT)
  #define pfn_to_phys(pfn) ((pfn) << PAGE_SHIFT)




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
