Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DvcWn-0006WW-9U	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2005 08:00:01 -0700
Received: from rgminet04.oracle.com ([148.87.122.33])
	by sc8-sf-mx2.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1DvcWl-0002wC-52
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2005 08:00:01 -0700
Received: from rgmgw1.us.oracle.com (rgmgw1.us.oracle.com [138.1.191.10])
	j6LExn5o006944	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 21 Jul 2005 08:59:50 -0600
Received: from rgmgw1.us.oracle.com (localhost [127.0.0.1])
	j6LExnZn020321	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 21 Jul 2005 08:59:49 -0600
Received: from web265.oracle.com (web265.oracle.com [148.87.122.175])
	j6LExnVK020316	for <user-mode-linux-devel@lists.sourceforge.net.>;
	Thu, 21 Jul 2005 08:59:49 -0600
Message-ID: <21786771.1121957989655.JavaMail.oracle@web265.oracle.com>
From: allan.graves@oracle.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Best way to debug?
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
Date: Thu, 21 Jul 2005 14:59:49 +0000 (GMT)
To: user-mode-linux-devel@lists.sourceforge.net

This is a question to you kernel developers...  when using UML, what's teh best way to debug a kernel panic?  Get UML to generate a core?  Setup netdump or some such?  How do you guys usually do it?
Allan



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
