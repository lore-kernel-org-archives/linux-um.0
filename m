Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhlG5-000773-98 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 05:43:05 -0700
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhlG4-0008MX-Jo
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 05:43:05 -0700
Received: from bramley.cl.cam.ac.uk ([128.232.1.192]:58951)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:587)
	with esmtpsa (PLAIN:ig206) (TLSv1:AES128-SHA:128)
	id 1JhlFz-00069N-V0 (Exim 4.67) for
	user-mode-linux-devel@lists.sourceforge.net
	(return-path <ig206@hermes.cam.ac.uk>); Fri, 04 Apr 2008 13:42:59 +0100
Message-Id: <6302B20C-5D12-4719-A68D-82412A733F5F@hermes.cam.ac.uk>
From: Ian Grant <ig206@hermes.cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 4 Apr 2008 13:42:59 +0100
Subject: [uml-devel] uml_utilities patch for fuse
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
To: user-mode-linux-devel@lists.sourceforge.net

I needed this to build uml_utilities_20070815 with fuse 2.7.0

--- tools-20070815/umlfs/uml_mount.c.orig       2008-04-04  
13:26:14.000000000 +0100
+++ tools-20070815/umlfs/uml_mount.c    2008-04-04 13:26:33.000000000  
+0100
@@ -1,3 +1,4 @@
+#define FUSE_USE_VERSION 25
  #include <fuse/fuse_lowlevel.h>
  #include <stdio.h>
  #include <stdlib.h>
EOT


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
