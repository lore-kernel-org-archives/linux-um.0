Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMQo8-0002Or-8w for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 08:38:04 -0800
Received: from qb-out-0506.google.com ([72.14.204.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JMQZr-00089g-N9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 08:23:19 -0800
Received: by qb-out-0506.google.com with SMTP id c8so3387871qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 05 Feb 2008 08:23:18 -0800 (PST)
Date: Wed, 6 Feb 2008 00:20:09 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20080205162009.GB2966@hacking>
References: <20080203171634.58ab668b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080203171634.58ab668b.akpm@linux-foundation.org>
Subject: [uml-devel] [-mm Patch] arch/um/kernel/mem.c: fix a shadowed variable
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Dike <jdike@linux.intel.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Fix a shadowed variable in arch/um/kernel/mem.c,
since there is a global variable has the same name.

Cc: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---

Index: linux/arch/um/kernel/mem.c
===================================================================
--- linux.orig/arch/um/kernel/mem.c
+++ linux/arch/um/kernel/mem.c
@@ -299,7 +299,7 @@ void show_mem(void)
 {
 	int pfn, total = 0, reserved = 0;
 	int shared = 0, cached = 0;
-	int highmem = 0;
+	int high_mem = 0;
 	struct page *page;
 
 	printk(KERN_INFO "Mem-info:\n");
@@ -311,7 +311,7 @@ void show_mem(void)
 		page = pfn_to_page(pfn);
 		total++;
 		if (PageHighMem(page))
-			highmem++;
+			high_mem++;
 		if (PageReserved(page))
 			reserved++;
 		else if (PageSwapCache(page))
@@ -320,7 +320,7 @@ void show_mem(void)
 			shared += page_count(page) - 1;
 	}
 	printk(KERN_INFO "%d pages of RAM\n", total);
-	printk(KERN_INFO "%d pages of HIGHMEM\n", highmem);
+	printk(KERN_INFO "%d pages of HIGHMEM\n", high_mem);
 	printk(KERN_INFO "%d reserved pages\n", reserved);
 	printk(KERN_INFO "%d pages shared\n", shared);
 	printk(KERN_INFO "%d pages swap cached\n", cached);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
