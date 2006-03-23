Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMZbI-0006Gx-Ng for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 15:52:20 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMZbH-0007dp-Bn
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 15:52:20 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Real fix for rejected patch uaccess-warning
References: <200603072031.18574.blaisorblade@yahoo.it>
	<200603101622.41518.blaisorblade@yahoo.it>
	<20060323205845.GA6109@ccure.user-mode-linux.org>
In-Reply-To: <20060323205845.GA6109@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603240052.11189.blaisorblade@yahoo.it>
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
Date: Fri, 24 Mar 2006 00:52:09 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 23 March 2006 21:58, Jeff Dike wrote:
> On Fri, Mar 10, 2006 at 04:22:41PM +0100, Blaisorblade wrote:
> > 686:		if (get_user(c, buf))
> > where "buf" is a "const char __user *".
> >
> > It's complaining because "const" was lost.
> >
> > Ultimately, I think we should remove all this copying of pointers and do
> > like i386 in this regard - there is only one cast to do, in put_user, as
> > I mentioned in last mail.
>
> OK, my first patch was insane, try this one:
>
> Index: linux-2.6.15/include/asm-um/uaccess.h
> ===================================================================
> --- linux-2.6.15.orig/include/asm-um/uaccess.h	2006-03-23
> 15:41:15.000000000 -0500 +++
> linux-2.6.15/include/asm-um/uaccess.h	2006-03-23 15:48:52.000000000 -0500
> @@ -42,10 +42,10 @@
>  #define __get_user(x, ptr) \
>  ({ \
>          const __typeof__(ptr) __private_ptr = ptr; \
> -        __typeof__(*(__private_ptr)) __private_val; \
> +        __typeof__(x) __private_val; \
>          int __private_ret = -EFAULT; \
>          (x) = (__typeof__(*(__private_ptr)))0; \
> -	if (__copy_from_user(&__private_val, (__private_ptr), \
> +	if (__copy_from_user((void *) &__private_val, (__private_ptr),	\
>  	    sizeof(*(__private_ptr))) == 0) {\
>          	(x) = (__typeof__(*(__private_ptr))) __private_val; \
>  		__private_ret = 0; \

> The (void *) fixes the warnings all by itself, but I changed the
> typeof because that's more correct and fixes some of the warnings by
> itself.

> What it can't fix is things like (from include/linux/pagemap.h):

> 	volatile char c;
> 	ret = __get_user(c, uaddr);

> We unavoidably lose the volatile because we can't know it was there,
> so the (void *) cast seems necessary in this case.

We could even do without __private_ptr, and that's surely easier to do. 
Actually I think that it could be done like for i386:

> Looking at this some more, it seems like most of the complexity could
> go away.  I think I was avoiding any assignment to the target variable
> until I knew that the copy_from_user had succeeded.  I think that was
> being too paranoid, and just copy_from_user straight into x should be
> fine.

If we think to a userspace address crossing a page bound, we can see the 
problem.

However, I think that get_user doesn't guarantee a "full copy" semantic - 
include/asm-i386/uaccess.h says it zeroes the dest var on error, so we're 
safe.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
