Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhUvK-0003sD-7T for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Nov 2005 08:35:14 -0800
Received: from cod.sandelman.ca ([192.139.46.139] helo=lists.sandelman.ca)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1EhUvH-0005vd-L6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Nov 2005 08:35:14 -0800
Subject: Re: [uml-devel] 2.6.15-rc2 
In-Reply-To: Message from Rob Landley <rob@landley.net> of "Wed,
	30 Nov 2005 07:39:45 CST." <200511300739.46148.rob@landley.net> 
References: <12276.1133324450@sandelman.ottawa.on.ca>
	<200511300739.46148.rob@landley.net> 
Message-ID: <31479.1133368473@sandelman.ottawa.on.ca>
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
Date: Wed, 30 Nov 2005 11:34:33 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


What was the fix?
Are you using a cramfs initrd?

I built against the v2.6.15-rc3 tag in GIT, and I saw the same failure.
I'm going to make clean again (the rm -rf way) and try again to be
sure...

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Finger me for keys

iQEVAwUBQ43UloCLcPvd0N1lAQI1kwf/ZaMKdkJQ1vXmYZlPZ4J9RLgql49fcs0N
CG5BOL8hKRfE0iGwJdNJ1w1IYScshcqrKO9+OX6Xvvg0s0pOHQxTB57hdYqYPTvt
FWcwxGfrHRHGKjHO3swvfrr2IOkuOBZca66ji4wVGpnwV4v/oPiZRU9UR5PY/sPf
ECyypB0yaguYc7Y5phA5siMIq0yJQcYNnIaMhP3XEQjfEgYFu9/Gf6PJT6lLibUc
fujxIVHHlrdzX7rv/gSCJUIXR8SxDGw3hvkupHXnODtmpDax/EuJtGEkybQALo6c
lgb+XJFo7Y2JRWMX6uqEl9mooBhg/MkMLzNe7HohIqbv3yu8mIEElA==
=jE4/
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
