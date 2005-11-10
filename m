Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EaAei-00034p-ET for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Nov 2005 03:31:48 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EaAee-0000eE-OH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Nov 2005 03:31:48 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] errors in uml-guest log
References: <dkuq7o$u24$1@sea.gmane.org>
In-Reply-To: <dkuq7o$u24$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200511101238.47223.blaisorblade@yahoo.it>
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
Date: Thu, 10 Nov 2005 12:38:46 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?iso-8859-15?q?K=F6hler?= <skoehler@upb.de>

On Thursday 10 November 2005 07:43, Sven K=F6hler wrote:
> Hi,
>
> an UML-guest-kernel 2.6.14 (without any additional patches) is running
> on a host with kernel 2.6.12.3-skas3-v8.2 host.
> Can anybody explain this error-message to me,=20
Yes, I can.

In short: don't worry, I get it too at times and I must just remove this=20
warning, it was introduced recently (by me) and it's wrong (as I later=20
discovered).

> which occur periodically
> in the guests log:

More that "periodically" it's randomically. On a kernel compile loop with -=
jN,=20
I used to get that more or less once every hour, but with high variability.=
=20
Just had no time to proof-check and send all patches I have in my queue.

> Badness in handle_page_fault at arch/um/kernel/trap_kern.c:98

> 0f3d3b30:  [<08062f04>] handle_page_fault+0x1c4/0x260
> 0f3d3b70:  [<08063047>] segv+0xa7/0x2e0
> 0f3d3b90:  [<080ba701>] sys_read+0x51/0x80
> 0f3d3bd0:  [<08053680>] init_udf_fs+0x30/0x50
> 0f3d3c00:  [<08053680>] init_udf_fs+0x30/0x50
> 0f3d3c20:  [<08053680>] init_udf_fs+0x30/0x50
> 0f3d3c40:  [<08065291>] get_skas_faultinfo+0x51/0xc0
> 0f3d3c60:  [<08065358>] handle_segv+0x58/0x60
> 0f3d3c80:  [<08065a1d>] userspace+0x1ed/0x220
> 0f3d3cd0:  [<08066d94>] force_flush_all_skas+0x44/0x50
> 0f3d3cf0:  [<08066621>] fork_handler+0xc1/0xe0

It's an error message I introduced to detect a possible bug; however, I lat=
er=20
discovered that under high load this warning can be triggered without a rea=
l=20
problem.

The problem would be a "100% CPU usage" loop (a process endlessly causing=20
guest page faults) right after the warning, so if you haven't got the probl=
em=20
the warning is a false positive.

--=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

=09

=09
	=09
___________________________________=20
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB=20
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
