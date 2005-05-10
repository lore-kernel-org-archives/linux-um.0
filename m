Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVbgu-00038Q-BJ	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 13:50:56 -0700
Received: from mail.dif.dk ([193.138.115.101] helo=saerimmer.dif.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DVbgt-0008DI-RD	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 13:50:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by saerimmer.dif.dk (Postfix) with ESMTP id 396F4FF41F
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 10 May 2005 23:03:05 +0200 (CEST)
Received: from saerimmer.dif.dk ([127.0.0.1])
 by localhost (saerimmer [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32167-04 for <user-mode-linux-devel@lists.sourceforge.net>;
 Tue, 10 May 2005 23:03:02 +0200 (CEST)
Received: from diftmgw2.backbone.dif.dk (diftmgw2.backbone.dif.dk
	[10.227.136.246])
	by saerimmer.dif.dk (Postfix) with ESMTP id 9CBF3FFC9B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 10 May 2005 23:02:59 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [uml-devel] Re: [patch 1/6] uml: remove elf.h [ compile-fix,
 for 2.6.12 ]
In-Reply-To: <20050510204048.GX3590@stusta.de>
Message-ID: <Pine.LNX.4.62.0505102251060.2386@dragon.hyggekrogen.localhost>
References: <20050509224509.0C105416E4@zion>
	<20050509183401.28082cbc.akpm@osdl.org>
	<Pine.LNX.4.61.0505101525360.16461@filer.marasystems.com>
	<20050510204048.GX3590@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 10 May 2005 22:54:44 +0200 (CEST)
To: Adrian Bunk <bunk@stusta.de>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, 10 May 2005, Adrian Bunk wrote:

> On Tue, May 10, 2005 at 03:37:33PM +0200, Henrik Nordstrom wrote:
> >...
> > The /dev/null trick only works well for adding files, not removing them.
> 
> It works fine for removing files except when they have a zero length.
> 
Then a two-patch approach would seem to work as a hack. First patch just 
adds a blank line to the file making in non-zero length, second patch then 
uses the /dev/null trick to kill the file. A hack? Yes, certainly, but it 
sounds like it would work (actually, it does work, just tried it).


-- 
Jesper Juhl



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
