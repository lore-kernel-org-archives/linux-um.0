Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyxEG-0004D2-Nw	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:42:40 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1DyxEC-0006EX-9Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:42:40 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050730190534.6FB5B843@zion.home.lan>
	<20050730193532.GA19768@mars.ravnborg.org>
In-Reply-To: <20050730193532.GA19768@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507302147.06440.blaisorblade@yahoo.it>
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
Date: Sat, 30 Jul 2005 21:47:05 +0200
To: Sam Ravnborg <sam@ravnborg.org>
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Saturday 30 July 2005 21:35, Sam Ravnborg wrote:
> On Sat, Jul 30, 2005 at 09:05:33PM +0200, blaisorblade@yahoo.it wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > Inside the linker script, insert the code for DWARF debug info sections.
> > This may help GDB'ing a Uml binary. Actually, it seems that ld is able to
> > guess what I added correctly, but normal linker scripts include this
> > section so it should be correct anyway adding it.

> Can we please have this added to include/asm-generic/vmlinux.lds.h so we
> can share the definition.
Hmm, I'm going to leave for now, so I won't be able to handle this soon. If 
you can do that it'd be nice. Thanks and sorry for this request.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
