Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkWm5-0005qx-GE	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 17:37:57 -0700
Received: from mail.simonsenconsulting.com ([66.81.238.163]
	helo=main.srihosting.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DkWm4-00061X-6E
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 17:37:57 -0700
Message-ID: <33534.69.239.18.89.1119314275.squirrel@69.239.18.89>
From: "Matt Simonsen" <matt@mattsimonsen.com>
Reply-To: matt@mattsimonsen.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] loadavg at 1.00 when 0.00 is "correct' load
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
Date: Mon, 20 Jun 2005 17:37:55 -0700 (PDT)
To: user-mode-linux-devel@lists.sourceforge.net

Hello all,

I am running

2.6.11-skas3-v8-rc2
2.6.12 and bs4 guest kernels

I see a load in the UML client of 1.00, that should be 0.00. I saw several
posts from early May. If any of you have found the solution to this, I
would greatly appreciate any pointers.

This process is the key... it's always running:

2 ?        RWN    0:00 [ksoftirqd/0]

If this is still an issue, I would be happy to help report on kernels or
do testing.

Matt Simonsen



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
