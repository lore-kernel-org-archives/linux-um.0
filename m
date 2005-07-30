Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dyx5W-0003mW-0S	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:33:38 -0700
Received: from pfepc.post.tele.dk ([195.41.46.237])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1Dyx5T-000360-OH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:33:38 -0700
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20050730193532.GA19768@mars.ravnborg.org>
References: <20050730190534.6FB5B843@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730190534.6FB5B843@zion.home.lan>
Subject: [uml-devel] Re: [patch 1/3] uml: add dwarf sections to static link
	script
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
Date: Sat, 30 Jul 2005 21:35:32 +0200
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Jul 30, 2005 at 09:05:33PM +0200, blaisorblade@yahoo.it wrote:
> 
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Inside the linker script, insert the code for DWARF debug info sections. This
> may help GDB'ing a Uml binary. Actually, it seems that ld is able to guess
> what I added correctly, but normal linker scripts include this section so it
> should be correct anyway adding it.

Can we please have this added to include/asm-generic/vmlinux.lds.h so we
can share the definition.

	Sam


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
