Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HqF26-0006M6-Dj for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 May 2007 14:03:10 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HqF24-00005i-SV
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 May 2007 14:03:10 -0700
Date: Mon, 21 May 2007 16:56:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070521205647.GA9929@c2.user-mode-linux.org>
References: <465052A5.9020602@free.fr>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <465052A5.9020602@free.fr>
Subject: Re: [uml-devel] [PATCH] User-mode Linux: Port driver host system
	independence strengthened.
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
To: Jean-Yves Didier <jydidier@free.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, May 20, 2007 at 03:52:37PM +0200, Jean-Yves Didier wrote:
> 
> Port driver no longer need a telnet daemon and port-helper at fixed 
> locations on the host system. Fixed locations are still checked. If 
> detection failed, it will look for links or programs named uml.telnetd 
> and port-helper in user pathes list.

I suppose... I take it this is useful when you can't convince your
system manager to install stuff?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
