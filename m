Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hix2z-0000x5-K7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 May 2007 11:25:57 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hix2y-0008Ec-3Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 May 2007 11:25:57 -0700
Date: Tue, 1 May 2007 14:21:59 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070501182159.GA8368@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH /6] UML - pcap devices should get MACs from
	command line
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Allow a pcap device to be assigned a MAC on the command line.  They
don't really need one, but it is handy to be able to do when your
distro assigns a new ethernet device whenever it sees a new MAC.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/pcap_kern.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.21-mm/arch/um/drivers/pcap_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/pcap_kern.c	2007-04-27 16:15:41.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/pcap_kern.c	2007-04-27 16:15:57.000000000 -0400
@@ -70,7 +70,7 @@ int pcap_setup(char *str, char **mac_out
 		  .filter 	= NULL });
 
 	remain = split_if_spec(str, &host_if, &init->filter,
-			       &options[0], &options[1], NULL);
+			       &options[0], &options[1], mac_out, NULL);
 	if(remain != NULL){
 		printk(KERN_ERR "pcap_setup - Extra garbage on "
 		       "specification : '%s'\n", remain);

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
