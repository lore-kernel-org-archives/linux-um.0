Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IadzR-0008BT-7s for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 14:00:13 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user5475)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IadzQ-0003ER-MK
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 14:00:13 -0700
From: Nix <nix@esperi.org.uk>
Date: Wed, 26 Sep 2007 21:59:47 +0100
Message-ID: <87ejglqh18.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: [uml-devel] Is commit da3e30e78ed9652322dccb49fa149e7b4e985f74 a
	candidate for -stable?
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
Cc: Jeff Dike <jdike@addtoit.com>

Without this commit, you can't compile UML on a system with 2.6.22
kernel headers (the reserved2 and reserved3 fields have been
renamed). With it, you can use 2.6.22 or older as you like.

(not forwarding to -stable because it seems importunate of me to do so:
is this being too cautious?)

-- 
`Some people don't think performance issues are "real bugs", and I think 
such people shouldn't be allowed to program.' --- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
