Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EX2zx-00060f-Ak for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Nov 2005 12:44:49 -0800
Received: from host175-37.pool8253.interbusiness.it ([82.53.37.175]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EX2zw-0004yU-TJ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Nov 2005 12:44:49 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051101204846.27258.64264.stgit@zion.home.lan>
In-Reply-To: <20051101204836.27258.46611.stgit@zion.home.lan>
References: <20051101204836.27258.46611.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 2/2] uml: add missing header
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
Date: Tue, 01 Nov 2005 21:48:47 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We now need to include the new <linux/platform_device.h> explicitly, due to
headers changes.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/net_kern.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/include/net_kern.h b/arch/um/include/net_kern.h
--- a/arch/um/include/net_kern.h
+++ b/arch/um/include/net_kern.h
@@ -10,6 +10,7 @@
 #include "linux/skbuff.h"
 #include "linux/socket.h"
 #include "linux/list.h"
+#include "linux/platform_device.h"
 
 struct uml_net {
 	struct list_head list;



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
