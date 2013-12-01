Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Vn48o-0003mw-02
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Dec 2013 10:20:42 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vn48m-0003Je-B7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Dec 2013 10:20:41 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 01 Dec 2013 11:20:26 +0100
Message-ID: <1423288.L1vGMMJNcF@sandpuppy>
In-Reply-To: <529B0CBB.4020607@gmx.de>
References: <5299F818.4070408@gmx.de> <1555258.aSymPdfuDx@sandpuppy>
	<529B0CBB.4020607@gmx.de>
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
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Am Sonntag, 1. Dezember 2013, 11:17:31 schrieb Toralf F=F6rster:
> On 12/01/2013 12:19 AM, Richard Weinberger wrote:
> >> > after another minute now all xterms are away ....
> > =

> > So, it does not crash immediately.
> =

> Right, to be precise, just 1 sub-process crashes immediately
> =

> > Please do not use xterm for con0. Such that we can see the kernel output
> > after a crash.
> > Maybe there are some error message before...
> =

> Without xterm I do not see any errors except the "winch_thread ..." - lin=
e.

I meant xterm for all consoles but con0...
Such that you can trigger the crash but are still able to see the output.

> =

> BTW wrt the radix-tree-issue seems that fedora has now a similar bug
> open : https://bugzilla.redhat.com/show_bug.cgi?id=3D1015028

Thanks for the info!

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

