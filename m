Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bp70G-0003GH-OB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 08:03:00 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bp70G-0004q8-4l for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 08:03:00 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml-2.6.8-rc2 (2.6.8-rc2 w/ uml-patch-2.6.7-01)
References: <20040723214312.14567.qmail@praize.com>
	<1090640326.4233.4.camel@dhollis-lnx.kpmg.com>
In-Reply-To: <1090640326.4233.4.camel@dhollis-lnx.kpmg.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407261705.23006.blaisorblade_spam@yahoo.it>
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
Date: Mon, 26 Jul 2004 17:05:22 +0200
To: David T Hollis <dhollis@davehollis.com>, gboutwel <gboutwel@praize.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 05:38, sabato 24 luglio 2004, David T Hollis ha scritto:
> On Fri, 2004-07-23 at 21:43 +0000, gboutwel wrote:
> >
> > Probably something simple, but I wanted to discuss with folks
> > more in the now on if the above (stdio_console) fix was the right
> > one, and to find out if anyone else has an idea of how to fixe
> > the find_next_zero_bit error.

Yes, I saw that error in -mm and I agree that renaming is right; about the 
other one, the reported fix (below) is correct; also, it would be nice to 
delete include/asm-um/bitops.h (which includes the i386 version of the 
include; since those funcs were moved to out-of-line ones, the trick must be 
done that way).

Note however that we must not hardcode that we steel things from i386 arch, 
but we must use $(SUBARCH) - or it will break for any other archs (the only 
working one, at the moment, is the x86_64 one).


> I ran into this around a week or so ago as well.  Unfortunately, I don't
> have a patch but here is the rough idea of what I did to work around it.
> find_next_zero_bit is defined in arch/i386/lib/bitops.c.  If you look in
> arch/um/sys-i386, a couple files get symlinked from other parts of the
> tree (see the Makefile).  If you add bitops.c to this, you will get past
> the find_next_zero_bit problem.  You would add bitops.o to the obj-y,
> bitops.c to SYMLINKS, bitops.c-dir := arch/i386/lib.  I think thats
> about it.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
