Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoIVe-0004J6-FY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 01:40:18 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CoIVb-0008BN-Co
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 01:40:18 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [PATCH] Put the check for NULL before the use of a
	potentially-null value
Message-ID: <20050111091340.GB16448@bytesex>
References: <41E2F90C.4020707@tuxrocks.com>
	<200501110128.38523.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501110128.38523.blaisorblade@yahoo.it>
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
Date: Tue, 11 Jan 2005 10:13:40 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Frank Sorenson <frank@tuxrocks.com>

> -       line = tty->driver_data;
>         if (tty != NULL) {
> +               line = tty->driver_data;

> Sorry, a little question: against what tree does it apply?

Any cutting edge tree (both latest -mm and latest Linus -bk snapshot).

> I hope I'll not forget it...

I think it can go to andrew morton as-is, it's a ObviouslyCorrect[tm] fix.

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
