Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aw5OJ-0000kq-KS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 12:12:23 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Aw529-0004jH-HH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 11:49:29 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: skas and vserver on 2.4.25 (Re: [uml-devel] new skas3 patch ready
	for 2.4.25)
References: <40338C1B.1070800@meisterwerk.net>
	<200402251654.39366.blaisorblade_spam@yahoo.it>
	<20040225194015.GB6875@woodcut.kpac.co.nz>
In-Reply-To: <20040225194015.GB6875@woodcut.kpac.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402252106.43430.blaisorblade_spam@yahoo.it>
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
Date: Wed, 25 Feb 2004 21:06:43 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nicholas Lee <nj.lee@plumtree.co.nz>

Alle 20:40, mercoled=EC 25 febbraio 2004, Nicholas Lee ha scritto:
> On Wed, Feb 25, 2004 at 04:54:39PM +0100, BlaisorBlade wrote:
> > Alle 07:30, luned=EC 23 febbraio 2004, Nicholas Lee ha scritto:
> > > On Fri, Feb 20, 2004 at 09:25:57PM +0100, BlaisorBlade wrote:
> > > > Yes, it went away, so a new skas patch must be built. I have one
> > > > (tested) at http://www.user-mode-linux.org/~blaisorblade/
> > >
> > > Using this patch against against 2.4.25 with evmns, libata and the
> > > vserver patch, I get the following compilation error:-
> >
> > You mean libata for Serial ATA support, EVMS from IBM as a LVM+RAID,
> > right? But what is vserver?
>
> http://www.linux-vserver.org/
>
> > However, if you want something reliable enough, post a pointer to the
> > exact patch file that you applied for "vserver", and a description of
> > what it does (an URL describing it or the "vserver" project homepage
> > could suffice for the description). If I have time I could answer you
> > saying what you do, i.e. if a such change can suffice or if the two
> > patches interfere too much.
>
> The particular patch in question is at:
> http://www.13thfloor.at/vserver/d_release/v1.3.7
>
> Document is a bit tricky to understand so, I might go back and try the
> stable version instead: http://www.13thfloor.at/vserver/s_release/v1.26

> vserver is basically virtual servers via capabilities. ie. Same kernel,
> different context.

Yes, I got it. With the first look I gave, I can think that your fix is the=
=20
right one - you already checked what I said you. I cannot guarantee that it=
=20
works - but current->vx_info is very meaningful and makes a lot of sense.

However, I'd recommend you to be careful about starting UML's from inside=20
vserver - if you want, test it first and be careful about crashes. Reports =

about both success or failure are needed and welcome!

Bye and thanks.
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
