Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gnomes@lxorguk.ukuu.org.uk>) id 1XMfQ5-00056T-MC
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2014 15:45:57 +0000
Received: from cpc5-cwma8-2-0-cust185.7-3.cable.virginm.net ([82.17.37.186]
	helo=alan.etchedpixels.co.uk)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XMfQ3-0000x5-Ls
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2014 15:45:57 +0000
From: Alan <gnomes@lxorguk.ukuu.org.uk>
Date: Wed, 27 Aug 2014 16:28:59 +0100
Message-ID: <20140827152832.7767.53131.stgit@alan.etchedpixels.co.uk>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] um,ethertap: use strncpy
To: richard@nod.at, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

I can't prove the case pointed out in
https://bugzilla.kernel.org/show_bug.cgi?id=82341
is correct so let us play safe.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 arch/um/os-Linux/drivers/ethertap_user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
index b39b669..6d49182 100644
--- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ b/arch/um/os-Linux/drivers/ethertap_user.c
@@ -105,7 +105,7 @@ static int etap_tramp(char *dev, char *gate, int control_me,
 	sprintf(data_fd_buf, "%d", data_remote);
 	sprintf(version_buf, "%d", UML_NET_VERSION);
 	if (gate != NULL) {
-		strcpy(gate_buf, gate);
+		strncpy(gate_buf, gate, 15);
 		args = setup_args;
 	}
 	else args = nosetup_args;


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

