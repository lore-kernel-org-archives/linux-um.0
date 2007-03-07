Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOysb-0005Wp-CB for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Mar 2007 08:20:42 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOysY-0008UE-ME
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Mar 2007 08:20:41 -0800
Date: Wed, 7 Mar 2007 11:11:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070307161139.GA3345@ccure.user-mode-linux.org>
References: <200703061832.l26IWBKi006564@ccure.user-mode-linux.org>
	<200703062007.16943.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200703062007.16943.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 4/5] UML - driver formatting fixes
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
To: Blaisorblade <blaisorblade@yahoo.it>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Mar 06, 2007 at 08:07:16PM +0100, Blaisorblade wrote:
> The second line should better say -err instead of err.

Right, patch below.

				Jeff

-- 
Work email - jdike at linux dot intel dot com


My last formatting patch got the sign of an error wrong in a printk.

Thanks to Blaisorblade for the close look.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/chan_user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: test/arch/um/drivers/chan_user.c
===================================================================
--- test.orig/arch/um/drivers/chan_user.c	2007-03-06 12:10:12.000000000 -0500
+++ test/arch/um/drivers/chan_user.c	2007-03-07 11:14:12.000000000 -0500
@@ -158,7 +158,7 @@ static int winch_tramp(int fd, struct tt
 	 */
 	err = run_helper_thread(winch_thread, &data, CLONE_FILES, &stack, 0);
 	if(err < 0){
-		printk("fork of winch_thread failed - errno = %d\n", err);
+		printk("fork of winch_thread failed - errno = %d\n", -err);
 		goto out_close;
 	}
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
