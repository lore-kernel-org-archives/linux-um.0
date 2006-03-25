Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMxCL-0005SS-RG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 17:04:09 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMxCK-0005JR-EX
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 17:04:09 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060325010524.GA8117@ccure.user-mode-linux.org>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
	<20060324144535.37b3daf7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324144535.37b3daf7.akpm@osdl.org>
Subject: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
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
Date: Fri, 24 Mar 2006 20:05:24 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Mar 24, 2006 at 02:45:35PM -0800, Andrew Morton wrote:
> The `= 0;' causes this to consume space in vmlinux's .data.  If we put it
> in bss and let crt0.o take care of zeroing it, we save a little disk space.

Yup.

> > +			page = alloc_page(GFP_ATOMIC);
> 
> That's potentially quite a few atomically-allocated pages.  I guess UML is
> more resistant to oom than normal kernels (?) but it'd be nice to be able to
> run page reclaim here.

This is the big question with this patch.  How incestuous do I want to
get with the VM system in order to get it to free up pages?  For now,
I decided to be fairly hands-off, allocate as many pages as I can get,
and return the total number to the host.  The host, if it wasn't happy
with the results, can wait a bit while the UML notices that it is
really low on memory and frees some up, and then hit up the UML for
the remainder.

> > +	char buf[sizeof("18446744073709551615\0")];
> 
> rofl.  We really ought to have a #define for "this architecture's maximum
> length of an asciified int/long/s32/s64".  Generally people do
> guess-and-giggle-plus-20%, or they just get it wrong.

I can write one up.  I did some quick grepping, and there are a good
number of constant over-estimates, plus some which might be in danger
with an large number of devices, plus one (kallsyms.c) which actually
does some sane-looking approximate math to get a reasonable number (which
is then doubled).

>  * NOTE: Currently, only shmfs/tmpfs is supported for this operation.
>  * Other filesystems return -ENOSYS.
> 
> Are you expecting that this memory is backed by tmpfs?

Yes, but there should be some checking of this beforehand.

Drop this version for now, and I'll send a new one to cover these
problems plus the one that BlaisorBlade pointed out.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
