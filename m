Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VmnXU-00065r-LD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 16:37:04 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VmnXT-0002On-1p
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 16:37:04 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sat, 30 Nov 2013 17:36:53 +0100
Message-ID: <12168390.KiZOGGCO6s@sandpuppy>
In-Reply-To: <529A1247.30800@gmx.de>
References: <5299F818.4070408@gmx.de>
	<CAFLxGvy4y7LpTzsbm6oNn3StFPS1gvKayeR0LcqaVBbz6haiQQ@mail.gmail.com>
	<529A1247.30800@gmx.de>
MIME-Version: 1.0
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
Subject: Re: [uml-devel] does 3.12.2 breaks UML with "con=xterm" ?
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, UML devel <user-mode-linux-devel@lists.sourceforge.net>

Am Samstag, 30. November 2013, 17:28:55 schrieb Toralf F=F6rster:
> On 11/30/2013 03:51 PM, Richard Weinberger wrote:
> > Please more details.
> > Does Linus' tree work?
> > Does it crash immediately?
> =

> Does this helps ? :

Please try Linus's tree and run it without GDB.
UML now has a complete new stack unwinder, let's give it a try.

Thanks,
//richard

---------------------------------------------------------------------------=
---
Rapidly troubleshoot problems before they affect your business. Most IT =

organizations don't have a clear picture of how application performance =

affects their revenue. With AppDynamics, you get 100% visibility into your =

Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics P=
ro!
http://pubads.g.doubleclick.net/gampad/clk?id=3D84349351&iu=3D/4140/ostg.cl=
ktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

