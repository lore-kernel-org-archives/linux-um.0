Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D70cf-000804-AT for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 16:24:53 -0800
Received: from mail.scgiservices.com ([198.107.3.67])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D70cP-0004jS-Ly
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 16:24:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 9B6022881B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  3 Mar 2005 16:24:32 -0800 (PST)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 12943-08 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  3 Mar 2005 16:24:27 -0800 (PST)
Received: from SCG2 (c-67-160-159-191.client.comcast.net [67.160.159.191])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 1BADB2881A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  3 Mar 2005 16:24:26 -0800 (PST)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Message-ID: <OJEEKGNKKDLJIEPBEJMIAEIOCAAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] SKAS3 v8 for x86_64
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
Date: Thu, 3 Mar 2005 16:24:25 -0800
To: user-mode-linux-devel@lists.sourceforge.net

Recently some individuals posted a "port" of the SKAS 3 patch to x86_64.
However, this port was for the 2.4 kernel. Has anyone worked on porting SKAS
3 (especially v7 or v8) to the x86_64 architecture on 2.6 kernel? Is this
even on the radar for the current developers?

Thanks!

Tony



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
