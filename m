Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J2o86-0005rr-IB for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Dec 2007 05:29:34 -0800
Received: from 62-101-88-9.ip.fastwebnet.it ([62.101.88.9]
	helo=mail.dasistemi.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J2o85-00012x-2v
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Dec 2007 05:29:34 -0800
Message-ID: <4761327D.8020301@dasistemi.it>
Date: Thu, 13 Dec 2007 14:24:13 +0100
From: tcappellari <tcappellari@dasistemi.it>
MIME-Version: 1.0
Subject: [uml-devel] Serial Line ioct and set_termios bypassing
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hi,
I'm developing an application that I want to run inside UML system. This 
application use the serial line, and I need to set/reset the control 
signals RTS/DTR and read CTS/DSR and also I need to set up the baud rate.
Into UML kernel the line_ioctl and line_set_termio functions are 
essentialy empty, so I guess that what I need is intentionally not 
implemented for divide the Guest system from the Host. (please correct 
me if I wrong).

Anyway I need to know if it's possible to implement this functions, 
maybe bypassing the UML system, or something like that.
If possible, any suggestions?

Thanks,
Tiziano.




-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
