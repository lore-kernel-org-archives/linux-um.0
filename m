Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1Vm2m8-0001qT-5r
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 14:41:04 +0000
Received: from natasha.panasas.com ([209.166.131.148])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vm2m7-0005tf-9X for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 14:41:04 +0000
Message-ID: <529755F0.80509@panasas.com>
Date: Thu, 28 Nov 2013 16:40:48 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
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
Subject: [uml-devel] x86_64 when mem > 384M loadable modules do not work
To: Richard Weinberger <richard@nod.at>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi um hackers

I'm using an x86_64 deployment both host and um-guest.
(Fedora 18)

When I load with mem=384M all is well but anything bigger will
eventually give me problems because loadable modules will no
longer load. The bigger mem= is, the earlier it will start.

When the Kernel tries to load the .ko driver I get these messages:

subarch: overflow in relocation type 11 val 805b1e40
subarch: `nfsv4' likely not compiled with -mcmodel=kernel
subarch: overflow in relocation type 11 val 806e4ca0
subarch: `nfsv3' likely not compiled with -mcmodel=kernel
   ...

(The first print is always around that same number
 805b1e40 independent of the mem= (> 384M) 
)

Do you guys see the same problem? I'm using loadable modules
because it is kind of mandatory for the kind of development I
do.

Please help because 384M is not enough for me anymore, even
when I define a swap device for the uml to use.

Thanks in advance
Boaz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

