Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBjWr-0008Dz-NQ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Sep 2004 17:38:09 -0700
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CBjWq-0003dl-CY for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Sep 2004 17:38:09 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CBjWn-0005ph-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 27 Sep 2004 02:38:05 +0200
Received: from pd953c3b7.dip.t-dialin.net ([217.83.195.183])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 27 Sep 2004 02:38:05 +0200
Received: from skoehler by pd953c3b7.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 27 Sep 2004 02:38:05 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <cj7ndb$gf7$1@sea.gmane.org>
References: <41570919.3020403@exse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <41570919.3020403@exse.net>
Subject: [uml-devel] Re: java does not run in 2.6.8.1
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
Date: Mon, 27 Sep 2004 02:38:42 +0200
To: user-mode-linux-devel@lists.sourceforge.net

> If I remove /lib/tls , it works also.

As far as i know, running NPTL inside UML is still now supported. Your 
/lib/tls likely contains a NPTL-enabled glibc.



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
