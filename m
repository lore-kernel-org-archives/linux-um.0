Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJy9o-0001SC-ML for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Apr 2005 11:24:40 -0700
Received: from relay00.pair.com ([209.68.1.20] helo=relay.pair.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DJy9n-0005BA-6S for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Apr 2005 11:24:40 -0700
Message-ID: <4256CC5D.2090106@benrey.is-a-geek.net>
From: Jed Reynolds <lists@benrey.is-a-geek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] pty channel
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
Date: Fri, 08 Apr 2005 11:24:29 -0700
To: user-mode-linux-devel@lists.sourceforge.net

Question about connecting ptys. I've tried specifying various ssl 
options to try to connect to serial lines but I don't see any boot 
messages saying any ptys are being allocated. Am I missing something?

Host and guest are Linux 2.6.11.6 vanilla.

linux root=/dev/ubda ubda=root_fs ubdh=swap \
        con=null con0=fd:0,fd:1 ssl=pty ssl0=pty ssl1=pty \
        umid=monster \
        eth0=tuntap,tap1,,192.168.50.23

in the guest's inittab, I have
s0:2345:respawn:/sbin/agetty ttyS0 115200,9600 linux
s1:2345:respawn:/sbin/agetty ttyS1 115200,9600 linux

 # bin/linux --showconfig | grep -i tty
CONFIG_TTY_CHAN=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_PPP_SYNC_TTY=m
                                                                                                                                                                        

[root@jeeves] /home/uml
 # bin/linux --showconfig | grep -i pty
CONFIG_PTY_CHAN=y
CONFIG_SSL_CHAN="pty"
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
