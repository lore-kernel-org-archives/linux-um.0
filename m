Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0hxx-0005hY-UY for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Feb 2005 07:16:49 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D0hxt-0001i5-Om
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Feb 2005 07:16:49 -0800
Received: from knoppix (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j1EGRPQD006904
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Feb 2005 11:27:33 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502140817.00071.rob@landley.net>
Subject: [uml-devel] Random question...
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
Date: Mon, 14 Feb 2005 08:16:36 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Okay, there's the initial bootup path, IRQs, page faults, and syscalls.  Are 
there any other entry points to the kernel that I'm not thinking of?


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
