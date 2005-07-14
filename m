Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtC4I-0004f6-RC	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 15:20:34 -0700
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DtC4H-0007i9-5A	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 15:20:34 -0700
Message-Id: <20050714222007.568784000@homer>
From: domen@coderock.org
Content-Disposition: inline; filename=printk-arch_um_
Subject: [uml-devel] [patch 1/1] printk : arch/um/
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
Date: Fri, 15 Jul 2005 00:20:08 +0200
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, Christophe Lucas <clucas@rotomalug.org>, domen@coderock.org

From: Christophe Lucas <clucas@rotomalug.org>


printk() calls should include appropriate KERN_* constant.


Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 drivers/mconsole_kern.c |    2 +-
 kernel/exitcode.c       |    2 +-
 kernel/process_kern.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: quilt/arch/um/drivers/mconsole_kern.c
===================================================================
--- quilt.orig/arch/um/drivers/mconsole_kern.c
+++ quilt/arch/um/drivers/mconsole_kern.c
@@ -557,7 +557,7 @@ static int create_proc_mconsole(void)
 
 	ent = create_proc_entry("mconsole", S_IFREG | 0200, NULL);
 	if(ent == NULL){
-		printk("create_proc_mconsole : create_proc_entry failed\n");
+		printk(KERN_INFO "create_proc_mconsole : create_proc_entry failed\n");
 		return(0);
 	}
 
Index: quilt/arch/um/kernel/exitcode.c
===================================================================
--- quilt.orig/arch/um/kernel/exitcode.c
+++ quilt/arch/um/kernel/exitcode.c
@@ -48,7 +48,7 @@ static int make_proc_exitcode(void)
 
 	ent = create_proc_entry("exitcode", 0600, &proc_root);
 	if(ent == NULL){
-		printk("make_proc_exitcode : Failed to register "
+		printk(KERN_WARNING "make_proc_exitcode : Failed to register "
 		       "/proc/exitcode\n");
 		return(0);
 	}
Index: quilt/arch/um/kernel/process_kern.c
===================================================================
--- quilt.orig/arch/um/kernel/process_kern.c
+++ quilt/arch/um/kernel/process_kern.c
@@ -412,7 +412,7 @@ int __init make_proc_sysemu(void)
 
 	if (ent == NULL)
 	{
-		printk("Failed to register /proc/sysemu\n");
+		printk(KERN_WARNING "Failed to register /proc/sysemu\n");
 		return(0);
 	}
 

--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
