Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWgyc-00068J-Ja for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 12:09:26 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CWgya-0001Wx-V7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 12:09:26 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Updated token-limiter patch,
	was 2.6.9-bb3 creates zombie threads in SKAS
References: <000901c4d0e1$e7f998d0$0201a8c0@hawk>
	<050101c4d0ee$d68041a0$2000000a@schlepptopp>
	<007f01c4d12e$05d6f1d0$0201a8c0@hawk>
In-Reply-To: <007f01c4d12e$05d6f1d0$0201a8c0@hawk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411232110.24634.blaisorblade_spam@yahoo.it>
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
Date: Tue, 23 Nov 2004 21:10:24 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Christopher S. Aker" <caker@theshore.net>, roland <for_spam@gmx.de>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Tuesday 23 November 2004 08:28, Christopher S. Aker wrote:
> > > > Btw, question: what about your I/O token limiter? Actively using it?
> > > > Could start being worked on for merge (there is at least one
> > > > bug-report on it by "roland" on a strange but valid test-case).

> > see http://sourceforge.net/mailarchive/message.php?msg_id=8560363

> > that`s probably just a minor one.

> > roland

> From that post:
> > ps:
> > the token limiter seems to have a little bug:
> > set token_refill=1
> > do a "dd if=/dev/zero of=test.dat bs=1024k count=whatever"
> > then "sync".

> I see.  nanosleep doesn't accept an tv_nsec value over 999  999  999, so
> there's a simple fix in this patch:

> http://www.theshore.net/~caker/uml/patches/token-limiter-v2.patch

> This patch also includes the proc-io_status patch.  It's against 2.6.9, but
> applies to 2.4-um as well.
>
> -Chris

Ok, seen that - to be cleaner, I'll change when I remember this to set, 
instead, tv_sec to 1 (tv_nsec cannot be one billion because one billion of 
nsec is one sec). I see that there is no actual difference and that doing 
this is a bit more invasive, so I guess that you fixed it this way on 
purpose, but, for merging, such things deserve cleaning. Also the proc status 
will have to be moved to a uml-only file.

Just a little thing, anyway - the patch is very nice.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
