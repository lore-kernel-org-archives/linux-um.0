Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzwGV-0000gx-HS for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 03:16:15 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Azw1H-0004BY-1e for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 03:00:31 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] More security questions (was: Module exploits into
	the host?)
References: <20040303200937.GK14069@localhost.localdomain>
	<Pine.LNX.4.44.0403032227040.17693-100000@filer.marasystems.com>
	<20040303231401.GM14069@localhost.localdomain>
In-Reply-To: <20040303231401.GM14069@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403071206.09189.blaisorblade_spam@yahoo.it>
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
Date: Sun, 7 Mar 2004 12:06:09 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Robin Green <greenrd@greenrd.org>

Alle 00:14, gioved=EC 4 marzo 2004, Robin Green ha scritto:
> On Wed, Mar 03, 2004 at 10:29:59PM +0100, Henrik Nordstrom wrote:
> > On Wed, 3 Mar 2004, Robin Green wrote:
> > > Even with the skas patch, is it possible for an insmod to allow an
> > > attacker to break out of a UML?
> >
> > Yes.
>
> OK thanks.
>
> Two more security questions:
>
> 1. Has the lcall vulnerability been fixed? By a change in the mainline
> kernel?
>
> 2. I read on some mailing list (not this one) that in tt mode, processes
> within a UML instance can read and write to each other's memory! Ah, here
> we are, from last year:
>
> http://www.paul.sladen.org/vserver/archives/200305/0074.html
>
> Is this true, or just a rumour?
>
> I have a security proposal to post next, but first I want to understand t=
he
> current state of play of UML security.
I think it can be true if you do not enable the "jail" mode. At least, in T=
T=20
mode, without jail mode, any process can read the kernel memory; actually I=
=20
don't think it can also read the other process memory *directly*, but it is=
=20
possible if you can read the kernel datas you can get to do this (however n=
ot=20
very simply).
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
