Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWl7s-00024y-VK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 16:35:16 -0800
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CWl7r-0007UR-RX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 16:35:16 -0800
Message-ID: <058201c4d1bd$d23e9f40$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] UML on SSI Cluster / UML live migration ?
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
Date: Wed, 24 Nov 2004 01:37:46 +0100
To: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

Hello,

does someone know, what exactly prevents UML from working on SSI Cluster-Systems like OpenMosix ? I`m not sure, but i think I
remember it was because of missing OpenMosix-Feature to migrate Threads or Processes using SharedMem. I read a little bit about
OpenMosix today and found, that there seems to be such feature (now) : http://mcaserta.com/maask/

I would find it VERY useful to be able to run a bunch of UMLs on such a Cluster - e.g. for Loadbalancing and Failover purpose.

Currently i know of 2 Virtualization-Technologies, which can do "Virtual Machine Live Migration":
VMWare ESX Server AddOn "VMotion" (too expensive) and XEN`s "Live Migration" feature (Not yet ready for production usage, IMHO).

Any comments?

regards
Roland

PS:
This is not about "OpenMosix-UML" (the patch to make UML act as an OpenMosix Cluster) - it`s about running UML inside an OpenMosix
Cluster.






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
