Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMQn3-0001x2-Fj for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 08:36:57 -0800
Received: from po-out-1718.google.com ([72.14.252.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JMQfT-0002sR-Fj
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 08:29:07 -0800
Received: by po-out-1718.google.com with SMTP id c31so2835050poi.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 05 Feb 2008 08:29:06 -0800 (PST)
Date: Wed, 6 Feb 2008 00:25:57 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20080205162557.GC2966@hacking>
References: <20080203171634.58ab668b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080203171634.58ab668b.akpm@linux-foundation.org>
Subject: [uml-devel] [-mm Patch] arch/um/kernel/initrd.c: fix a missed
	conversion	specifier
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
Cc: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Fix a missed conversion specifier of a printk in
arch/um/kernel/initrd.c.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Jeff Dike <jdike@karaya.com>

---

Index: linux/arch/um/kernel/initrd.c
===================================================================
--- linux.orig/arch/um/kernel/initrd.c
+++ linux/arch/um/kernel/initrd.c
@@ -32,7 +32,7 @@ static int __init read_initrd(void)
 	 * ask for no memory.
 	 */
 	if (size == 0) {
-		printk(KERN_ERR "\"%\" is a zero-size initrd\n");
+		printk(KERN_ERR "\"%s\" is a zero-size initrd\n", initrd);
 		return 0;
 	}
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
