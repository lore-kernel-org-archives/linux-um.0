Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMO0O-0002sz-F4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 03:29:28 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FMO0N-0008EC-6x
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 03:29:27 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200603230317.48384.blaisorblade@yahoo.it>
References: <200603230317.48384.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1143113374.17079.6.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: TLS support - status - need for re-testing
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
Date: Thu, 23 Mar 2006 11:29:34 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

> Has anyone got success or failure with TLS code on 32-bit machines on 64-bit 
> hosts?
I believe FC4 and FC5 x86 still fail with tls errors during fsck. Not
sure why. (images on my site)
All the other images were completely rebuilt in the last 2 months and
none of them have had their /lib/tls moved out of the way, so I assume
that glibc uses tls and all these images seem to work fine.

> More important: has anyone tested that?
I thought i had... but maybe not.

Antoine



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
