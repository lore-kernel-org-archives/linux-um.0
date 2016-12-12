Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rrs@researchut.com>) id 1cGWGz-0003ET-6z
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 19:28:29 +0000
Received: from mail-pg0-f66.google.com ([74.125.83.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cGWGy-0003QX-7g
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 19:28:29 +0000
Received: by mail-pg0-f66.google.com with SMTP id p66so1862180pga.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 12 Dec 2016 11:28:28 -0800 (PST)
Message-ID: <1481569825.6973.1.camel@researchut.com>
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Tue, 13 Dec 2016 00:40:25 +0530
In-Reply-To: <CAFLxGvymHmbX=FpXFXWK4o6dzDrKA7TAMS84ABTuNGhNhFUEXg@mail.gmail.com>
References: <1480789253.13532.5.camel@researchut.com>
	<CAFLxGvymHmbX=FpXFXWK4o6dzDrKA7TAMS84ABTuNGhNhFUEXg@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [uml-devel] Build failure on new gcc-6 on Debian Sid
Reply-To: rrs@researchut.com
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Mon, 2016-12-12 at 17:32 +0100, Richard Weinberger wrote:
> Isn't this a toolchain bug?
> Can you please try this fix?
> https://sourceware.org/bugzilla/show_bug.cgi?id=20800

Thanks for the link. I think that'd fix the bug but I'll have to wait until 2.28
hits into Debian.

There have been lots of build failures, in multiple tools, in Debian with this
global change. And we've been overriding the default build flags for the failing
tools. But for uml, adding the linker flag of -fno-pie did not help.


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlhO9iEACgkQpjpYo/Lh
dWloEQ/7BbkL6qAmJLAJFCCbODvW+Xhcwqqs9E5PYCC992bvDyOB26G6SJm9UGwX
W7lLWTRyJz/L3Txmrjdr0BN5InNDPD3xj3vnzDDWVxQZrIO6Q3W43oT19A39SB30
WwHYPca52ZtIYE0OuTBqJIacNKDzISsYysd36OfPJTFOHW4KogFEdhIDWHEs39rA
ATFprtj4+NMNXv0/xFsoz8BIjhRyQEd4jCsXtLO8zgsWKtYmPoF6KuD/LGkz5Ju2
qo6iO4DwJFzyrkc1ZhylhmpMAB3W9noelZvWUFedqjPlNo3cFKT3xw/b+FRRnIz/
ObnGoI2PYr56Q+crSBGqGxuia6vjUOXrn6h63yk0RScqTH3OOnUkfICeZhPPqFvl
cotwF6C2M9gVwLR8kIM2BFrC5Zcd5B7V+HD34pvlMMI4s3PAdLDPAesq3l353Mgc
lfLnkPb6lGrxcnwpEsk36ur1kuBs8JvdToBrlLjSF3IqJ9deXQzJsgDsSDw41AXH
oJ8tcAHx62wOzrsJ4DBI0O45+YxW4dsJHFnWBS3/DGc4LJI9ArtA3f/1AvYYHuKd
WWjRKgUmsVa0tybwZUqXBrMv55Diiioab8F/RoQlaLBBq4EvsjrFj+ciNpPCi6UV
fD4xkYi+QQDCUCoc1K7LOnXzaUwW43Fvpu2UazEuGj4MmnC4RV0=
=oBOm
-----END PGP SIGNATURE-----


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

