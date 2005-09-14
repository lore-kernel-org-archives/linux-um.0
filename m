Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFdox-0007jZ-SB	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 13:25:31 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFdow-0002rP-Gf
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 13:25:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 2387A4576D
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Sep 2005 03:32:07 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10211-08 for <user-mode-linux-devel@lists.sourceforge.net>;
 Thu, 15 Sep 2005 03:32:06 +0100 (BST)
Received: from [192.168.0.3] (host-87-74-41-116.bulldogdsl.com [87.74.41.116])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 2BCD94576C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Sep 2005 03:32:06 +0100 (BST)
Subject: Re: [uml-devel] pcap - FIXED
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <200509142206.12128.blaisorblade@yahoo.it>
References: <1126653933.3769.45.camel@localhost>
	 <1126729188.3769.49.camel@localhost>
	 <200509142206.12128.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1126730694.3769.58.camel@localhost>
Mime-Version: 1.0
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
Date: Wed, 14 Sep 2005 21:44:54 +0100
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

> > [42949414.170000] dev_ip_addr - device not assigned an IP address
Yes, I was wondering about this one. The device has got an IP assigned
and it is up...
> I'd care more to this one probably. Especially because you say "on some 
> setups". It should refer to the host interface (don't know which one).
> > [42949414.170000] pcap_open : pcap_compile failed - 'syntax error'
> This could be bogus.
Actually it isn't. This forced me to check my syntax...
> > [42949414.170000] device eth1 entered promiscuous mode
> > [42949414.170000] dev_ip_addr - device not assigned an IP address
> > [42949414.170000] pcap_open : pcap_compile failed - 'syntax error'
> It'd be on the PCAP filter expression (there's a parameter for that), assuming 
> the message is correct.
> 
> If you find no other explaination, I'll look if UML is passing a bogus string 
> there - however check the rest first.
Thanks. Found it, the startup scripts on the broken setups were passing
a 'null' filter expression (from a database) rather than leaving it
empty. Works fine now.

Sorry for the line noise...

Antoine



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
