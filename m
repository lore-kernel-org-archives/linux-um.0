Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9QNQ-0005TQ-DV for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 12:00:28 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user32700)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9QNO-0000Ts-AP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 12:00:27 -0700
References: <20070713143755.GA6244@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Fri, 13 Jul 2007 20:00:13 +0100
In-Reply-To: <20070713143755.GA6244@c2.user-mode-linux.org> (Jeff Dike's
	message of "Fri, 13 Jul 2007 10:37:55 -0400")
Message-ID: <87odigw2ma.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/3] UML - Limit request size on COWed devices
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 13 Jul 2007, Jeff Dike uttered the following:

> COWed devices can't handle more than 32 (64 on x86_64) sectors in one
> request due to the size of the bitmap being carried around in the
> io_thread_req.

This feels like a -stable candidate to me.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
