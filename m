Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBb8b-0001dI-4S for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 09:17:21 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FBb8Z-00079g-EP
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 09:17:21 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060221171627.509.95340.stgit@zion.home.lan>
In-Reply-To: <20060221171535.509.28286.stgit@zion.home.lan>
References: <20060221171535.509.28286.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 4/6] uml: os_connect_socket error path fixup
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
Date: Tue, 21 Feb 2006 18:16:27 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Fix an fd leak and a return of -1 instead of -errno in the error path - this
showed up in intensive testing of HPPFS, the os_connect_socket user.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/file.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index f55773c..3bd10de 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -272,14 +272,23 @@ int os_connect_socket(char *name)
 	snprintf(sock.sun_path, sizeof(sock.sun_path), "%s", name);
 
 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
-	if(fd < 0)
-		return(fd);
+	if(fd < 0) {
+		err = -errno;
+		goto out;
+	}
 
 	err = connect(fd, (struct sockaddr *) &sock, sizeof(sock));
-	if(err)
-		return(-errno);
+	if(err) {
+		err = -errno;
+		goto out_close;
+	}
 
-	return(fd);
+	return fd;
+
+out_close:
+	close(fd);
+out:
+	return err;
 }
 
 void os_close_file(int fd)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
