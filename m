Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JOiEU-00059M-TW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Feb 2008 15:38:43 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JOiET-0001Lu-DL
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Feb 2008 15:38:42 -0800
Date: Mon, 11 Feb 2008 18:38:36 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080211233836.GB11499@c2.user-mode-linux.org>
References: <1202672982.28562.2.camel@localhost>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1202672982.28562.2.camel@localhost>
Subject: Re: [uml-devel] [PATCH] uml: Fix calls of helper_wait in
	harddog_user.c
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
To: Johann Felix Soden <johfel@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Feb 10, 2008 at 08:49:42PM +0100, Johann Felix Soden wrote:
> From: Johann Felix Soden <johfel@users.sourceforge.net>
> 
> In 1aa351a308d2c3ddb92b6cc45083fc54271d0010 the arguments of helper_wait() were
> changed. The adaptation of harddog_user.c was forgotten, so this errors occur:
> 
> /arch/um/drivers/harddog_user.c: In function 'start_watchdog':
> /arch/um/drivers/harddog_user.c:82: error: too many arguments to function 'helper_wait'
> /arch/um/drivers/harddog_user.c:89: error: too many arguments to function 'helper_wait'

Another one that was spotted (this time by Al Viro) and a patch
produced and ignored.  I'll take care of this one too.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
