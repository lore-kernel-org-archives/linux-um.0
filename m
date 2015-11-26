Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1a1tB0-00017E-M7
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Nov 2015 09:49:18 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a1tAz-0004ub-Hj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Nov 2015 09:49:18 +0000
Message-ID: <5656D596.4060906@kot-begemot.co.uk>
Date: Thu, 26 Nov 2015 09:49:10 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
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
Subject: [uml-devel] Old process in D state bug
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
Cc: Richard Weinberger <richard@nod.at>

Hi List, hi Richard,

While working on the EPOLL I managed to consistently reproduce and get 
down to the bottom of the process in D state bug which you occasionally 
see with UML. I recall asking Richard's help on this for the first time 
nearly 5 years ago ;-).

It is extremely rare with the POLL based controller, timers and the 
stock UBD drivers. As you make things go faster (anywhere in UML) it 
rares its ugly head. So improving the IRQs, improving UBD itself, etc - 
all make it easier to trigger.

It looks like it is possible to end up in a state where the restart list 
is not empty (an earlier transaction to the disk io thread failed with 
EAGAIN), but with no pending IO on the UBD IPC thread fd. So the restart 
list is never re-triggered and the UBD device ends up with a non-empty 
queue. The process that requested the IO ends up in D state. Any other 
processes trying IO to the same disk join it. As the requests to the 
same UBD queue up, ultimately, UML goes belly up.

Pinging the UML process with SIGIO does not help as there is no IO 
pending on the fd. So it is not a lost interrupt. It somehow manages to 
race forming the restart queue.

If, however, you have more than one UBD device IO to the other one 
unstucks it by re-running the restart queue out of the ubd interrupt 
handler.

Once again - this is extremely rare at present, but possible (I have 
seen it a few times over the last 5 years).

So it needs a viable fix or a workaround. I will have to get this one 
out of the door first as it constantly gets in the way in debugging both 
the Epoll and the signals stuff.

A.

------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741551&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

