Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArMCJ-0005GE-RD
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 11:08:27 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1ArMB2-0003cB-0c
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 11:07:08 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Swapping directly to host swap area?
References: <Pine.LNX.4.44.0401251827030.2766-100000@sparrow> <200402051759.03917.blaisorblade_spam@yahoo.it> <200402110043.i1B0hOip004189@ccure.user-mode-linux.org>
In-Reply-To: <200402110043.i1B0hOip004189@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402122008.22995.blaisorblade_spam@yahoo.it>
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
Date: Thu, 12 Feb 2004 20:08:22 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Alle 01:43, mercoled=EC 11 febbraio 2004, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > About this, my idea was that using swap both on the host and on the
> > guests is  not very useful:
>
> My suggestions were aimed at making the host less likely to swap.  There
> are various pathological things which happen when both UML and the host a=
re
> swapping.  Having said that, the host needs to be able to swap UMLs if the
> memory situation is so bad that there is no other choice.
I agree completely.

> > - because the host already sees which pages are accessed and which not
> > (an  access inside UML is an access inside the host); the only
> > difference is that  the host can swap even the guest kernel, while UML
> > not;
>
> UML might have a better idea than the host, though.

It seems to me that the access statistics should be the same ones: I do not=
=20
know thoroughly the way pages are marked as active or swappable (I can chec=
k=20
in the 2.4 VM description - ask for the address) but if that depends on pag=
e=20
faulting, then, it seems to me that since guest page fault are even host pa=
ge=20
fault (the UML handling of SIGSEGV is like the host handling of CPU fault=20
exceptions, right?) the statistics should be the same. At least In My Very =

Humble Opinion.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
