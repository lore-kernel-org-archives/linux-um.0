Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWfQO-0005ly-Nn for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 10:30:00 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWfQM-0007UG-SW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 10:30:00 -0800
Message-ID: <000c01c4d18a$683a4dc0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <000901c4d0e1$e7f998d0$0201a8c0@hawk>
	<200411222346.36960.blaisorblade_spam@yahoo.it>
	<001001c4d184$ca00b9f0$0201a8c0@hawk>
	<200411231922.17600.blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: 2.6.9-bb3 creates zombie threads in SKAS
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Tue, 23 Nov 2004 12:29:44 -0600
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

> > I'm
> > happy to blame it on the older SKAS version.
> I'm not, unless your sentence mean that you have a test server on which you
> verified this is true...

Nope -- I made an assumption, given that I have what could be seen as similar
problems with this host kernel (mysql segfaults on other UML kernels, but it zombies
under -bb3)...  I have not tested -bb3 under the latest skas revision.  But, see the
other post from "dopez".

> and even in that case, it can mean that this bug
> shows on hosts not supporting SYSEMU (like SKAS3/2.6-v1 hosts). Which would
> be anyway a bug.

The host kernel in question did have the SYSEMU patches.

-Chris



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
