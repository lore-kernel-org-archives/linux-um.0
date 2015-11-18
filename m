Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZyyBW-0005Xk-8L
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 08:33:46 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZyyBU-00044I-G0
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 08:33:46 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZyyBN-0002j8-5u
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 08:33:37 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZyyBM-0000I7-T6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 08:33:36 +0000
Message-ID: <564C37E0.6080204@kot-begemot.co.uk>
Date: Wed, 18 Nov 2015 08:33:36 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1447079597-17816-1-git-send-email-aivanov@brocade.com>	<5640B5B5.7050907@kot-begemot.co.uk>	<1447274788.48401.3.camel@m3y3r.de>	<CAFLxGvyEs9MAYMiX1GseJAVt0oKzMyRou6OPOFEg2hh0w3+kog@mail.gmail.com>	<56448624.7020606@brocade.com>
	<5644AEE9.8060105@kot-begemot.co.uk> <5644B820.8020601@brocade.com>
	<56498F4C.6080706@kot-begemot.co.uk>
In-Reply-To: <56498F4C.6080706@kot-begemot.co.uk>
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
Subject: Re: [uml-devel] [PATCH v2] EPOLL Interrupt Controller V2.0
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,

I have looked through this and I still have not figured it out 
completely. Moving from the old poll controller to the new epoll one 
triggers deep recursive invocations of the interrupt handlers. I still 
do not understand why it does it so I will park it for now and come back 
to it next week.

I did, however, find a number of small issues. Namely, various patches 
and fixes over the years have used calls to block/unblock signals and 
block/unblock irqs in a few places where these can create a recursion 
race (even with the old controller).

If I understand os-Linux/irq.c correctly, block/unblock in UML does not 
block or unblock the signals. It blocks/unblocks the processing of them 
and unblock can (and will) result in the immediate processing any 
pending signals. So in most places, that should not be block/unblock 
(and respectively local_irq_enable/local_irq_disable which invoke that). 
It should be save+block and restore. Otherwise you recurse by invoking 
the IRQ handler the moment you unblock_signals().

Additionally, if you want just to wait and be interrupted by a signal, 
you do not need to enable/disable IRQs - signals are always received at 
present. If I understand the situation correctly, irq on/off only 
changes if they are processed or not.

I am going to roll my tree back to the timer patch now and go through 
the ones I found so far one by one and submit them separately. Once that 
is out of the way we can look again at the epoll controller patch. It 
has potential, but it makes all gremlins come out of the woodwork so we 
might as well get the gremlins out of the way first.

[snip]

A.

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

