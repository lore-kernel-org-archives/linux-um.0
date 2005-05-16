Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXj2t-0003K2-Ea	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 10:06:23 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DXj2o-0000kd-IF	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 10:06:23 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Removing call to function pointer in inner loop of
	copy_from_user()
References: <200505152044.44400.blaisorblade@yahoo.it>
	<20050516150055.GA4977@ccure.user-mode-linux.org>
In-Reply-To: <20050516150055.GA4977@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505161904.14197.blaisorblade@yahoo.it>
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
Date: Mon, 16 May 2005 19:04:13 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Monday 16 May 2005 17:00, Jeff Dike wrote:
> On Sun, May 15, 2005 at 08:44:44PM +0200, Blaisorblade wrote:
> > copy_from_user() loops, in SKAS mode, calls do_op inside the inner loop;
> > do_op acts on 4k at once, so with modern pipelines, the potential cost of
> > the function call can be very big.

> > Beyond that, we also call setjmp_wrapper, which simply puts a sigjmp_buf
> > on the stack.

> > Wouldn't the code be cleaner if we rip that out, together with the
> > va_arg() calls, and do everything inside do_buffer_op? Doh, those are
> > from userspace headers. However it looks they would be includable from
> > kernel code (no reference to kernel headers), by adding them at the end
> > of the include search path.

> > What's your opinion? I'm ready to work on this.

> I was unhappy about adding the setjmp there, but it turns out that the
> kernel data might not be present and so can segfault.  So, when that
> happens, we need to get out of there and return an error, and the way
> that's done is by the page fault handler longjmping back out.

Yes, I remember it, I worked with you on diagnosing the /dev/kmem crash.

> If you can think of a better way to do it, go ahead.

I could move maybe move sigsetjmp to kernelspace code; however, another 
possibility would be to use the exception handler tables we've always 
supported without using them (only drawback is that the code *must* be 
inlined, and possibly the need for some assembler code, which however is 
probably avoidable).
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
