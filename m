Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2e4u-0004Px-0P for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 14:27:28 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2e4s-00033d-Rh for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 14:27:27 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1B2e4r-0002pG-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 Mar 2004 23:27:25 +0100
Received: from pd9e58e3c.dip.t-dialin.net ([217.229.142.60])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 Mar 2004 23:27:24 +0100
Received: from skoehler by pd9e58e3c.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 Mar 2004 23:27:24 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <c32m8a$rl9$1@sea.gmane.org>
References: <c31sqm$ett$1@sea.gmane.org> <87u10rjlc0.fsf@grannyogg.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <87u10rjlc0.fsf@grannyogg.localnet>
Subject: [uml-devel] Re: plenty of "/proc/mm map failed" in syslog
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
Date: Sun, 14 Mar 2004 23:25:52 +0100
To: user-mode-linux-devel@lists.sourceforge.net

> Please check the user archives for the last 3 months or google for mm
> map failed.

so i guess the UML kernel couldn't allocate more memory, but why wasn't 
the perl-process killed like it should?



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
