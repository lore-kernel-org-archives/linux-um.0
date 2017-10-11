Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1e2CKf-0004rC-QU for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 11 Oct 2017 08:25:37 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1e2CKe-0006MN-5D
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 11 Oct 2017 08:25:37 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Wed, 11 Oct 2017 09:25:24 +0100
Message-Id: <20171011082526.30692-1-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] PATCH v7
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

This is hopefully the final parking position. It has been cleaned up,
updated to fit the current netdev warning/info message conventions
and no longer hangs if the underlying network hard xmit misbehaves.

The issue with raw sockets is a definitive BUG - I have gone through
it with a comb several times, including sticking debug into the
actual host af_packet itself. If you try to give af_packet.c a TSO
frame it does something to it which makes the TSO capable underlying
device drop it. The same frame passes tap with flying colors.
Go figure.

A.


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

