Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDA0M-00066L-NQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Apr 2004 15:34:14 -0700
Received: from oetest.freeswan.org ([205.150.200.166]
	helo=noxmail.sandelman.ottawa.on.ca)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BDA0M-0000Og-48
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Apr 2004 15:34:14 -0700
Received: from sandelman.ottawa.on.ca (dhcp-61.toronto.xelerance.com
	[209.112.44.61])
	by noxmail.sandelman.ottawa.on.ca (8.11.6p3/8.11.6) with ESMTP id
	i3CMXBK26268
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified
	OK) for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 12 Apr 2004 18:34:10 -0400 (EDT)
Received: from sandelman.ottawa.on.ca (marajade [127.0.0.1])
	by sandelman.ottawa.on.ca (8.12.3/8.12.3/Debian-6.6) with ESMTP id
	i3CMUS7L001545
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 12 Apr 2004 18:30:30 -0400
Received: from marajade.sandelman.ottawa.on.ca (mcr@localhost)
	by sandelman.ottawa.on.ca (8.12.3/8.12.3/Debian-6.6) with ESMTP id
	i3CF6F1d007425 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 12 Apr 2004 11:06:15 -0400
Subject: Re: [uml-devel] A quick humfs HOWTO 
In-Reply-To: Message from Henrik Nordstrom <uml@henrik.marasystems.com> 
	of "Thu, 08 Apr 2004 10:43:47 +0200."
	<Pine.LNX.4.44.0404081039320.7910-100000@filer.marasystems.com>
References: <Pine.LNX.4.44.0404081039320.7910-100000@filer.marasystems.com> 
Message-ID: <7424.1081782375@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
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
Date: Mon, 12 Apr 2004 11:06:15 -0400
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Henrik" == Henrik Nordstrom <uml@henrik.marasystems.com> writes:
    >> In the meanwhile I'm thinking about this system and it seems that
    >> this will eat lots of inodes because every file will be present
    >> twice in the [host] filesystem with the metadata version using
    >> only a few bytes.

    Henrik> Indeed, so the host better use a filesystem which can handle
    Henrik> this efficiently such as reiserfs if you plan on very large
    Henrik> filesystems.

  That's a good idea. So, let's make sure that we can put the file
system data in one place, and the metadata in a different place.

- --
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQHqwYoqHRg3pndX9AQE97wP/YDhKSNJQiN5dgm1UckIB69RlvNbf3SFC
notLIbqcPFVvGjyXwZgvoMMAfYnQ7ND/tnbH4IOEGjiUSMXCvK3vHMRB8uYZQltA
jAO8e0+Lt668ysS3BRpX0KdZ8EMCV45NBd2PY8h4IvE9WIfa6tmOSwGgnYtEX5N9
ZPSkuMzGm+g=
=3Grd
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
