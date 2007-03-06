Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOf2n-0001xb-3d for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 11:09:53 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HOf2j-0005Yd-GP
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 11:09:53 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 6 Mar 2007 20:07:16 +0100
References: <200703061832.l26IWBKi006564@ccure.user-mode-linux.org>
In-Reply-To: <200703061832.l26IWBKi006564@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703062007.16943.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Tuesday 06 March 2007 19:32, Jeff Dike wrote:
> Fix a bunch of formatting violations in the drivers:
> 	return(n) -> return n
> 	whitespace fixes
> 	emacs formatting comment removal
> 	breaking if(foo) return(n) into two lines
>
> There are also a couple of errno use bugs:
> 	using errno in a printk when the failure put errno into a local variable
> 	saving errno after a printk, which can change it
>
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>

> Index: test/arch/um/drivers/chan_user.c
> ===================================================================
> --- test.orig/arch/um/drivers/chan_user.c	2007-03-06 12:09:47.000000000
> -0500 +++ test/arch/um/drivers/chan_user.c	2007-03-06 12:10:12.000000000
> -0500 @@ -158,7 +158,7 @@ static int winch_tramp(int fd, struct tt
>  	 */
>  	err = run_helper_thread(winch_thread, &data, CLONE_FILES, &stack, 0);
>  	if(err < 0){
> -		printk("fork of winch_thread failed - errno = %d\n", errno);
> +		printk("fork of winch_thread failed - errno = %d\n", err);
>  		goto out_close;
>  	}

The second line should better say -err instead of err.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
