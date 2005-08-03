Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0FqU-0006mm-1b	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Aug 2005 02:47:30 -0700
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1E0FqS-0003N1-QW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Aug 2005 02:47:30 -0700
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j739lCj3030553
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 3 Aug 2005 05:47:12 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	j739lC06231242	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 3 Aug 2005 05:47:12 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j739lCWF015021
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 3 Aug 2005 05:47:12 -0400
Received: from snowy.in.ibm.com ([9.184.230.145])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j739l9ca014876
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 3 Aug 2005 05:47:11 -0400
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Message-ID: <20050803094805.GA6090@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Host kernel requirements for UML
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
Date: Wed, 3 Aug 2005 15:18:05 +0530
To: user-mode-linux-devel@lists.sourceforge.net

Hi,
	I am trying to get a quick answer for a question I had on UML.
As I understand, UML kernel makes use of host kernel's 
system call interface for its functionality. The questions is, does the
host kernel need to support *all* system calls or only a subset?
Does UML rely on /proc or any other such filesystems on host?
This is assuming that we want all possible features inside UML.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
