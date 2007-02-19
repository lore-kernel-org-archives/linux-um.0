Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJGMT-0005cz-6E for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 13:47:55 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HJGMQ-0002Uv-IX
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 13:47:53 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Mon, 19 Feb 2007 22:47:33 +0100
References: <11711284362893-git-send-email-blaisorblade@yahoo.it>
	<200702191834.42237.blaisorblade@yahoo.it>
	<20070219195211.GA6530@ccure.user-mode-linux.org>
In-Reply-To: <20070219195211.GA6530@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702192247.33609.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Monday 19 February 2007 20:52, Jeff Dike wrote:
> On Mon, Feb 19, 2007 at 06:34:42PM +0100, Blaisorblade wrote:
> > Jeff, no answer to this yet? I've just checked and it's not on the
> > patchset page either.

> I already had it in my -mm patchset, minus any attribution, so I guess
> I cooked it up myself.

Possibly - or I already sent it time ago (I've had it for long time).

> I've been running with it for a long time, so it's 
> fine by me.
>
> I tossed in your description and SOB and I'll get it off to Andrew unless
> you want to send it in first.

You can send it to Andrew - since I have less time than in the past, to avoid 
delaying patches until they're perfect I'm going to send more patches through 
your tree. With this patch, I also wanted to test the process, and see if it 
can work for you.
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
