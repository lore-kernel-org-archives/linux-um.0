Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqH6F-0000Fq-Rp
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 09 Feb 2004 11:29:43 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AqH6F-0007uV-AJ
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 09 Feb 2004 11:29:43 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: UML & 2.6.2
References: <20040204173846.7522.qmail@praize.com> <200402071702.18101.blaisorblade_spam@yahoo.it> <c08jmp$j7c$1@sea.gmane.org>
In-Reply-To: <c08jmp$j7c$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402092021.48547.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 9 Feb 2004 20:21:48 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 19:27, luned=EC 9 febbraio 2004, Sven K=F6hler ha scritto:
> > "1) Use Ingo's combo only for the host kernel (since the UML part for
> > itself is out-of-date)."
>
> i guess you mean redhat.com/~mingo/UML-patches/uml-combo-2.6.0-A7
Right.

> well, i tried to apply it to 2.6.2 vanilla and it doesn't apply without
> errors. in particular hunk #3 for mm/memory.c fails :-(
>
> i know that i have to ignore errors for files in arch/um.
>
> so i tried to apply the rejected hunk manually to mm/memory.c but it
> seems that this section (lines 725 and beyond) is already patched. can
> somebody take a look at that section and tell me if in_gate_area() is OK
> there?

You must unapply all the hunks for mm/memory.c for 2.6.2. Unapply the patch=
 or=20
use a clean source tree, then before applying the patch remove (by hand=20
editing) the whole section about mm/memory.c. The --- and +++ name the file=
=20
the following lines refer to. Also, remember using patch --dry-run to check=
=20
before applying what rejects appear, since with --dry-run patch doesn't=20
modify the patched files.

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
