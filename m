Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CaipN-0003U7-7b for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Dec 2004 14:56:33 -0800
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CaipK-0005i0-7M for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Dec 2004 14:56:32 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CaipH-0006ro-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 04 Dec 2004 23:56:27 +0100
Received: from p5484b17b.dip.t-dialin.net ([84.132.177.123])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 04 Dec 2004 23:56:27 +0100
Received: from skoehler by p5484b17b.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 04 Dec 2004 23:56:27 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <41B240F4.2010108@upb.de>
References: <005301c4d95b$4bdbe4d0$0201a8c0@hawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <005301c4d95b$4bdbe4d0$0201a8c0@hawk>
Subject: [uml-devel] Re: 2.6.9-bb4 released
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
Date: Sat, 04 Dec 2004 23:57:56 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

> http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.9-bb4/

runs stable now for about 24 hours, longer than any version before ;-)

> Most notable patches are:
> - uml-hang-on-2.6.9-host
> - uml-fix-reboot-skas

well, does this "fix-reboot" mean, that it doesn't reboot anymore? 
because it doesn't when i tell it to

sometimes it even segfaults, when halting or rebooting.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
