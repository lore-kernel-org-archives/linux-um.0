Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CqYpg-0001mu-JL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jan 2005 07:30:20 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CqYpf-00022K-0A
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jan 2005 07:30:20 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
Message-ID: <20050117152604.GH10394@bytesex>
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200501101450.32169.Armin.Warda@gmx.de>
	<20050111165848.GA20592@bytesex>
	<200501121653.44872.Armin.Warda@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501121653.44872.Armin.Warda@gmx.de>
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
Date: Mon, 17 Jan 2005 16:26:05 +0100
To: "Armin M. Warda" <Armin.Warda@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, "Christopher S. Aker" <caker@theshore.net>, Paolo Giarrusso <blaisorblade_personal@yahoo.it>

> The kernel/exit.c of SuSE 2.6.8-24.10 corresponds to bitkeeper rev 
> 1.155, and the above "bogus ECHILD return" fix is in bk rev 1.170 of 
> kernel/exit.c, thus there are at least 15 additional fixes to be 
> considered for backporting from 2.6.10 to SuSE's 2.6.8-24.10.

Hmm, well, it's only 5 patches which actually touch that area, but
partly they are big and complex :-/

Sneaking in a small obviouslycorrect[tm] fix isn't a big issue, but
thats a bit too much.

> This is to much for me, as I am no kernel hacker. If no one picks up 
> that job, then my only hope is that SuSE will finally move its SuSE 
> 9.2 forward to 2.6.10.

The releases usually never ever get a new kernel version, so a 2.6.10
update for 9.2 isn't going to happen.  We are already working on the
kernel for the next release though, you can fetch experimental rpms
from http://ftp.suse.com/pub/projects/kernel/kotd/i386/HEAD/ and give
them a try.  They are 2.6.10 based.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
