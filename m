Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Shnfi-0003yh-NZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 20:08:06 +0000
Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Shnfi-0002pc-1Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 20:08:06 +0000
Received: by lbol5 with SMTP id l5so2822234lbo.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 21 Jun 2012 13:07:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20120621T214420-7@post.gmane.org>
References: <4F3C1B06.7080506@nagafix.co.uk>
	<loom.20120621T174831-991@post.gmane.org>
	<CAFLxGvzcA7RNyJ_Ax94kQxXhsLx5+g8bBAbz8rKkLr0JfU4xVA@mail.gmail.com>
	<loom.20120621T214420-7@post.gmane.org>
Date: Thu, 21 Jun 2012 22:07:59 +0200
Message-ID: <CAFLxGvwC6AWu2=Fuj1OJR1AyDqPTFg7grfnYEHZ-b2JyCMBV1A@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] X11 vfb forward ported to 3.2
To: Will Drewry <wad@dataspill.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 21, 2012 at 9:45 PM, Will Drewry <wad@dataspill.org> wrote:
> Cool! I'll clean it up. =A0So far I also found a use-after-free bug which=
 broke
> list traversal (during screen redraw) and moved it from kthread to workqu=
eues.
> There are still a lot of pieces which don't make as much sense to me yet,=
 but
> once it seems not so crazy, I'll definitely post it for consideration. =
=A0I'd love
> to see it in!

Do you have a git repo where your current work is visible?

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

