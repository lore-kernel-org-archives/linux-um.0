Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg4kx-0008Eq-JD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 09:49:51 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bg4kw-0006EI-VB for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 09:49:51 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] bad panic "Kernel stack overflow" - demo exploit
References: <40E0036D.2070108@sysgo.de>
	<200406291604.51726.blaisorblade_spam@yahoo.it>
	<40E29034.7040504@sysgo.de>
In-Reply-To: <40E29034.7040504@sysgo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407011401.51780.blaisorblade_spam@yahoo.it>
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
Date: Thu, 1 Jul 2004 14:01:51 +0200
Content-Transfer-Encoding: quoted-printable
To: azu <azu@sysgo.de>, user-mode-linux-devel@lists.sourceforge.net

Alle 12:04, mercoled=EC 30 giugno 2004, azu ha scritto:
> I wrote a small demo app to trigger the problem.
> Limit your UML memory to 16MB or so to trigger the panic faster.
With the last fix I posted (the !is_user check) it does not panic. But I ha=
d=20
statically linked it since I've no gcc inside UML, so I'll have to retest i=
t.

Thanks for the analisys and the test-script.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
