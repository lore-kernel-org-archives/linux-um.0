Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfSo3-0001tJ-U6	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 18:23:03 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DfSo3-0001St-2g	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 18:23:03 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML
	binary
Message-ID: <20050607004038.GA12466@ccure.user-mode-linux.org>
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org>
	<200506070105.20422.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506070105.20422.blaisorblade@yahoo.it>
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
Date: Mon, 6 Jun 2005 20:40:38 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 01:05:19AM +0200, Blaisorblade wrote:
> NACK at all, definitely, don't apply this one please. This patch:
> 
> 1) On i386 does not fix the problem it was supposed to fix when I originately 
> sent the first version (i.e. avoiding to create a .thread_private section to 
> allow linking against NPTL glibc). It's done on x86_64 and forgot on i386.
> 2) Splitting the linker script for subarchs is definitely not needed.
> 3) This removes the fix (done through objcopy -G switcheroo) to a link time 
> conflict happening on some weird glibc combinations.
> 
> I'll merge this work when it's ready.

OK, Andrew, just drop this one for now.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
