Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVVjE-000250-53 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 10:10:16 -0700
Received: from mailout.stusta.mhn.de ([141.84.69.5] helo=mailhub.stusta.mhn.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IVVjC-0006Sh-M8
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 10:10:16 -0700
Date: Wed, 12 Sep 2007 19:09:30 +0200
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20070912170930.GA3563@stusta.de>
References: <46E81AC6.3000306@googlemail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46E81AC6.3000306@googlemail.com>
Subject: Re: [uml-devel] [1/4] 2.6.23-rc6: known regressions
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
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Adrian Bunk <bunk@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Sep 12, 2007 at 06:58:46PM +0200, Michal Piotrowski wrote:
> Hi all,
>...
> Subject         : uml on x86_64 compile error
> References      : http://lkml.org/lkml/2007/9/3/86
> Last known good : ?
> Submitter       : Adrian Bunk <bunk@kernel.org>
> Caused-By       : Jeff Dike <jdike@linux.intel.com>
>                   commit d1254b12c93e1e586137a2ffef71fd33cf273f35
> Handled-By      : ?
> Status          : unknown

This one was fixed by commit 980abe215b861891c39aba0936817c46f372143b

> Regards,
> Michal

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
