Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aw52G-0003qL-OG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 11:49:36 -0800
Received: from 203-79-92-50.cable.paradise.net.nz ([203.79.92.50]
	helo=bag.kiwa.co.nz)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Aw4tI-0002lm-Sg for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 11:40:21 -0800
From: Nicholas Lee <nj.lee@plumtree.co.nz>
Subject: Re: skas and vserver on 2.4.25 (Re: [uml-devel] new skas3 patch ready
	for 2.4.25)
Message-ID: <20040225194015.GB6875@woodcut.kpac.co.nz>
References: <40338C1B.1070800@meisterwerk.net>
	<200402202125.58574.blaisorblade_spam@yahoo.it>
	<20040223063021.GC31430@woodcut.kpac.co.nz>
	<200402251654.39366.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <200402251654.39366.blaisorblade_spam@yahoo.it>
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
Date: Thu, 26 Feb 2004 08:40:16 +1300
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Feb 25, 2004 at 04:54:39PM +0100, BlaisorBlade wrote:
> Alle 07:30, luned=EC 23 febbraio 2004, Nicholas Lee ha scritto:
> > On Fri, Feb 20, 2004 at 09:25:57PM +0100, BlaisorBlade wrote:
> > > Yes, it went away, so a new skas patch must be built. I have one (tes=
ted)
> > > at http://www.user-mode-linux.org/~blaisorblade/
> >
> > Using this patch against against 2.4.25 with evmns, libata and the
> > vserver patch, I get the following compilation error:-
>=20
> You mean libata for Serial ATA support, EVMS from IBM as a LVM+RAID, righ=
t?=20
> But what is vserver?

http://www.linux-vserver.org/

> However, if you want something reliable enough, post a pointer to the exa=
ct=20
> patch file that you applied for "vserver", and a description of what it d=
oes=20
> (an URL describing it or the "vserver" project homepage could suffice for=
 the=20
> description). If I have time I could answer you saying what you do, i.e. =
if a=20
> such change can suffice or if the two patches interfere too much.

The particular patch in question is at:
http://www.13thfloor.at/vserver/d_release/v1.3.7

Document is a bit tricky to understand so, I might go back and try the
stable version instead: http://www.13thfloor.at/vserver/s_release/v1.26



vserver is basically virtual servers via capabilities. ie. Same kernel,
different context.


--=20
Nicholas Lee - nj.lee at plumtree.co dot nz, somewhere on the fish Maui cau=
ght.
gpg. 8072 4F86 EDCD 4FC1 18EF  5BDD 07B0 9597 6D58 D70C           =20

                         Quixotic Eccentricity


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=3D1356&alloc_id=3D3438&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
