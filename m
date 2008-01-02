Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JABiQ-0001QP-IO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 14:05:34 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JABiO-0004nC-Vv
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 14:05:34 -0800
Date: Wed, 2 Jan 2008 17:05:19 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080102220519.GA10137@c2.user-mode-linux.org>
References: <E1JA7m0-0007nP-Fi@pomaz-ex.szeredi.hu>
	<20080102200621.GB8847@c2.user-mode-linux.org>
	<E1JAAZt-0008F8-An@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1JAAZt-0008F8-An@pomaz-ex.szeredi.hu>
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

On Wed, Jan 02, 2008 at 09:52:41PM +0100, Miklos Szeredi wrote:
> 32bit UML, 64bit host, config attached.

Hadn't tried that, but that works here too.

I'll see if your config reproduces it.

> Can't reproduce with plain -rc6.

Feel like bisecting -mm1?

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
