Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOZrn-0000Pm-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 25 Nov 2003 01:52:19 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AOZrm-0000En-Ic
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 25 Nov 2003 01:52:18 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Ethernet
In-Reply-To: <20031125084850.38456.qmail@web86105.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.44.0311251028360.29093-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 25 Nov 2003 10:52:10 +0100 (CET)
To: =?iso-8859-1?q?mariachiara=20letardi?= <mchiaraletardi@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 25 Nov 2003, mariachiara letardi wrote:

> wireless context. Does anybody know wich are the parts
> of code which provide the emulation of layer 2

That would be the UML network drivers.

> and which are the functions emulated (CSMA/CD, CRC,
> etc...)

Neither really. The intention of the UML network drivers is not to emulate
the physical properties of a Ethernet segment but to provide transport of
Ethernet or IP frames between UMLs and/or the host.

routed, bridged, switched and broadcast transports are provided at the
frame level.

In all cases the transmission layer is full-duplex with flow control.

The exact details varies a little depending on what transport type is used 
(virtual ethernet switch, TAP connection to the host or TUN connection to 
the host)

> and if is somewhere available some documentation about these parts of code?

It is a fairly standard Linux networking driver but using a socket or
tun/tap device for transmission rather than hardware. Each of these
"physical" transports are full-duplex with flow control.

There is however packet loss from two sources:

a) If the UML sends packets too fast (faster than the host/virtual switch
can receive the packets) the transmit queue will overflow, eventually the
flow control rejects the UMLs send requests. This condition is detected by
the UML driver and signalled back to the sending protocol in the kernel
much like a CD situation.

b) If the network is congested then the connection point (host or virtual
ethernet switch) may drop packets. Such events is not signalled back to
the sender.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
