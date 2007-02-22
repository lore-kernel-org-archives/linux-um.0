Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK1Ut-0005Ln-NJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:07:48 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HK1Uq-00056Q-4G
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:07:43 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 22 Feb 2007 01:07:30 +0100
References: <200702082157.l18LvVFB007602@ccure.user-mode-linux.org>
In-Reply-To: <200702082157.l18LvVFB007602@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702220107.30766.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, wstearns@pobox.com

On Thursday 08 February 2007 22:57, Jeff Dike wrote:
> x86_64 needs some TLS fixes.  What was missing was remembering the
> child thread id during clone and stuffing it into the child during
> each context switch.
>
> The %fs value is stored separately in the thread structure since the
> host controls what effect it has on the actual register file.  The
> host also needs to store it in its own thread struct, so we need the
> value kept outside the register file.
Is there any reason for avoiding this treatment to %gs, apart that TLS code 
usually does not need it, even if the API allows for it to exist? I _do_ 
believe this patch fixes bug which can be tested (not verified everything), 
even if I wonder why you didn't look at the patch I sent to you time ago (I 
hadn't finished it, in truth, but there was most stuff - it had problems I 
couldn't debug at that time).
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
