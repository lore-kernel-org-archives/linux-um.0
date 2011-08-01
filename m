Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zdevai@gmail.com>) id 1QnqsO-00088a-Fr
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Aug 2011 11:41:40 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QnqsL-0008Sh-N8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Aug 2011 11:41:38 +0000
Received: by qwh5 with SMTP id 5so3755533qwh.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 01 Aug 2011 04:41:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110801083614.GC15578@n2100.arm.linux.org.uk>
References: <1312042478-26012-1-git-send-email-zdevai@gmail.com>
	<20110801083614.GC15578@n2100.arm.linux.org.uk>
Date: Mon, 1 Aug 2011 13:41:32 +0200
Message-ID: <CAGVye5Nh2E4L3Ox=OKvG09v4hO6BjGmLUGZ5=Ha2QzbXar+deA@mail.gmail.com>
From: Zoltan Devai <zdevai@gmail.com>
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
Subject: Re: [uml-devel] [PATCH] Remove remaining references of
	CONFIG_GENERIC_TIME
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: chris@zankel.net, linux-am33-list@redhat.com, trivial@kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-arm-kernel@lists.infradead.org

2011/8/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, Jul 30, 2011 at 06:14:38PM +0200, Zoltan Devai wrote:
>> Commit 592913ecb87a9e06f98ddb55b298f1a66bf94c6b has killed off any
>> use of this config option long ago.
>
> I don't see the point of this - we were free of GENERIC_TIME on ARM
> shortly after it was originally killed off. =A0The problem is you can't
> stop people introducing new uses of this - because it existed once and
> there's nothing which errors out on its presence, people are going to
> continue submitting patches with it in. =A0And it's going to continue
> being missed at the review stage.
>
> I've a similar problem with folk on ARM including mach/gpio.h as their
> sole gpio header file rather than linux/gpio.h - I've been trying for
> the last 1-2 years to educate people to use linux/ in preference. =A0You
> can't do it, and I'm still just about the only one who picks up on that.
> (SoC maintainers don't care.) =A0They will end up caring when I push a
> change during the next merge window though, so I'll eventually stop
> mach/gpio.h being included. =A0(Instead, it'll be asm/gpio.h).
>
> GENERIC_TIME though... I don't think you'll ever stop new uses of it
> creeping in unless you can arrange for something to error out.

Sure, but the patch at least reduces the chances of copy-pasting it,
and makes it obvious by a simple grep that there's no use of it at all,
so I still think it's wort merging.

Don't know though who should pick this up...

Z

---------------------------------------------------------------------------=
---
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

