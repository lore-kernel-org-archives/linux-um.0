Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eo1m1-0003uT-VH for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Dec 2005 08:52:37 -0800
Received: from host229-46.pool8259.interbusiness.it ([82.59.46.229]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eo1m1-000495-KE for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Dec 2005 08:52:38 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051218165037.441.85975.stgit@zion.home.lan>
In-Reply-To: <20051218164916.441.69564.stgit@zion.home.lan>
References: <20051218164916.441.69564.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 3/4] uml - fix some funkiness in Kconfig
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
Date: Sun, 18 Dec 2005 17:50:37 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


So you may have seen the miniconfig stuff wander by, which means that my build
script exits if there's a .config error, and we have this:

fs/Kconfig:1749:warning: 'select' used by config symbol 'CIFS_UPCALL' refer to
undefined symbol 'CONNECTOR'

This makes it shut up.

Signed-off-by: Rob Landley <rob@landley.net>

Verified it makes sense.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 563301f..1eb21de 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -289,6 +289,8 @@ source "arch/um/Kconfig.net"
 
 source "drivers/net/Kconfig"
 
+source "drivers/connector/Kconfig"
+
 source "fs/Kconfig"
 
 source "security/Kconfig"



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
