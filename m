Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B42jm-0007sv-J2 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 10:59:26 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B42jk-0007Wa-H6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 10:59:24 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] /dev/random oddity
References: <20040313014957.GB13419@speedy.schwinge.homeip.net>
	<Pine.LNX.4.58.0403151422320.13832@gradall.private.brainfood.com>
	<20040315211609.GA24577@ccure.user-mode-linux.org>
In-Reply-To: <20040315211609.GA24577@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403182006.15040.blaisorblade_spam@yahoo.it>
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
Date: Thu, 18 Mar 2004 20:06:15 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Alle 22:16, luned=EC 15 marzo 2004, Jeff Dike ha scritto:
> On Mon, Mar 15, 2004 at 02:23:14PM -0600, Adam Heath wrote:
> > It doesn't.
>
> Figures.
>
> > It'd be nice if there was a generic device mapper between UML and the
> > host, so any device could be proxied, block or char.
>
> Yeah, that would be a good plan.  Too bad about kbuild though.
Sorry, just add an hidden CONFIG_ option which is "default y unless UM" (in=
=20
2.6 language) and you've done the job for the single /dev/random thing (whi=
ch=20
you spoke about above).
For the general proxy case, the hack would be to no-opify the=20
register_{blk,chr}dev for the majors/minors you want to proxy and add=20
__register_*dev which does the job as always. And to add a list of=20
not-proxable majors, possibly, to avoid users proxying their tty's or such =

silly things.

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
