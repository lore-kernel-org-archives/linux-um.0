Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfPJB-0008M7-8H for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 13:34:25 -0700
Received: from mail.edenmarket.de ([62.96.68.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.34) id 1BfPJA-0001xd-J7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 13:34:25 -0700
Message-ID: <40E1D239.7090409@debian.org>
From: Stefan Gybas <sgybas@debian.org>
MIME-Version: 1.0
References: <20040629182711.GM5243@alcor.net>
In-Reply-To: <20040629182711.GM5243@alcor.net>
Subject: Re: [uml-devel] [mgedmin@b4net.lt: Bug#256873: user-mode-linux: fails
	to start (kernel panic)]
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig689B74429E87A9C63FE3359B"
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
Date: Tue, 29 Jun 2004 22:34:01 +0200
To: 256873@bugs.debian.org
Cc: user-mode-linux-devel@lists.sourceforge.net


This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig689B74429E87A9C63FE3359B
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matt Zimmerman wrote:

> I am receiving many reports from my users that 2.4.26-1um is less functional
> than past versions, especially (but not exclusively) where hostfs is
> concerned.  Are others experiencing problems as well?  I am considering
> reverting the Debian packages to 2.4.24-1um, which was the last version
> which was stable for me (it had only one frustrating hostfs bug, where
> readdir() would read forever).

That's also my experince: I'm currently running Linux 2.4.26 with UML 
patch 2.4.24-1 on a production system (kernel 2.6 with SKAS patch on the 
host) without major problems.

When I used UML patch 2.4.24-2 or higher the guest systems were very 
unstable and crashed after a few hours. The linux processes on the host 
were simply killed by a segmentation fault or I got one of these error 
messages:

Kernel panic: Segfault with no mm
Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 0

I even tried to build a UML kernel on woody (where the AIO glibc headers 
are not available, so the kernel is built with gcc 2.95 and without AIO 
support) but the resulting kernel also was not very stable.

So I suggest to use kernel 2.4.26 (or higher, when available) with UML 
patch 2.4.24-1 for the user-mode-linux Debian package (which is also 
used by some commercial hosting services like Linode). BTW, thanks for 
packaging!

Stefan

--------------enig689B74429E87A9C63FE3359B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA4dI9CdoSgNrrJGsRAsO+AKC6YbI7gQiljm9brlz1ntk2egL4IwCfSHEu
3QP03KLmxxPss7A+UuIlP6E=
=dbaK
-----END PGP SIGNATURE-----

--------------enig689B74429E87A9C63FE3359B--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
