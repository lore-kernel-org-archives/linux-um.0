Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFdYK-0006xA-50	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 13:08:20 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EFdYH-0007xw-Gh
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 13:08:20 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] pcap
References: <1126653933.3769.45.camel@localhost>
	<1126729188.3769.49.camel@localhost>
In-Reply-To: <1126729188.3769.49.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509142206.12128.blaisorblade@yahoo.it>
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
Date: Wed, 14 Sep 2005 22:06:11 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: antoine <antoine@nagafix.co.uk>

On Wednesday 14 September 2005 22:19, antoine wrote:
> On some setups, when trying to bring up a pcap interface I get (in
> dmesg):
> [42949414.170000] dev_ip_addr - device not assigned an IP address
I'd care more to this one probably. Especially because you say "on some 
setups". It should refer to the host interface (don't know which one).
> [42949414.170000] pcap_open : pcap_compile failed - 'syntax error'
This could be bogus.
> [42949414.170000] device eth1 entered promiscuous mode
> [42949414.170000] dev_ip_addr - device not assigned an IP address
> [42949414.170000] pcap_open : pcap_compile failed - 'syntax error'
>
> Any clues? What's this syntax error?

> Thanks
> Antoine
It'd be on the PCAP filter expression (there's a parameter for that), assuming 
the message is correct.

If you find no other explaination, I'll look if UML is passing a bogus string 
there - however check the rest first.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
