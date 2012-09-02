Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <PeterHuewe@gmx.de>) id 1T8GzT-0005l3-4z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Sep 2012 20:41:55 +0000
Received: from mailout-de.gmx.net ([213.165.64.22])
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1T8GzS-0005NF-7z for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Sep 2012 20:41:55 +0000
From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Sun, 2 Sep 2012 22:45:20 +0200
MIME-Version: 1.0
Message-Id: <201209022245.20413.PeterHuewe@gmx.de>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Emulate I2C subsystem/slaves
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I'm curious if there have ever been any attempts to emulate i2c devices under 
uml in order to facilitate driver development by using stub drivers.

If there weren't any attemps yet, what to you thing would be the best strategy  
to achieve this goal?
Are there any good starting points? 
The main thing I'm lacking is a good idea how to register the 'stub devices'.

Or is this something that is not really desired by the uml project?

Thanks,
Peter


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

