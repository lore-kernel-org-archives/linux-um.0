Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AooXq-0000bY-6i
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 10:48:10 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AooXp-0004zc-EX
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 10:48:09 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Swapping directly to host swap area?
References: <Pine.LNX.4.44.0401251827030.2766-100000@sparrow> <200401280439.i0S4dMZw005517@ccure.user-mode-linux.org>
In-Reply-To: <200401280439.i0S4dMZw005517@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200402051759.03917.blaisorblade_spam@yahoo.it>
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
Date: Thu, 5 Feb 2004 17:59:03 +0100
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 05:39, mercoled=EC 28 gennaio 2004, Jeff Dike ha scritto:

> > In the current setup, the host kernel sees this as a normal
> > write to an open file, caching it in the process and so not truly
> > freeing up the ram for a bit.
>
> This is, and this could be done by setting O_DIRECT on UML swap devices. =

> That way, writes go directly (and asynchronously) to the device without
> landing in the cache.
>
> With mmap in effect, this can also be done with a MADVISE_DONTNEED on the
> relevant pages of the swap file.
>
> Patches cheerfully accepted.

About this, my idea was that using swap both on the host and on the guests =
is=20
not very useful:

- because the host already sees which pages are accessed and which not (an =

access inside UML is an access inside the host); the only difference is tha=
t=20
the host can swap even the guest kernel, while UML not;

- because that probably creates overhead: page aging probably has little on=
e=20
(it should be possible to disable it with CONFIG_SWAP=3Dn), but since UML (=
if I=20
understand correctly) needs to trap a SIGSEGV (which is slow, according to =

what you say about TT and SKAS) from a page access to swap in a page, while=
=20
the host does this in hardware, my opinion is that you would probably disab=
le=20
swap inside UML. Swap on the host means just that the host will cache datas=
=20
instead of keeping in memory UML pages, if you don't give to the guests mor=
e=20
than the physical memory; but this makes sense, IMHO. When you have differe=
nt=20
customers on the same host, there is a problem, but then they can choose=20
differently (even because this doesn't constrast with the changes to code=20
suggested above).

I think this is correct even when /dev/anon is used, but I'm not very sure =
for=20
it.
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
