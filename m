Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez1As-0007Kj-NA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:42 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ez1As-0000vE-6o
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:42 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118001923.14622.78817.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 2/9] uml: make daemon transport behave properly
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
Date: Wed, 18 Jan 2006 01:19:25 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Avoid uninitialized data in the daemon_data structure. I used this transport
before doing proper setup before-hand, and I got some very nice SLAB corruption
due to freeing crap pointers. So just make sure to clear everything when
appropriate.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/daemon_kern.c |    4 ++++
 arch/um/drivers/daemon_user.c |    6 ++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/um/drivers/daemon_kern.c b/arch/um/drivers/daemon_kern.c
index 30d285b..507e3cb 100644
--- a/arch/um/drivers/daemon_kern.c
+++ b/arch/um/drivers/daemon_kern.c
@@ -31,6 +31,10 @@ void daemon_init(struct net_device *dev,
 	dpri->fd = -1;
 	dpri->control = -1;
 	dpri->dev = dev;
+	/* We will free this pointer. If it contains crap we're burned. */
+	dpri->ctl_addr = NULL;
+	dpri->data_addr = NULL;
+	dpri->local_addr = NULL;
 
 	printk("daemon backend (uml_switch version %d) - %s:%s", 
 	       SWITCH_VERSION, dpri->sock_type, dpri->ctl_sock);
diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
index 1bb085b..c944265 100644
--- a/arch/um/drivers/daemon_user.c
+++ b/arch/um/drivers/daemon_user.c
@@ -158,10 +158,16 @@ static void daemon_remove(void *data)
 	struct daemon_data *pri = data;
 
 	os_close_file(pri->fd);
+	pri->fd = -1;
 	os_close_file(pri->control);
+	pri->control = -1;
+
 	kfree(pri->data_addr);
+	pri->data_addr = NULL;
 	kfree(pri->ctl_addr);
+	pri->ctl_addr = NULL;
 	kfree(pri->local_addr);
+	pri->local_addr = NULL;
 }
 
 int daemon_user_write(int fd, void *buf, int len, struct daemon_data *pri)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
