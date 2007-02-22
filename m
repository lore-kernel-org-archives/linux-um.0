Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKHKd-0005DX-N6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 09:02:13 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HKHKa-0001DW-FJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 09:02:09 -0800
Date: Thu, 22 Feb 2007 11:54:09 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070222165409.GC3396@ccure.user-mode-linux.org>
References: <200702082157.l18LvVFB007602@ccure.user-mode-linux.org>
	<200702220107.30766.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200702220107.30766.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 2/3] UML - x86_64 thread fixes
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, wstearns@pobox.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thu, Feb 22, 2007 at 01:07:30AM +0100, Blaisorblade wrote:
> Is there any reason for avoiding this treatment to %gs, apart that TLS code 
> usually does not need it, even if the API allows for it to exist?

Is there any prospect that %gs will be getting similar treatment?  %fs is
set through CLONE_SETTLS, so it would seem that something like a new
clone flag would be required for this.

> I _do_ 
> believe this patch fixes bug which can be tested (not verified everything), 
> even if I wonder why you didn't look at the patch I sent to you time ago (I 
> hadn't finished it, in truth, but there was most stuff - it had problems I 
> couldn't debug at that time).

Maybe because I forgot about it - do you have a pointer?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
