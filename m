Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfCEB-0001W4-SF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 01:17:44 -0800
Received: from gw-e.panasas.com ([65.194.124.178] helo=cassoulet.panasas.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GfCEA-0001Tv-7Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 01:17:43 -0800
Received: from riverside.int.panasas.com (localhost.localdomain [127.0.0.1])
	by cassoulet.panasas.com (8.12.10/8.12.10) with ESMTP id kA19HeaT005812
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 1 Nov 2006 04:17:40 -0500
Message-ID: <45486636.3020808@panasas.com>
Date: Wed, 01 Nov 2006 11:17:42 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
Subject: [uml-devel] UML and SCSI
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
To: user-mode-linux-devel@lists.sourceforge.net

I have searched the archives and seen some old posts about SCSI not 
compiling with UML. Since than I have seen some post on the net of the 
like http://lkml.org/lkml/2006/9/12/200. (which does not apply but the 
Idea is clear and can be done by hand).
Now when carefully configured I can compile the SCSI and iSCSI layers.

[Q] I have worked on below patch but now SCSI is on by default. (As in 
the regular kernel). Is there a way to include the original Kconfig from 
drivers/scsi but override it's defaultness?

[Q2] Are there more deeper implication than meet the eye, why SCSI-iSCSI 
cannot run in a UML? It might have good performance 2.

<um_2.6.19-rc1_Kconfig.patch>

diff -Nup /tmp/tmp.19763.0 
/home/bharrosh/p4.local/pub/linux-2.6.19-rc1/arch/um/Kconfig -L 
a/arch/um/Kconfig -L b/arch/um/Kconfig
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -285,21 +285,7 @@ source "crypto/Kconfig"

 source "lib/Kconfig"

-menu "SCSI support"
-depends on BROKEN
-
-config SCSI
-       tristate "SCSI support"
-
-# This gives us free_dma, which scsi.c wants.
-config GENERIC_ISA_DMA
-       bool
-       depends on SCSI
-       default y
-
-source "arch/um/Kconfig.scsi"
-
-endmenu
+source "drivers/scsi/Kconfig"

 source "drivers/md/Kconfig"

</um_2.6.19-rc1_Kconfig.patch>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
