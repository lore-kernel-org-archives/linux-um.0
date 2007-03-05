Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOKG6-0006qv-7C for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:28 -0800
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOKG5-0000Km-KH
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:14 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Mon, 05 Mar 2007 21:49:10 +0100
Message-Id: <20070305204910.9072.38235.stgit@americanbeauty.home.lan>
In-Reply-To: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
References: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 11/11] uml: fix errno usage
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Avoid reusing userspace errno twice - it can be cleared by libc code everywhere
(in particular printk() does clear it in my setup).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/daemon_user.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
index 310af0f..021b82c 100644
--- a/arch/um/drivers/daemon_user.c
+++ b/arch/um/drivers/daemon_user.c
@@ -56,30 +56,31 @@ static int connect_to_switch(struct daemon_data *pri)
 
 	pri->control = socket(AF_UNIX, SOCK_STREAM, 0);
 	if(pri->control < 0){
+		err = -errno;
 		printk("daemon_open : control socket failed, errno = %d\n", 
-		       errno);		
-		return(-errno);
+		       -err);
+		return err;
 	}
 
 	if(connect(pri->control, (struct sockaddr *) ctl_addr, 
 		   sizeof(*ctl_addr)) < 0){
-		printk("daemon_open : control connect failed, errno = %d\n",
-		       errno);
 		err = -errno;
+		printk("daemon_open : control connect failed, errno = %d\n",
+		       -err);
 		goto out;
 	}
 
 	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
 	if(fd < 0){
-		printk("daemon_open : data socket failed, errno = %d\n", 
-		       errno);
 		err = -errno;
+		printk("daemon_open : data socket failed, errno = %d\n",
+		       -err);
 		goto out;
 	}
 	if(bind(fd, (struct sockaddr *) local_addr, sizeof(*local_addr)) < 0){
-		printk("daemon_open : data bind failed, errno = %d\n", 
-		       errno);
 		err = -errno;
+		printk("daemon_open : data bind failed, errno = %d\n",
+		       -err);
 		goto out_close;
 	}
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
