Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOhWC-0002Be-He for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 May 2004 11:34:48 -0700
Received: from web25106.mail.ukl.yahoo.com ([217.12.10.54])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BOhWB-00045H-Va for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 May 2004 11:34:48 -0700
Message-ID: <20040514182447.56774.qmail@web25106.mail.ukl.yahoo.com>
From: =?iso-8859-1?q?maria=20maria?= <for_spam2004@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] Implementing 802.11...
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
Date: Fri, 14 May 2004 20:24:47 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

Hi,
I'm  developing an implementation of 802.11 inside
UML, to make it able to emulate a wireless lan.
I'm modifing the "daemon_read" and "daemon_write"
functions inside "daemon_kern.c".

In "daemon_write":
before to send a packet, I enlarge it and I insert the
new 802.11 header. Then I put it in a list of sk_buff,
and if the channel is free, I send the packet. By now
I'm just triing to put the sk_buff packet in a list
and to send it immediatly, whithout run a collision
avoidance algorithm. 

In "daemon_read"
At the arrival of a packet, I extract the 802.11
header, I compress the packet deleting the bytes 
concerning the 802.11 header, and I manage the packet
following the protocol (send ack or cts, etc...)
By now it just sends an ACK for each not broadcast
packet it receives.

My question is: I'm having some problems in managing
the sk_buff structures: using the functions in
sk_buff.h, I have a kernel panic :

Warning: kfree_skb passed an skb still on a list (from
a0126b3b)
Kernel panic: kernel BUG at skbuff.c:316!

Does someone have some idea about the cause of this
problem?

Thank in advance,

Maria
 



	

	
		
____________________________________________________________
Yahoo! Companion - Scarica gratis la toolbar di Ricerca di Yahoo! 
http://companion.yahoo.it


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
