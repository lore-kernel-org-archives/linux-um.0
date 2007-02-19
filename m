Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJCQW-0003XH-3z for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 09:35:48 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HJCQR-0006j3-8v
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 09:35:48 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Mon, 19 Feb 2007 18:34:42 +0100
References: <11711284362893-git-send-email-blaisorblade@yahoo.it>
In-Reply-To: <11711284362893-git-send-email-blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702191834.42237.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] uml: fix pte_mkread setting page read/write
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Saturday 10 February 2007 18:27, Paolo 'Blaisorblade' Giarrusso wrote:
> Fix the fact that pte_mkread set _PAGE_RW instead of _PAGE_USER (the logic
> is copied from i386 in most place, so it is really as bad as you're
> thinking).
>
> Thus currently page tables are more permissive than they should.
>
> Such a change may trigger other latent bugs, so be careful with this.
>
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Jeff, no answer to this yet? I've just checked and it's not on the patchset 
page either.
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
