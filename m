Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBb8g-0001dx-JP for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 09:17:26 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FBb8e-0003T8-VU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 09:17:26 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060221171630.509.33472.stgit@zion.home.lan>
In-Reply-To: <20060221171535.509.28286.stgit@zion.home.lan>
References: <20060221171535.509.28286.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 5/6] uml: better error reporting for read_output
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
Date: Tue, 21 Feb 2006 18:16:30 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Do precise error handling: print precise error messages, distinguishing short
reads and read errors. This functions fails frequently enough for me so I
bothered doing this fix.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_user.c |   34 ++++++++++++++++++++++------------
 1 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index 098fa65..0e2f061 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -47,10 +47,12 @@ void tap_check_ips(char *gate_addr, unsi
 	}
 }
 
+/* Do reliable error handling as this fails frequently enough. */
 void read_output(int fd, char *output, int len)
 {
-	int remain, n, actual;
+	int remain, ret, expected;
 	char c;
+	char *str;
 
 	if(output == NULL){
 		output = &c;
@@ -58,23 +60,31 @@ void read_output(int fd, char *output, i
 	}
 		
 	*output = '\0';
-	n = os_read_file(fd, &remain, sizeof(remain));
-	if(n != sizeof(remain)){
-		printk("read_output - read of length failed, err = %d\n", -n);
-		return;
+	ret = os_read_file(fd, &remain, sizeof(remain));
+
+	if (ret != sizeof(remain)) {
+		expected = sizeof(remain);
+		str = "length";
+		goto err;
 	}
 
 	while(remain != 0){
-		n = (remain < len) ? remain : len;
-		actual = os_read_file(fd, output, n);
-		if(actual != n){
-			printk("read_output - read of data failed, "
-			       "err = %d\n", -actual);
-			return;
+		expected = (remain < len) ? remain : len;
+		ret = os_read_file(fd, output, expected);
+		if (ret != expected) {
+			str = "data";
+			goto err;
 		}
-		remain -= actual;
+		remain -= ret;
 	}
+
 	return;
+
+err:
+	if (ret < 0)
+		printk("read_output - read of %s failed, errno = %d\n", str, -ret);
+	else
+		printk("read_output - read of %s failed, read only %d of %d bytes\n", str, ret, expected);
 }
 
 int net_read(int fd, void *buf, int len)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
