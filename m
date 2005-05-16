Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXiKZ-0007VR-La	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 09:20:35 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DXiKZ-0007TY-3V	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 09:20:35 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Removing call to function pointer in inner loop of
	copy_from_user()
Message-ID: <20050516150055.GA4977@ccure.user-mode-linux.org>
References: <200505152044.44400.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505152044.44400.blaisorblade@yahoo.it>
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
Date: Mon, 16 May 2005 11:00:55 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux-devel@lists.sourceforge.net

On Sun, May 15, 2005 at 08:44:44PM +0200, Blaisorblade wrote:
> copy_from_user() loops, in SKAS mode, calls do_op inside the inner loop; do_op 
> acts on 4k at once, so with modern pipelines, the potential cost of the 
> function call can be very big.
> 
> Beyond that, we also call setjmp_wrapper, which simply puts a sigjmp_buf on 
> the stack.
> 
> Wouldn't the code be cleaner if we rip that out, together with the va_arg() 
> calls, and do everything inside do_buffer_op? Doh, those are from userspace 
> headers. However it looks they would be includable from kernel code (no 
> reference to kernel headers), by adding them at the end of the include search 
> path.

> What's your opinion? I'm ready to work on this.

I was unhappy about adding the setjmp there, but it turns out that the 
kernel data might not be present and so can segfault.  So, when that happens,
we need to get out of there and return an error, and the way that's done is
by the page fault handler longjmping back out.

If you can think of a better way to do it, go ahead.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
