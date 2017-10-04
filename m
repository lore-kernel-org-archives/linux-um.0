Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1dzksH-00067m-5r for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 04 Oct 2017 14:42:13 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dzksE-0006tL-MF
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 04 Oct 2017 14:42:13 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Wed,  4 Oct 2017 15:41:58 +0100
Message-Id: <20171004144200.24816-1-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] PATCH v4
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard.weinberger@gmail.com

This update cleans up the code and simplifies the xmit routines to
share some of the code. It also brings tap up to date to do scatter
gather and TSO on transmit. The result is ... drum roll... 4.5Gbit+
on iperf on my laptop. As a reference QEMU+kvm with all bells and
whistles does under 1GBit and LXC with vEth does ~ 20GBit.

TSO on RX is still not implemented - this is XMIT only.

The same code should also work for raw, but it does not. It looks
like a BUG in the actual linux af_packet.c raw socket implementation.
I am probably going to implement TSO on RX so I have a full frame
of reference to see if the RX TSO in raw sockets is broken (or not)
next. So for the time being raw does only checksums.

I will try to find some time to add Geneve and VXLAN to this. It will
be after I figure out RAW and TSO on RX for RAW and TAP.

Brgds,

A.



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

