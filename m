Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDpHe-0002ZJ-TM for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 11:43:22 -0800
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DDpHK-0005qC-SU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 11:43:22 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050322162126.B232197666@zion>
Subject: [uml-devel] [patch 04/12] uml: cope with uml_net security fix
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
Date: Tue, 22 Mar 2005 17:21:26 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Pass the interface to close as an fd besides that by name... passing it by
name does not work with newer uml_net because that allows to ifconfig down
arbitrary interfaces, while if you have an open fd to the SLIP interface it
means you have full access to it (and thus can close it). Passing only by fd
does not work with older utilities, so we do both things (which does not
hurt).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/slip_user.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN arch/um/drivers/slip_user.c~uml-uml_net-security-fix arch/um/drivers/slip_user.c
--- linux-2.6.11/arch/um/drivers/slip_user.c~uml-uml_net-security-fix	2005-03-21 15:25:41.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/slip_user.c	2005-03-21 15:25:41.000000000 +0100
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
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
