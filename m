Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B96eY-0004FS-OS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 10:10:58 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B96eY-0000dK-38 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 10:10:58 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Segfault on UML load
References: <Pine.LNX.4.58.0403311549380.25444@cac>
In-Reply-To: <Pine.LNX.4.58.0403311549380.25444@cac>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200404012021.50054.blaisorblade_spam@yahoo.it>
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
Date: Thu, 1 Apr 2004 19:21:50 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Charles A. Clinton" <cac@cac.seattle.wa.us>

Alle 01:56, gioved=EC 1 aprile 2004, Charles A. Clinton ha scritto:
> When I build a UML kernel on my Fedora Core 1 machine, it segfaults when
> it tries to load.
There are reports of this, but was related either to NPTL or to exec-shield=
=20
(and people succeeded in solving it).

> It looks to me like changes in binutils to support
> exec-shield have added a STACK program header at 0x00000000, causing the
> image to appear to be 2.5G in size.
Nobody has ever had this clue... I've no idea of those changes.

> Is this a:
>     1) known and solved
>     2) an open issue that I need to work on a fix for
>     3) nobody cares
> kind of problem?
>
> (My guess is that adding some commands to arch/um/ld.link.in to disappear
> or move the STACK program header is the right way to fix it)

Well, see this for the solution everybody used:

http://toast.debian.net/~may/umlproject/bugs.html

If you succeed in doing the patch you suggest, then post the patch. If you =

think you are right but aren't able to do the fix, wait for answers from=20
somebody smarter than me(especially M A Young who hacks UML on Fedora) or=20
post evidence/explanations about your problem.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
