Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhnpU-0005EX-Bb for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jul 2004 04:09:40 -0700
Received: from gort.metaparadigm.com ([203.117.131.12])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BhnpT-0000mw-T5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jul 2004 04:09:40 -0700
Received: from localhost (unknown [127.0.0.1])
	by gort.metaparadigm.com (Postfix) with ESMTP id 594721B269
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  6 Jul 2004 19:09:29 +0800 (SGT)
Received: from gort.metaparadigm.com ([127.0.0.1])
	by localhost (gort [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18788-06 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  6 Jul 2004 19:09:28 +0800 (SGT)
Received: from [192.168.133.2] (unknown [192.168.133.2])
	by gort.metaparadigm.com (Postfix) with ESMTP id 63D061B255
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  6 Jul 2004 19:09:28 +0800 (SGT)
Message-ID: <40EA8869.8050602@metaparadigm.com>
From: Michael Clark <michael@metaparadigm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060100060401010700050006"
Subject: [uml-devel] [PATCH] make port channel use setsockopt SO_REUSEADDR
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
Date: Tue, 06 Jul 2004 19:09:29 +0800
To: UML Devel <user-mode-linux-devel@lists.sourceforge.net>


This is a multi-part message in MIME format.
--------------060100060401010700050006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Small patch to make port channels allow reuse of local addresses.
Useful in the case where you restart a UML from a script and you
don't want to have to allocate a new port number each time.

~mc

--------------060100060401010700050006
Content-Type: text/x-patch;
 name="uml-port-reuseaddr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml-port-reuseaddr.patch"

--- linux-2.6.7-uml/arch/um/drivers/port_user.c.orig	2004-07-06 18:48:45.000000000 +0800
+++ linux-2.6.7-uml/arch/um/drivers/port_user.c	2004-07-06 18:51:11.000000000 +0800
@@ -118,12 +118,16 @@
 int port_listen_fd(int port)
 {
 	struct sockaddr_in addr;
-	int fd, err;
+	int fd, err, arg;
 
 	fd = socket(PF_INET, SOCK_STREAM, 0);
 	if(fd == -1) 
 		return(-errno);
 
+	arg = 1;
+	if(setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &arg, sizeof(arg)) < 0)
+		return(-errno);
+
 	addr.sin_family = AF_INET;
 	addr.sin_port = htons(port);
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);

--------------060100060401010700050006--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
