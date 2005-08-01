Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzPFX-0008ON-Ar	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2005 18:37:51 -0700
Received: from motgate8.mot.com ([129.188.136.8])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DzPF4-0001EJ-3o
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2005 18:37:51 -0700
Received: from il06exr02.mot.com (il06exr02.mot.com [129.188.137.132])
	by motgate8.mot.com (8.12.11/Motgate7) with ESMTP id j711kwAH009943
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 31 Jul 2005 18:46:58 -0700 (MST)
Received: from zch07exm01.corp.mot.com (zch07exm01.corp.mot.com [200.3.1.220])
	by il06exr02.mot.com (8.13.1/8.13.0) with ESMTP id j711h53N020876
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 31 Jul 2005 20:43:06 -0500 (CDT)
Message-ID: <AD266326EC54D9118CE700110A9E2BE205CB82B7@zch07exm01.corp.mot.com>
From: Zhu Tom-a2289c <A2289c@motorola.com>
Subject: RE: [uml-devel] NPTL pthread_create() cannot work.
MIME-Version: 1.0
Content-Type: text/plain
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
Date: Mon, 1 Aug 2005 09:37:16 +0800
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Yes, I already fixed that recently - that patch is a development one and you're the first tester I heard of.
:-)

> I've succeeded in fixing even this...
Can I get your fix for the further test?

> Is that compiled with NPTL / TLS support? Has 2.3.2 any TLS support at all?
It is said to support NPTL 0.29.

Thanks,
Tom


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
