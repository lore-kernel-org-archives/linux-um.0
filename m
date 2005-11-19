Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdGKr-0000tG-4x for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 16:12:05 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EdGKp-0000LT-JA
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 16:12:05 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jAJ1k00S021690
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 18 Nov 2005 20:46:01 -0500
From: Rob Landley <rob@landley.net>
References: <200511121936.41697.rob@landley.net>
	<200511180136.30434.rob@landley.net>
	<200511180858.02124.blaisorblade@yahoo.it>
In-Reply-To: <200511180858.02124.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511181811.51188.rob@landley.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [PATCH] UML x86-64 build fix.
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
Date: Fri, 18 Nov 2005 18:11:51 -0600
To: 
Cc: user-mode-linux-devel@lists.sourceforge.net

Signed-off-by: Rob Landley <rob@landley.net>

The current UML build assumes that on x86-64 systems, /lib is a symlink 
to /lib64, but in some distributions (like PLD and CentOS) they are separate 
directories, so the 64 bit library loader isn't found.  This patch 
inserts /lib64 at the start of the rpath on x86-64 UML builds.
---

--- linux-2.6.14/arch/um/Makefile-x86_64 2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc1/arch/um/Makefile-x86_64 2005-11-18 09:55:39.984601688 
+0100
@@ -12,3 +12,5 @@
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
+
+LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64

Rob



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
