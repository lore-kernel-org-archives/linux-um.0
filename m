Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAnmU-0003KS-C0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 03:30:42 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DAnmS-0002eA-Io for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 03:30:42 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050311192948.5C65F9764E@zion>
Subject: [uml-devel] [patch 2/2] (undescribed patch)
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
Date: Fri, 11 Mar 2005 20:29:48 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/slip_user.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN arch/um/drivers/slip_user.c~uml-uml_net-security-fix arch/um/drivers/slip_user.c
--- linux-2.6.11/arch/um/drivers/slip_user.c~uml-uml_net-security-fix	2005-03-09 12:44:10.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/slip_user.c	2005-03-09 12:44:10.000000000 +0100
@@ -108,6 +108,9 @@ static int slip_tramp(char **argv, int f
 			err = -EINVAL;
 		}
 	}
+
+	os_close_file(fds[0]);
+
 	return(err);
 }
 
@@ -128,6 +131,7 @@ static int slip_open(void *data)
 	sfd = os_open_file(ptsname(mfd), of_rdwr(OPENFLAGS()), 0);
 	if(sfd < 0){
 		printk("Couldn't open tty for slip line, err = %d\n", -sfd);
+		os_close_file(mfd);
 		return(sfd);
 	}
 	if(set_up_tty(sfd)) return(-1);
@@ -175,7 +179,7 @@ static void slip_close(int fd, void *dat
 
 	sprintf(version_buf, "%d", UML_NET_VERSION);
 
-	err = slip_tramp(argv, -1);
+	err = slip_tramp(argv, pri->slave);
 
 	if(err != 0)
 		printk("slip_tramp failed - errno = %d\n", -err);
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
