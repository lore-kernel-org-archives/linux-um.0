Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba4K0-0004OU-PR for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 20:09:12 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ba4K0-00008B-7u for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 20:09:12 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <200406071949.04220.blaisorblade_spam@yahoo.it>
	<200406080455.i584tad2023374@ccure.user-mode-linux.org>
	<200406092305.24447.blaisorblade_spam@yahoo.it>
In-Reply-To: <200406092305.24447.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200406142017.39563.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: The SKAS4 patch?? + ideas for 0 context-switch
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
Date: Mon, 14 Jun 2004 20:17:39 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 23:05, mercoled=EC 9 giugno 2004, BlaisorBlade ha scritto:

> > plus using segments will cost you a cycle or something
> > on every memory reference.
The Intel Manual 3 (Intel System Programming Guide - 253668 -15.pdf) says, =
at=20
page 4-1 (page 107 in the PDF), that limit checking has no performance cost=
,=20
and I expect this to hold especially for simply verifying if an address is =

below a limit. Maybe it could lie, ok, but maybe Alan Cox was referring to =

more complex segmentation tricks.

I'm also going to ask to Ingo Molnar (he sets a segment limit in the CS=20
descriptor in his exec-shield patch, so he has probably benchmarked the=20
result).
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
