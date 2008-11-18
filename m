Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1L2Ubl-0002g9-J5
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Nov 2008 17:43:25 +0000
Received: from yw-out-1718.google.com ([74.125.46.155])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L2Ubh-0001AE-FZ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Nov 2008 17:43:25 +0000
Received: by yw-out-1718.google.com with SMTP id 6so1245105ywa.82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 18 Nov 2008 09:43:20 -0800 (PST)
Date: Tue, 18 Nov 2008 17:42:51 +0000
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20081118174250.GE3185@hack.voiplan.pt>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [Patch] uml: fix undeclared variables
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net


Fix three compile errors about undeclared variables in
arch/um/kernel/mem.c.

Signed-off-by: WANG Cong <wangcong@zeuux.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>


---
diff --git a/arch/um/include/asm/fixmap.h b/arch/um/include/asm/fixmap.h
index 69c0252..0af143d 100644
--- a/arch/um/include/asm/fixmap.h
+++ b/arch/um/include/asm/fixmap.h
@@ -41,6 +41,9 @@ enum fixed_addresses {
 	__end_of_fixed_addresses
 };
 
+extern pte_t *pkmap_page_table;
+extern pte_t *kmap_pte;
+extern pgprot_t kmap_prot;
 extern void __set_fixmap (enum fixed_addresses idx,
 			  unsigned long phys, pgprot_t flags);
 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
