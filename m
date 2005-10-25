Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUWvD-0004i1-4a	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:05:31 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EUWvA-0003t9-BX
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:05:31 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051025220157.20010.82762.stgit@zion.home.lan>
In-Reply-To: <20051025220053.20010.56979.stgit@zion.home.lan>
References: <20051025220053.20010.56979.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 07/11] uml: fix mcast network driver error
	handling
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
Date: Wed, 26 Oct 2005 00:01:57 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

printk clears the host errno (I verified this in debugging and it's reasonable
enough, given that it ends via a write call on some fd, especially since
printk() goes on /dev/tty0 which is often the host stdout).
So save errno earlier. There's no reason to change the printk calls to use -err
rather than errno - the assignment can't clear errno.

And in the first failure path, we used to return 0 too (and this time more
clearly), which is totally wrong. 0 is a success fd, which is then registered
and gives a "registering fd twice" warning.

Finally, fix up some whitespace.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/mcast_user.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/mcast_user.c b/arch/um/drivers/mcast_user.c
--- a/arch/um/drivers/mcast_user.c
+++ b/arch/um/drivers/mcast_user.c
@@ -54,7 +54,7 @@ static int mcast_open(void *data)
 	struct mcast_data *pri = data;
 	struct sockaddr_in *sin = pri->mcast_addr;
 	struct ip_mreq mreq;
-	int fd, yes = 1, err = 0;
+	int fd, yes = 1, err = -EINVAL;
 
 
 	if ((sin->sin_addr.s_addr == 0) || (sin->sin_port == 0))
@@ -63,40 +63,40 @@ static int mcast_open(void *data)
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
 
 	if (fd < 0){
+		err = -errno;
 		printk("mcast_open : data socket failed, errno = %d\n", 
 		       errno);
-		err = -errno;
 		goto out;
 	}
 
 	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0) {
+		err = -errno;
 		printk("mcast_open: SO_REUSEADDR failed, errno = %d\n",
 			errno);
-		err = -errno;
 		goto out_close;
 	}
 
 	/* set ttl according to config */
 	if (setsockopt(fd, SOL_IP, IP_MULTICAST_TTL, &pri->ttl,
 		       sizeof(pri->ttl)) < 0) {
+		err = -errno;
 		printk("mcast_open: IP_MULTICAST_TTL failed, error = %d\n",
 			errno);
-		err = -errno;
 		goto out_close;
 	}
 
 	/* set LOOP, so data does get fed back to local sockets */
 	if (setsockopt(fd, SOL_IP, IP_MULTICAST_LOOP, &yes, sizeof(yes)) < 0) {
+		err = -errno;
 		printk("mcast_open: IP_MULTICAST_LOOP failed, error = %d\n",
 			errno);
-		err = -errno;
 		goto out_close;
 	}
 
 	/* bind socket to mcast address */
 	if (bind(fd, (struct sockaddr *) sin, sizeof(*sin)) < 0) {
-		printk("mcast_open : data bind failed, errno = %d\n", errno);
 		err = -errno;
+		printk("mcast_open : data bind failed, errno = %d\n", errno);
 		goto out_close;
 	}		
 	
@@ -105,22 +105,22 @@ static int mcast_open(void *data)
 	mreq.imr_interface.s_addr = 0;
 	if (setsockopt(fd, SOL_IP, IP_ADD_MEMBERSHIP, 
 		       &mreq, sizeof(mreq)) < 0) {
+		err = -errno;
 		printk("mcast_open: IP_ADD_MEMBERSHIP failed, error = %d\n",
 			errno);
 		printk("There appears not to be a multicast-capable network "
 		       "interface on the host.\n");
 		printk("eth0 should be configured in order to use the "
 		       "multicast transport.\n");
-		err = -errno;
-                goto out_close;
+		goto out_close;
 	}
 
 	return fd;
 
  out_close:
-        os_close_file(fd);
+	os_close_file(fd);
  out:
-        return err;
+	return err;
 }
 
 static void mcast_close(int fd, void *data)



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
