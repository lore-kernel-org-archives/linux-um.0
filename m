Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7WvE-0002nR-PV for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Mar 2004 01:49:40 -0800
Received: from ns.theshore.net ([216.156.129.65] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B7WvC-0006F6-TJ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Mar 2004 01:49:38 -0800
Received: from hawk (pcp08670149pcs.500ash01.tn.comcast.net [69.137.84.52])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id i2S9qjgv006915
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 28 Mar 2004 04:52:45 -0500
Message-ID: <007001c414aa$6349e700$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <004901c414a3$f4d28a80$0201a8c0@hawk>
Subject: Re: [uml-devel] [PATCH] I/O-Request Token Bucket Limiter
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
Date: Sun, 28 Mar 2004 03:52:30 -0600
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

> Our sample shows io_tokens being negative, but - while waiting for the bucket
> to be re-supplied, requests will still dribble through no faster than
> token_refill req/second. Or, perhaps this is due to inaccuracies of nanosleep
> or a bug in my logic.

Actually, this makes sense.  The threshold for when we start to nanosleep is when
io_tokens <= 0.  Perhaps the threshold should be when io_tokens < token_refill.

It needs to be checked if io_tokens will continue to decrease under certain
settings and load, but I think the delays are pretty accurate.

-Chris



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
