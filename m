Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK1Hp-00041O-EM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:54:15 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HK1Ho-0005r8-Te
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:54:13 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 22 Feb 2007 00:54:04 +0100
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702220054.04938.blaisorblade@yahoo.it>
Subject: [uml-devel] When opening /tmp/uml.ctl fails, what do we get?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

I started uml_daemon as root by mistake, so /tmp/uml.ctl even if /dev/net/tun 
was world-readable. Ok, I did it. This is the result (after trying many times 
to do 'ifconfig eth0 up' inside UML):

[42949710.290000] Choosing a random ethernet address for device eth0
[42949710.290000] Netdevice 0 (3a:9d:6f:12:83:b2) : daemon backend (uml_switch 
version 3) - unix:/tmp/uml.ctl
[42949710.290000] daemon_open : control connect failed, errno = 13
(13 = EPERM)
[42949720.360000] Registering fd 0 twice
[42949720.360000] Irqs : 2, 5
[42949720.360000] Ids : 0x0000000061a795f8, 0x0000000061d181c0
[42949720.360000] uml_net_open: failed to get irq(-12)

(-12 is -ENOMEM, not -13 + 1, but is caused by 'registering XXX twice').

[42949720.360000] Registering fd 0 twice
[42949720.360000] Irqs : 2, 5
[42949720.360000] Ids : 0x0000000061a795f8, 0x0000000061d181c0
[42949720.360000] uml_net_open: failed to get irq(-12)

Looking into the code, I saw that:
1) daemon_user_init is confusing because it saved any error into pri->fd, 
instead of returning it to the caller. Also, it would make sense to move this 
into daemon_open.
2) connect_to_switch uses the same errno twice - it shouldn't, and we're 
hitting this. um_interrupt is called with fd => 0 because errno is cleared 
after printk (verified under debugging, I did not trace it fully to where 
it's changing but it's sufficient for a patch anyway).
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
