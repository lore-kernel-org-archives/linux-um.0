Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HI07J-0008Ky-IP for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 02:15:04 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HI07G-0007lX-Ok
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 02:15:00 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 15 Feb 2007 20:05:56 +0100
References: <11715068631914-git-send-email-blaisorblade@yahoo.it>
	<20070214215123.57ef2d4a.akpm@linux-foundation.org>
	<20070215170154.GA5641@ccure.user-mode-linux.org>
In-Reply-To: <20070215170154.GA5641@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702152005.56594.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] x86_64: fix 2.6.18 regression -
	PTRACE_OLDSETOPTIONS should be accepted
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thursday 15 February 2007 18:01, Jeff Dike wrote:
> On Wed, Feb 14, 2007 at 09:51:23PM -0800, Andrew Morton wrote:
> > Whatever happens, please ensure that the final fix makes it into -stable
> > as well.  Jeff's version of this patch wasn't cc'ed to stable@kernel.org.
>
> Paolo's patch was sent to -stable.  His should be used everywhere, and mine
> should be dropped.

Jeff, I verified my patch is _almost_ enough for 2.6.18 for fully booting a 
32bit UML; on 2.6.18 I had to also add PTRACE_GET/SET_THREAD_AREA (this fix 
was merged in 2.6.19) to avoid tons of TLS errors.

On 2.6.19, the crash at boot is removed (btw, that crash output no message - I 
hope that with your fatal/nonfatal/etc. introduction I would get a message) 
but another one happens when starting init. I'll test 2.6.20 ASAP.

Bye
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
