Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2ND5-0007GE-Kz for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 May 2008 02:17:11 -0700
Received: from smtp-1.orange.nl ([193.252.22.241])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2ND4-0000LO-5W
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 May 2008 02:17:11 -0700
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6004.orange.nl (SMTP Server) with ESMTP id 198E21C000A5
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 31 May 2008 11:17:02 +0200 (CEST)
Received: from [192.168.5.24] (c529de59c.cable.wanadoo.nl [82.157.229.156])
	by mwinf6004.orange.nl (SMTP Server) with ESMTP id EF2581C0009A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 31 May 2008 11:17:01 +0200 (CEST)
Message-ID: <48411788.8020709@vulnscan.org>
Date: Sat, 31 May 2008 11:16:56 +0200
From: "Bram Matthys (Syzop)" <syzop@vulnscan.org>
MIME-Version: 1.0
References: <4821B5FC.40307@vulnscan.org>
	<20080509154552.GH10169@c2.user-mode-linux.org>
	<48255FC4.4040805@vulnscan.org> <482AA5AE.3000900@saunalahti.fi>
	<20080519161613.GC17500@c2.user-mode-linux.org>
In-Reply-To: <20080519161613.GC17500@c2.user-mode-linux.org>
Subject: Re: [uml-devel] umls unresponsive & consuming 100% cpu time
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jeff,

Sorry for my late reply.

Just tried, and I think your patch fixed it (at least a test with 'date'
setting the time 2 seconds back on the host no longer causes it to hang).
If it causes any trouble in the next few days I'll let you know.

Regards,

	Bram.

Jeff Dike wrote:
| On Wed, May 14, 2008 at 11:41:18AM +0300, Sakari Ailus wrote:
|> I have three UML instances running on a host. First, they all were
|> unresponsive simultaneously using all CPU time they could get. After a
|> while they became responsive again. I could log in through SSH. The
|> funny thing is that the date command showed correct date and time (as
|> far as I remember, can't test it now as they are hung again) while the
|> time in bash prompt was constant showing the time around the initial
|> hang, which is the same on all three instances.
|
| I reproduced and debugged a similar problem, resulting in the patch
| below.  See if it makes any difference for you...
|
| 	       	  	Jeff
|

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)

iD8DBQFIQReI46ioc5305a8RAqQpAKC0j9HcBGFxRgaT2yvXPC9E3W1FXACgg6q6
LAYiR6Z0MMuwIZfTax6ojhc=
=tSsa
-----END PGP SIGNATURE-----


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
