Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uhLq-0003Jl-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 16:47:50 -0700
Received: from birosca.ime.usp.br ([143.107.45.59])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19uhLp-0007Rq-7l
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 16:47:49 -0700
From: Livio Baldini Soares <livio@ime.usp.br>
Message-ID: <20030903234212.GA19087@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [PATCH] Undefined __virt_to_page and to_virt symbols
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
Date: Wed, 3 Sep 2003 20:42:12 -0300
To: user-mode-linux-devel@lists.sourceforge.net

  Hey Jeff, and list,

  Today I've  upgraded my UML patch to  2.4.22-1, and when I  tried to load
(as a module) a FS I'm developing, it complained with lack of symbols. 

  Attached trivial patch fixes it for me. Unfortunately, cvs.sf.net is down
so I can't quite trace when these started not working, and why. 

  best regards,

--  
  Livio B. Soares

--- arch/um/kernel/ksyms.c~	Wed Sep  3 16:57:53 2003
+++ arch/um/kernel/ksyms.c	Wed Sep  3 20:03:54 2003
@@ -37,6 +37,8 @@ EXPORT_SYMBOL(arch_validate);
 EXPORT_SYMBOL(high_physmem);
 EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(um_virt_to_phys);
+EXPORT_SYMBOL(__virt_to_page);
+EXPORT_SYMBOL(to_virt);
 EXPORT_SYMBOL(mode_tt);
 EXPORT_SYMBOL(handle_page_fault);
 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
