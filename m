Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATVWC-00043O-4l
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 16:14:24 -0800
Received: from host81-134-133-54.in-addr.btopenworld.com ([81.134.133.54] helo=factotum.office.bytemark.co.uk)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ATVWB-0001Os-Fz
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 16:14:23 -0800
From: Matthew Bloch <matthew@bytemark.co.uk>
Subject: Re: [uml-devel] [PATCH] Locking user-mode kernel RAM into host physical RAM
References: <Pine.LNX.4.44.0312090003010.14902-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0312090003010.14902-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312090014.19246.matthew@bytemark.co.uk>
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
Date: Tue, 9 Dec 2003 00:14:18 +0000
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 08 December 2003 23:18, Henrik Nordstrom wrote:
> > That's my only argument as to why it should be included:  mlocked
> > kernels behave more predictably in a hosting environment!
>
> In principle I agree, but it is somewhat of a corner case. For most
> practical uses you should be able to get the same results with a correctly
> tuned VM on the host and having sufficient amount of memory to allow for a
> decent buffer/cache in addition to the UML memory usage. Only if you
> overbook the memory usage (including buffer/cache requirements on
> the host) should there be significant problems.

I'm guessing the people who are going to be most concerned with UML's=20
performance are ISPs, who are trying to get the best performance from their=
=20
expensive U of data centre rack space; maybe this is a niche case at the=20
moment. =20

I can believe that the kernel is making compromises in terms of buffer=20
requirements after the 50-60% full mark (which is about when we've seen=20
swapping as you predicted).  However after buying a certain amount of RAM f=
or=20
your box, it is *much* cheaper to compensate for the higher disc demands wi=
th=20
arrays of fast discs than it is to put more RAM in.  This doesn't make the =

kernel perform well from that point of view, but it means customers get the=
=20
performance and price they expect :)

cheers,

- --=20
Matthew Bloch                             Bytemark Hosting
                                  tel. +44 (0) 8707 455026
                        http://www.bytemark-hosting.co.uk/
          Dedicated Linux hosts from 15ukp ($26) per month
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1RPaT2rVDg8aLXQRAnLSAJ0QUHDOKcKD5qfKfYpJBBGQOxzbVACeOgrh
wh5avXswOggsOpxuFblT8Is=3D
=3D1aJr
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
