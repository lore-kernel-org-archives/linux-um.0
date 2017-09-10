Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1dqwXP-0005f1-8X for user-mode-linux-devel@lists.sourceforge.net;
 Sun, 10 Sep 2017 07:20:15 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dqwXO-0006BT-3D
 for user-mode-linux-devel@lists.sourceforge.net;
 Sun, 10 Sep 2017 07:20:15 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Sun, 10 Sep 2017 07:35:08 +0100
Message-Id: <20170910063510.685131-1-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] Updated Epoll and Vector Network Driver
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

Hi Richard, hi list,

Attached is an updated and rebased versus 4.13 patchset for the
Epoll based IRQ controller and Vector Network driver.

I have been running a backport to OpenWRT/kernel 4.4 since around
May and I have not found any bugs so far. It appears stable and
performs up to 3-4 times better than the existing UML network and
IO.

New in this patchset:

1. VNET header support and checksum offloads in the raw socket
transport.
2. Scatter/Gather has been folded into the main vector patchset.


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

