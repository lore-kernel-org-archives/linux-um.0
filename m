Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKb6l-0004Xy-3r for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 04:27:51 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CKb6j-00037i-C2 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 04:27:51 -0700
Message-ID: <41779E6A.8030706@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Error in incremental patch link-x86-64
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
Date: Thu, 21 Oct 2004 13:32:58 +0200
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

With this patch installed, UML no longer boots in TT-mode:

   Checking PROT_EXEC mmap in /tmp...OK
   Mapping memory: Invalid argument

Applied a patch, that fixes it.

Bodo

---

--- a/arch/um/Kconfig_i386	2004-10-21 13:01:34.972662948 +0200
+++ b/arch/um/Kconfig_i386	2004-10-21 13:01:49.597246150 +0200
@@ -4,5 +4,5 @@

  config TOP_ADDR
  	hex
-	default 0xc0000000 if HOST_2G_2G
-	default 0x80000000 if !HOST_2G_2G
+	default 0xc0000000 if !HOST_2G_2G
+	default 0x80000000 if HOST_2G_2G


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
