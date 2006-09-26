Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GSH8X-0006h4-2t for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Sep 2006 10:54:29 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GSH8W-0001Sw-Ja
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Sep 2006 10:54:29 -0700
Message-Id: <200609261753.k8QHrPth005550@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 26 Sep 2006 13:53:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/5] UML - fix allocation size
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Fix an instance of ptr=alloc(sizeof(ptr)).  Grepping showed no more instances
of this pattern.

Also fixed the formatting in the area.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2006-09-22 10:17:11.000000000 -0400
@@ -560,12 +560,13 @@ static int eth_setup(char *str)
 	int n, err;
 
 	err = eth_parse(str, &n, &str);
-	if(err) return(1);
+	if(err)
+		return 1;
 
-	new = alloc_bootmem(sizeof(new));
+	new = alloc_bootmem(sizeof(*new));
 	if (new == NULL){
 		printk("eth_init : alloc_bootmem failed\n");
-		return(1);
+		return 1;
 	}
 
 	INIT_LIST_HEAD(&new->list);
@@ -573,7 +574,7 @@ static int eth_setup(char *str)
 	new->init = str;
 
 	list_add_tail(&new->list, &eth_cmd_line);
-	return(1);
+	return 1;
 }
 
 __setup("eth", eth_setup);


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
