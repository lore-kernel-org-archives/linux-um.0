Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPqOz-0006Jq-5p for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 15:16:05 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BPqOy-0002e3-EH for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 15:16:04 -0700
Message-ID: <03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
MIME-Version: 1.0
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
Date: Tue, 18 May 2004 00:22:45 +0200
Content-Transfer-Encoding: quoted-printable
To: Laurent Vivier <LaurentVivier@wanadoo.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

> If someone think this patch is really useful for 2.6 I can make the
> port.

for my personal opinion, every attempt to improve the performance of uml is=
 useful.
:)

the question is:
is the "real world" performance benefit, uml get`s from this patch worth ta=
king your time and is it implemented in a way, so that
uml maintainers are happy with that ?
i cannot really estimate, what performance benefits your patch brings to um=
l in detail, but what i have seen so far, this seems
quite worth doing the work.  reducing context switches by 1/3 is a LOT, imh=
o - and reducing the execution time of the getpid-loop to
nearly the half is quite impressive.

are there any "con`s" that argue for that work _NOT_ being done ?

i would be a happy tester of a patch for 2.6 :)

regards
roland


----- Original Message -----=20
From: "Laurent Vivier" <LaurentVivier@wanadoo.fr>
To: "roland" <for_spam@gmx.de>
Cc: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Tuesday, May 18, 2004 12:00 AM
Subject: Re: [uml-devel] [PATCH] host context switch reduction


> Hi,
>
> find hereunder the measurements I sent to Jeff.
>
> If someone think this patch is really useful for 2.6 I can make the
> port.
>
> Regards,
> Laurent
> Please CC: me, as I'm not in the mailing list.
>
> Le lun 17/05/2004 =E0 22:08, roland a =E9crit :
> > hi !
> > has this / will this be ported to 2.6 ?
> > have there been made further performance comparisons ?
> > regards
> > roland
> >
> >
> > >Well, we just looked at the context switches. We started 3 UMLs which
> > >were doing a make world for xfree. Without patches the number of
> > >context switches per second was around 60k, with the patch it was arou=
nd
> > >40k - so it's noticeable, at least from the cs.
> > >Sven
> >
> > ----- Original Message -----=20
> > From: "Jeff Dike" <jdike@addtoit.com>
> > To: <user-mode-linux-devel@lists.sourceforge.net>
> > Sent: Sunday, February 29, 2004 6:35 AM
> > Subject: [uml-devel] [PATCH] host context switch reduction
> >
> >
> > > The patches below are from Laurent Vivier who didn't make them public=
.  They
> > > add a new feature to ptrace on the host which cuts down on the number=
 of
> > > context switches needed for a UML system call, plus makes UML use it.
> > >
> > > There's some interest in this, so I'm putting it out as-is.  I haven'=
t played
> > > with it.
> > >
> > > Laurent did some performance testing and found ~40% speedup on a getp=
id
> > > loop, and a 3.5% speedup on a kernel build.
> > >
> > > Jeff
> > >
> > >
>



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=3D2562&alloc_id=3D6184&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
