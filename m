Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZD9u-0005Dj-Do for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 10:55:30 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CZD9r-0004s3-Hj for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 10:55:29 -0800
Message-ID: <241401c4d70e$38b53450$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <000901c4d0e1$e7f998d0$0201a8c0@hawk>
	<200411222346.36960.blaisorblade_spam@yahoo.it>
	<001001c4d184$ca00b9f0$0201a8c0@hawk>
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
Date: Tue, 30 Nov 2004 12:55:52 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Blaisorblade <blaisorblade_spam@yahoo.it>, dopez <lists@dopez.xs4all.nl>

I've been able to narrow this down to the "signal-delivery" patch.  2.6.10-rc2-mm3
without the patch is fine, whereas adding the signal-delivery patch and you'll get
mysql zombies inside the UML.  This happens on a variety of hosts, including
2.6.10-rc2-bk7 + skas-v7.

I just noticed 2.6.10-rc2-mm4 is out, and the patch there is named
"uml-redo-the-signal-delivery-mechanism.patch".

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
