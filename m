Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6EHj-00046J-SI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 11:43:31 -0800
Received: from mailgate.uni-paderborn.de ([131.234.22.32])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1B6EHi-0008PJ-8P
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 11:43:30 -0800
Message-ID: <4061E412.3060305@upb.de>
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] [RFE] con=port
References: <Pine.LNX.4.44.0403242025580.1316-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0403242025580.1316-100000@filer.marasystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 24 Mar 2004 20:40:02 +0100
To: Henrik Nordstrom <hno@marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

>>Another point would be security. Even if UML only binds to 127.0.0.1, 
>>the port is accessable by any user logged in. But i have no clever idea 
>>for that.
> 
> The solution to that is to not use TCP. Use named pipes instead.

But that limits the clients to Applications that support named pipes. I 
think telnet doesn't, and the Java-Application that i had in mind 
wouldn't too.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
