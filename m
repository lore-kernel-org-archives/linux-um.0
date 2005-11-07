Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZCdz-0000M8-Sx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 11:27:03 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EZCdw-0006cj-Bs
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 11:27:03 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Does UML 2.6.14 work under x86-64?
References: <200511061723.32848.rob@landley.net>
In-Reply-To: <200511061723.32848.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200511072032.27218.blaisorblade@yahoo.it>
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
Date: Mon, 7 Nov 2005 20:32:26 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, David Lang <dlang@invendra.net>

On Monday 07 November 2005 00:23, Rob Landley wrote:
> David Lang is trying to get my firmware build working under x86-64,
proper x86-64 or a 32-bit binary?
> and=20
> when I upgraded him to 2.6.14 (to get around the memory leak in 2.6.13.2),
> he

> started getting this:

> >> Kernel panic - not syncing: get_skas_faultinfo : failed to wait for
> >> SIGUSR1/SIGTRAP, pid =3D 16411, n =3D 16411, errno
> >> =A0 0, status =3D 0xb7f
>
> This is 2.6.14 configured like so:
>

> CONFIG_MODE_SKAS=3Dy
> EOF
> yes "" | make ARCH=3Dum oldconfig &&
> make ARCH=3Dum
Ok, this seems a 64-bit binary if built on x86-64.
> He first tried with the LDT patch applied.
When I last tried that patch doesn't compile on x86-64.
> Then he tried reverting it (and=20
> adding LD_ASSUME_KERNEL=3D2.4.1 to the kernel command line), but that did=
n't
> help.

> Any clues?  (Should I tell him to just try -tt mode?
> Or revert to 2.6.13=20
> with the leak fix?)
For now, any of these workaround is good, if it works.

On the bug: there are some problems with the stub assembly code - it=20
miscompiles on some GCC releases. I'm trying to fix that - and -bs1 may or =

may not help on this (for some people it refuses to compile on x86_64).

GCC version?
--=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	=09
___________________________________=20
Yahoo! Messenger: chiamate gratuite in tutto il mondo=20
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
