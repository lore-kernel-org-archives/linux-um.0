Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <401AC241.1080205@darkman.de>
From: "Sven 'Darkman' Michels" <sven@darkman.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000302000505050700060507"
Subject: [uml-devel] [PATCH] mconsole log doesn't work correctly
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
Date: Fri, 30 Jan 2004 21:44:49 +0100
To: UML devel list <user-mode-linux-devel@lists.sourceforge.net>
Cc: user-mode-linux-user@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------000302000505050700060507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

a small patch for the mconsole_log function:
just add an \n at the end of every line cause otherwise sys/klogd
won't notice the line (at least not immedially).

Regards,
Sven

--------------000302000505050700060507
Content-Type: text/plain;
 name="mconsole_log.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mconsole_log.patch"

--- linux-2.4.24-2.4.23-2um/arch/um/drivers/mconsole_kern.c	2004-01-25 12:34:58.000000000 +0100
+++ linux-2.4.24-2.4.23-2um-latest/arch/um/drivers/mconsole_kern.c	2004-01-30 21:07:42.000000000 +0100
@@ -116,7 +116,7 @@ void mconsole_log(struct mc_request *req
 	while(isspace(*ptr)) ptr++;
 
 	len = req->len - (ptr - req->request.data);
-	printk("%.*s", len, ptr);
+	printk("%.*s\n", len, ptr);
 	mconsole_reply(req, "", 0, 0);
 }
 

--------------000302000505050700060507--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
