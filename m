Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dhowells@redhat.com>) id 1TNkRX-0000p7-Mf
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Oct 2012 13:10:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TNkRW-0001Ks-NS for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Oct 2012 13:10:51 +0000
From: David Howells <dhowells@redhat.com>
Date: Mon, 15 Oct 2012 14:10:34 +0100
Message-ID: <20121015131034.8834.52811.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
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
Subject: [uml-devel] [PATCH] UM: linux/coredump.h needs siginfo_t
To: jdike@addtoit.com, richard@nod.at
Cc: dhowells@redhat.com, rdunlap@xenotime.net, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

linux/coredump.h should #include asm/siginfo.h for the siginfo_t type.

Without this the following error occurs when compiling UM defconfig:

	include/linux/coredump.h:15:25: error: unknown type name 'siginfo_t'

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/coredump.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 1775eb8..1d73993 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -4,6 +4,7 @@
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <asm/siginfo.h>
 
 /*
  * These are the only things you should do on a core-file: use only these


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

