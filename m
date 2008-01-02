Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JA9rB-0005H4-Dl for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 12:06:29 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JA9r9-0000Rc-ON
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 12:06:29 -0800
Date: Wed, 2 Jan 2008 15:06:21 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080102200621.GB8847@c2.user-mode-linux.org>
References: <E1JA7m0-0007nP-Fi@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1JA7m0-0007nP-Fi@pomaz-ex.szeredi.hu>
Subject: Re: [uml-devel] UML woes in 2.6.24-rc6-mm1
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 02, 2008 at 06:53:00PM +0100, Miklos Szeredi wrote:
> The below patch was needed to make UML compile in latest -mm.

ACK on that - I've got the same patch on its way.

> But sometimes it doesn't boot and does weird things (this is a sample
> with init=/bin/bash):

> (none):/# ls
> Segmentation fault
> (none):/# ls -l
> : : No such file or directory

Huh.  No problems here - I've got rc6-mm1 happily doing kernel builds.

Is this 32 or 64-bit?

Can you double-check that you have a clean pool and a clean build, etc?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
