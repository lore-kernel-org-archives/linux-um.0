Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQQu9-0004Ze-QZ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Nov 2004 05:46:57 -0800
Received: from [217.204.41.189] (helo=kula.newsnow.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CQQu9-0003fD-65
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Nov 2004 05:46:57 -0800
Received: from r3bh172.chello.upc.cz ([213.220.251.172] helo=[192.168.2.10])
	by kula.newsnow.net with esmtp (Exim 3.35 #1 (Debian))
	id 1CQQu6-0004nw-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 06 Nov 2004 13:46:54 +0000
Message-ID: <418CD5CD.2060504@praguespringpeople.org>
From: Struan Bartlett <struan@praguespringpeople.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] con0=pty '/dev/ttpy0: device or resource busy' bug?
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
Date: Sat, 06 Nov 2004 14:46:53 +0100
To: user-mode-linux-devel@lists.sourceforge.net

My thanks to everyone who's contributed to UML - it is a wonderfully useful
thing.

I need to run uml xterm-free and tty-free so 'm running uml with:

# linux con=pty

When I disconnect 'minicom' from /dev/ttyp0 and reconnect, minicom says:

# minicom
minicom: cannot open /dev/ttyp0: Device or resource busy

When I disconnect 'minicom' from /dev/ttyp1 or /dev/ttyp2 and reconnect, minicom connects just fine.

Is this a known bug?

Regards,

Struan Bartlett




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
