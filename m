Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPVQ8-0002rQ-2F for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 16:24:08 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CPVQ5-0003WK-Rp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 16:24:07 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to
	kill host-OS processes (take #2)
References: <20041103113736.GA23041@taniwha.stupidest.org>
	<20041103201836.GB29289@bytesex>
	<20041103204812.GA11010@taniwha.stupidest.org>
In-Reply-To: <20041103204812.GA11010@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040123.49624.blaisorblade_spam@yahoo.it>
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
Date: Thu, 4 Nov 2004 01:23:48 +0100
To: Chris Wedgwood <cw@f00f.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>

On Wednesday 03 November 2004 21:48, Chris Wedgwood wrote:
> On Wed, Nov 03, 2004 at 09:18:36PM +0100, Gerd Knorr wrote:
> > Not sure whenever tt is fixed with my patch, I've tested skas only
> > (I'm building skas-only dynamically linked kernels these days
> > because due to working on x11 framebuffer stuff which needs
> > dynamically linked libX11).

> it would be nice to find a way to make this work TT mode for you

> > So if Chris actually tested TT then his patch probably is ok and
> > needed as well ...

> i'm only using TT mode at present, i don't check esoteric modes that
> require host-OS patches at present
SKAS mode is currently more used and tested than TT mode. And the SKAS patch 
is included at least in WOLK, the SuSE kernel, and the -cko patchset (Con 
Kolivas Overloaded).

That said, feel free not to use it, but at least test that it compiles in SKAS 
mode.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
