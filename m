Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5tkn-0002Hx-99 for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Mar 2004 13:48:09 -0800
Received: from oetest.freeswan.org ([205.150.200.166]
	helo=noxmail.sandelman.ottawa.on.ca)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B5tkl-0004p6-2A
	for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Mar 2004 13:48:07 -0800
Subject: Re: [uml-devel] 802.11 emulation under UML 
In-reply-to: Your message of "Tue, 23 Mar 2004 21:21:27 +0100."
	<40609C47.60409@uxu.ch> 
Message-ID: <13706.1080078450@marajade.sandelman.ottawa.on.ca>
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
Date: Tue, 23 Mar 2004 16:47:30 -0500
To: maria maria <for_spam2004@yahoo.it>
Cc: User-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


Maria, I have been proposing to write a new network back end for
UML that does full 802.11, including beacons, station attachment, and
flow control.

This would be a "wlanX" equivalent in UML - hostapd being the base
for the top parts, and the uml_switch-replacement + new backend
doing the functions which typically are done by the 802.11 firmware
itself.

uml_switch can't help you.

It isn't a trivial undertaking, and I have been seeking funding
for it. I have two partial funders for this work.

- --
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQGCwcYqHRg3pndX9AQHxyAP+LQcynB1nClG1SHjGSfpuzIoVHxTlHIDP
SPGFWImQsFMMmMIPi0ezG1iNu9TV4Mk9L6OZaBuSlqelRZPkTK3h4lOwdaRCotX6
DPpPIobe7dORfb0rH7UqU0GmzPyASOMwT4WLZo/80dq7oixpCs+7BZpkWURYYHH9
/jSfHP2o53g=
=7xow
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
