Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgoyT-0005YW-VK for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 11:10:53 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BgoyT-00010H-Co for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 11:10:53 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Uploaded Uml patchset for 2.6.7(was: Re: Inclusion of
	UML in 2.6.8)
References: <200406261905.22710.blaisorblade_spam@yahoo.it>
	<20040627035311.GA8842@ccure.user-mode-linux.org>
	<200406292129.52093.blaisorblade_spam@yahoo.it>
In-Reply-To: <200406292129.52093.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406302105.09201.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Sat, 3 Jul 2004 20:25:18 +0200
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Wedgwood <cw@f00f.org>

Alle 21:29, marted=EC 29 giugno 2004, BlaisorBlade ha scritto:
> Alle 05:53, domenica 27 giugno 2004, Jeff Dike ha scritto:
> > On Sat, Jun 26, 2004 at 07:10:48PM +0100, Christoph Hellwig wrote:
> > > Please send split patches.  E.g. linux/ghash.h should not ne
> > > reintroduced, it's completely fuly.
>
> Anyway, I'm going to upload the whole patchset (as it is now); I just
> tarred my ./patch-scripts folder, containing descriptions, .pc files and
> actual patches. The updates from Jeff Dike are not very split, but
> everything I've added is in his own separate patch. Little changes anyway.
>
> I've problems with patch-bomb, so for now here is it:
>
> http://www.user-mode-linux.org/~blaisorblade/patches/bb/uml-patch-2.6.7-0=
1-
>bb2.tar.bz2

I forgot 2 things: first - it's against 2.6.7 vanillla. Second - there are =

some not-working patches, but the "series" file does not refer to them.

So,=20

tar xjf linux-2.6.7.tar.bz2
cd linux-2.6.7
tar xjf uml-patch-2.6.7-01-bb2.tar.bz2
pushpatch 30 (having patch-scripts installed)

is the simplest way to apply it. Without patch-scripts, for each line in=20
patch-scripts/series (do grep -v '^#' first to remove comments) apply the=20
patch from patch-scripts/patches.

Also, Andrew, why has it not been included in 2.6.7-mm5?
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
