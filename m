Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWJPy-0007OR-Rn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 11:00:06 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWJPv-00015K-6m for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 11:00:06 -0800
Message-ID: <41A23722.7060002@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Problems in make
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
Date: Mon, 22 Nov 2004 19:59:46 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

If arch/um/kernel/tt/include/mode-tt.h is changed, make doesn't compile tracer.c,
the resulting kernel is inconsistent and crashes!

Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
