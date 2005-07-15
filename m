Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtI0d-0005Mx-89	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 21:41:11 -0700
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by sc8-sf-mx1.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1DtI0a-0002lu-Hv
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 21:41:11 -0700
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DtI04-0003hD-Sl	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 06:40:37 +0200
Received: from desk.marajade.sandelman.ca ([205.150.200.247])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 15 Jul 2005 06:40:36 +0200
Received: from mcr by desk.marajade.sandelman.ca with local (Gmexim 0.1
	(Debian))        id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 15 Jul 2005 06:40:36 +0200
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Subject: Re: [uml-user] Re: [uml-devel] Re: Problems about fork-not-clone
Message-ID: <v0br54n4zm.fsf@marajade.sandelman.ottawa.on.ca>
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<200507112321.20457.blaisorblade@yahoo.it>
	<200507121816.49410.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
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
Date: Thu, 14 Jul 2005 23:05:33 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

--=-=-=


>>>>> "Paolo" == Blaisorblade  <blaisorblade@yahoo.it> writes:
    Paolo> There were some problems about TT mode which appeared unsolvable
    Paolo> on newer distros, and that was a reason to drop TT mode, but I
    Paolo> just solved them, so  there's no hurry in dropping it.

  Good. I find that it is a LOT easier to debug in the TT mode.

  I really prefer running GDB in a seperate window (under xemacs), and
attaching to the process. I haven't found a useful way to do this with SKAS.
 
  One thing I'd also like is a way to completely turn off the scheduler when
debugging. It just gets in my way when I'm single stepping for 2 hours at a
time :-)

-- 
] Michael Richardson          Xelerance Corporation, Ottawa, ON |  firewalls  [
] mcr @ xelerance.com           Now doing IPsec training, see   |net architect[
] http://www.sandelman.ca/mcr/    www.xelerance.com/training/   |device driver[
]                    I'm a dad: http://www.sandelman.ca/lrmr/                 [

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iQCVAwUAQtcoA4qHRg3pndX9AQFd1AP+OAYctEVmKUjT7fyOjCKwHRvsfWXYoM8t
1ndccL1No6gv08XE5zaOHZhNJ8gv56IRn+9t7hRw+LDhxEtRNeNibWR1QHNb+m8A
Zenw3NtpKcbVCdE4ghwqSY1k8MbCLK2r+1q4c4zS3Cw0XpwS1TkYoDbfaBsJU4aO
jCgqcnu7g3o=
=M2J9
-----END PGP SIGNATURE-----
--=-=-=--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
