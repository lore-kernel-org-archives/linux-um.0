Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhvuM-0000QB-2O for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:14:58 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AhvuL-0000fW-Gf for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:14:57 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
In-Reply-To: <200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200401172009.38339.blaisorblade_spam@yahoo.it>
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
Date: Sat, 17 Jan 2004 20:09:38 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Alle 03:33, venerd=EC 16 gennaio 2004, Jeff Dike ha scritto:
> kraxel@bytesex.org said:
> >  * what is the status of kernel modules in 2.6 kernels?
>
> They still don't work.  I still haven't got around to fixing it.

Do the apply_alternatives + constants silly fix posted 1000 times and compi=
le=20
without CONFIG_MODVERSIONS. Then you don't get the kernel panic, and=20
everything works.

I've succesfully built kernel with CONFIG_MODVERSIONS, but *maybe* the=20
Makefile patch is needed for that (since files are post-processed with=20
genksyms). However, I have fixed some other things which could interact wit=
h=20
this, especially for the link scripts.

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
