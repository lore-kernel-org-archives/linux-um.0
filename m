Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DloXx-0006bE-82	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 06:48:41 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DloXv-0002ma-Cj	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 06:48:40 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Linking  .tmp_vmlinuux1 fails with 2.6.12-mm1
Message-ID: <20050624134316.GB4117@ccure.user-mode-linux.org>
References: <42BBA6F1.9080704@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BBA6F1.9080704@gmx.de>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 24 Jun 2005 09:43:16 -0400
To: Raphael Bossek <raphael.bossek@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jun 24, 2005 at 08:23:45AM +0200, Raphael Bossek wrote:
> after applying the TT_MODE build patch I run into the following problem
> with linux 2.6.12-mm1:

> arch/um/sys-i386/built-in.o(*ABS*+0x73c706fe): In function `__crc_kunmap':
> module.c: multiple definition of `__crc_kunmap'
> arch/um/sys-i386/built-in.o(*ABS*+0xe7c48b45): In function 
> `__crc_kmap_atomic':
> module.c: multiple definition of `__crc_kmap_atomic'
> arch/um/sys-i386/built-in.o(*ABS*+0x1889f5f3): In function 
> `__crc_kmap_atomic_to_page':
> module.c: multiple definition of `__crc_kmap_atomic_to_page'
> arch/um/sys-i386/built-in.o(*ABS*+0xd837acb7): In function `__crc_kmap':
> module.c: multiple definition of `__crc_kmap'
> collect2: ld returned 1 exit status

You failed to mention the zillion errors from make config that resulted
from trying to use the host's config rather than UML's defconfig.

Run mrproper, cp arch/um/defconfig .config, then rebuild as before.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
