Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzNDG-0000yQ-26 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:59:38 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EzNDF-0002Yp-EB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:59:38 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118235503.4626.71474.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 3/8] uml: fix hugest stack users
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
Date: Thu, 19 Jan 2006 00:55:04 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


The C99 initialization, with GCC's bad handling, for 6K wide structs (which
_aren't_ on the stack), is causing GCC to use 12K for these silly procs with 3
vars. Workaround this.

Note that .name = { '\0' } translates to memset(->name, 0, '->name' size) - I verified
this with GCC's docs and a testprogram.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/slip_common.h |   13 +++++++------
 arch/um/drivers/slip_kern.c   |   15 ++++++++-------
 arch/um/drivers/slirp_kern.c  |   13 +++++++------
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/um/drivers/slip_common.h b/arch/um/drivers/slip_common.h
index 2ae76d8..d574e0a 100644
--- a/arch/um/drivers/slip_common.h
+++ b/arch/um/drivers/slip_common.h
@@ -88,12 +88,13 @@ struct slip_proto {
 	int esc;
 };
 
-#define SLIP_PROTO_INIT { \
-	.ibuf  	= { '\0' }, \
-	.obuf  	= { '\0' }, \
-        .more	= 0, \
-	.pos	= 0, \
-	.esc	= 0 \
+static inline void slip_proto_init(struct slip_proto * slip)
+{
+	memset(slip->ibuf, 0, sizeof(slip->ibuf));
+	memset(slip->obuf, 0, sizeof(slip->obuf));
+	slip->more = 0;
+	slip->pos = 0;
+	slip->esc = 0;
 }
 
 extern int slip_proto_read(int fd, void *buf, int len,
diff --git a/arch/um/drivers/slip_kern.c b/arch/um/drivers/slip_kern.c
index 9a6f5c8..a62f5ef 100644
--- a/arch/um/drivers/slip_kern.c
+++ b/arch/um/drivers/slip_kern.c
@@ -21,13 +21,14 @@ void slip_init(struct net_device *dev, v
 
 	private = dev->priv;
 	spri = (struct slip_data *) private->user;
-	*spri = ((struct slip_data)
-		{ .name 	= { '\0' },
-		  .addr		= NULL,
-		  .gate_addr 	= init->gate_addr,
-		  .slave  	= -1,
-		  .slip		= SLIP_PROTO_INIT,
-		  .dev 		= dev });
+
+	memset(spri->name, 0, sizeof(spri->name));
+	spri->addr = NULL;
+	spri->gate_addr = init->gate_addr;
+	spri->slave = -1;
+	spri->dev = dev;
+
+	slip_proto_init(&spri->slip);
 
 	dev->init = NULL;
 	dev->header_cache_update = NULL;
diff --git a/arch/um/drivers/slirp_kern.c b/arch/um/drivers/slirp_kern.c
index 9864d27..33d7982 100644
--- a/arch/um/drivers/slirp_kern.c
+++ b/arch/um/drivers/slirp_kern.c
@@ -21,12 +21,13 @@ void slirp_init(struct net_device *dev, 
 
 	private = dev->priv;
 	spri = (struct slirp_data *) private->user;
-	*spri = ((struct slirp_data)
-		{ .argw 	= init->argw,
-		  .pid  	= -1,
-		  .slave  	= -1,
-		  .slip		= SLIP_PROTO_INIT,
-		  .dev 		= dev });
+
+	spri->argw = init->argw;
+	spri->pid = -1;
+	spri->slave = -1;
+	spri->dev = dev;
+
+	slip_proto_init(&spri->slip);
 
 	dev->init = NULL;
 	dev->hard_header_len = 0;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
