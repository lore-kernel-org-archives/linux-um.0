Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWUze-0006xu-4R for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 23:21:42 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWUzd-0008Pr-9J for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 23:21:42 -0800
Message-ID: <007f01c4d12e$05d6f1d0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <000901c4d0e1$e7f998d0$0201a8c0@hawk>
	<200411222346.36960.blaisorblade_spam@yahoo.it>
	<002d01c4d0eb$9d829810$0201a8c0@hawk>
	<050101c4d0ee$d68041a0$2000000a@schlepptopp>
Subject: Re: [uml-devel] Updated token-limiter patch,
	was 2.6.9-bb3 creates zombie threads in SKAS
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Tue, 23 Nov 2004 01:28:23 -0600
To: roland <for_spam@gmx.de>, Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

> > > Btw, question: what about your I/O token limiter? Actively using it? Could
> > > start being worked on for merge (there is at least one bug-report on it by
> > > "roland" on a strange but valid test-case).
> see http://sourceforge.net/mailarchive/message.php?msg_id=8560363
>
> that`s probably just a minor one.
>
> roland

From that post:

> ps:
> the token limiter seems to have a little bug:
> set token_refill=1
> do a "dd if=/dev/zero of=test.dat bs=1024k count=whatever"
> then "sync".
> for me, io isn`t limited here - io_tokens just becomes negative - nothing more.
> ok - io_refill=1 is no "real world" value anyway - so not really important to be
fixed - but interesting :)

I see.  nanosleep doesn't accept an tv_nsec value over 999999999, so there's a simple
fix in this patch:

http://www.theshore.net/~caker/uml/patches/token-limiter-v2.patch

This patch also includes the proc-io_status patch.  It's against 2.6.9, but applies
to 2.4-um as well.

-Chris



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
