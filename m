Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ajtfX-0004WN-Pb
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Mar 2016 19:14:43 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ajtfW-0003lk-FM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Mar 2016 19:14:43 +0000
References: <1448677557-16420-1-git-send-email-peter@hurleysoftware.com>
	<1452402833-8652-1-git-send-email-peter@hurleysoftware.com>
	<1452402833-8652-10-git-send-email-peter@hurleysoftware.com>
	<CAFLxGvwW2A-7bNa0sz72622xDShm_yhSs-JzsiSVh5qd3VBAVQ@mail.gmail.com>
	<56F6DDC7.6060609@hurleysoftware.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56F6DF98.8040706@nod.at>
Date: Sat, 26 Mar 2016 20:14:32 +0100
MIME-Version: 1.0
In-Reply-To: <56F6DDC7.6060609@hurleysoftware.com>
Subject: Re: [uml-devel] [PATCH v2 09/10] tty: Consolidate noctty checks in
	tty_open()
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Peter Hurley <peter@hurleysoftware.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>

Peter,

Am 26.03.2016 um 20:06 schrieb Peter Hurley:
> Sorry about that; I hadn't considered the implications of UML console.
> Can you test the blob below?

Yep, works like a charm. :-)

Thanks,
//richard

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

