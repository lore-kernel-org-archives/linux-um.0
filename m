Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQphM-0001RE-6i for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 08:43:08 -0700
Received: from ns1.auto.ucl.ac.be ([130.104.239.135] helo=zlop.auto.ucl.ac.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQphL-0002Jz-SP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 08:43:08 -0700
Received: from auto.ucl.ac.be (pc-babaorom.auto.ucl.ac.be [130.104.239.234])
	by zlop.auto.ucl.ac.be (Postfix) with ESMTP id 3E8A6A4A86
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 20 May 2004 17:42:55 +0200 (CEST)
Message-ID: <40ACE964.9070004@auto.ucl.ac.be>
From: Vincent Guffens <guffens@auto.ucl.ac.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [announce] a wifi layer for UML
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
Date: Thu, 20 May 2004 19:22:44 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I'm working on a wireless network simulator project based on UML. The 
idea is to use an existing 802.11 driver and to port it to UML. Every 
UML machines running this driver are then interconnected by way of a 
simulator server which emulates the physical transmission. A GUI is also 
provided to visualise the virtual machines in a 2-dimensional world.

The driver is the hostap driver and nearly runs unmodified. The pci 
layer of the driver has been modified to use what I called 'netbus' 
which is a simple bus implementation replacing a pci bus.

This netbus code (available as a patch against linux-2.4.24-um1) exports 
some symbols similar to those exported by the pci layer like 
netbus_register_driver and so on. There is also the possibility to 
read/write byte and word with netbus_readb netbus_writeb.

Netbus connects to the emulated hardware card by way of two tcp/ip 
connections. One connection is used to transmit the read/write commands 
and the other is only used by the card to emit interrupt signals.

The card is emulated in the simulator server writen in QT/C++. Although 
the implementation of the card is minimal, it is enough to fool the 
driver and to have it to initialise a wlan0 interface with wireless 
extension ! You can then ssh through the air between two machines and 
see your packets flying between the machines.


For those interested in trying it :
http://www.auto.ucl.ac.be/~guffens/uml-wifi/index.html


Regards,


-- 
				Vincent Guffens
				PhD Student UCL/CESAME
				tel:   +32 10 47 80 30
Value your freedom, or you will lose it, teaches history.
"Don't bother us with politics," respond those who don't want to learn.
	      	-- Richard M. Stallman



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
