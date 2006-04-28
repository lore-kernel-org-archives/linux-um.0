Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZWKP-0002fh-9C for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 10:00:25 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FZWKP-0002Kb-2s
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 10:00:25 -0700
Message-Id: <200604281601.k3SG14wD007517@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/6] UML - Fix iomem list traversal
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
Date: Fri, 28 Apr 2006 12:01:04 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, "Victor V. Vengerov" <Victor.Vengerov@oktetlabs.ru>

From: "Victor V. Vengerov" <Victor.Vengerov@oktetlabs.ru>

We need to walk the region list properly.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/physmem.c	2006-04-03 08:48:13.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/physmem.c	2006-04-05 11:16:38.000000000 -0400
@@ -407,6 +407,8 @@ unsigned long find_iomem(char *driver, u
 			*len_out = region->size;
 			return(region->virt);
 		}
+
+		region = region->next;
 	}
 
 	return(0);



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
