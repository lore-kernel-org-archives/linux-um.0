Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbiL1-0000yL-Ef for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 08:37:19 -0800
Received: from web26103.mail.ukl.yahoo.com ([217.12.10.227])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CbiL0-00036M-Q0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 08:37:19 -0800
Message-ID: <20041207163711.8475.qmail@web26103.mail.ukl.yahoo.com>
From: Roland Kaeser <roli8200@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] No DNS resolution on uml guest
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
Date: Tue, 7 Dec 2004 17:37:11 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net

Hello All

I have a very strange behaviour on a uml guest system. 
The guest os (Fedora 2) cannot make any name resolution but the "normal" network
works properly.
I'm using the guest file system which i have snapshoted from a special installation
on a "real" machine. The guest file system and the machine installation have exactly
the same files. When I try to make the dns resolution on the original machine it
works well.  The resolution on the uml guest doesn't works event when the whole
package filter (iptables) is disabled and set to accept.
I use a linux bridge to communicate with the outside world.

Roland


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
