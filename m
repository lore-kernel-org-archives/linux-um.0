Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCOQB-0001LB-26 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2005 12:50:15 -0800
Received: from sleepie-adsl.demon.co.uk ([83.104.228.241]
	helo=sleepie.demon.co.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DCOQ8-0000fP-T2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2005 12:50:14 -0800
From: Richard Hirst <rhirst@levanta.com>
Message-ID: <20050318204945.GF8057@levanta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] patch to make serial console work
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
Date: Fri, 18 Mar 2005 20:49:45 +0000
To: user-mode-linux-devel@lists.sourceforge.net

This is against uml-2.4.27-bs1.patch.bz2; serial console didn't work
for me.  This fixed it, and by comparison with serial.c, it looks
correct.  Please cc me on replies.

Richard


--- linux-2.4.27/arch/um/drivers/ssl.c- 2005-03-18 18:30:09.000000000 +0000
+++ linux-2.4.27/arch/um/drivers/ssl.c  2005-03-18 18:30:16.000000000 +0000
@@ -230,7 +230,7 @@
 
 static kdev_t ssl_console_device(struct console *c)
 {
-       return mk_kdev(TTY_MAJOR, c->index);
+       return mk_kdev(TTY_MAJOR, 64 + c->index);
 }
 
 static int ssl_console_setup(struct console *co, char *options)





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
