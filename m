Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNyN3-0004O2-9Y for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 11:22:21 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BNyN2-0004lz-OU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 11:22:20 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Patch for 2.6.6
References: <200405112032.13202.blaisorblade_spam@yahoo.it>
	<40A13765.5010002@muhlesteins.com>
In-Reply-To: <40A13765.5010002@muhlesteins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200405122024.22702.blaisorblade_spam@yahoo.it>
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
Date: Wed, 12 May 2004 20:24:22 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 22:28, marted=EC 11 maggio 2004, Dennis Muhlestein ha scritto:
> I got this:
>
> Reversed (or previously applied) patch detected!  Assume -R? [n]
> Apply anyway? [n] y
> Hunk #1 FAILED at 1.
> Hunk #2 FAILED at 19.
> 2 out of 2 hunks FAILED -- saving rejects to file include/asm-um/irq.h.rej
>
> when applying the first patch.  I tried also with not applying that
> part, and get a compile failure pretty early in the build process.
>
> -Dennis

Ok, I botched that part, sorry - try with the patch from Jeff Chua. I'm=20
posting on the site the corrected version, which I hope should apply=20
perfectly (I've tested it on apply and unapply - the first one come by maki=
ng=20
it work on reversing without rejects the Jeff Chua's version).

And, finally, also I should quit editing patches by hand :-), maybe!
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to=20
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From______________________________=
_________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
