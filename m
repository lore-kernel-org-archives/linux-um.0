Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMv06-0007u6-Oj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 14:43:22 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FMv05-0002ax-9U
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 14:43:22 -0800
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20060324144535.37b3daf7.akpm@osdl.org>
In-Reply-To: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Date: Fri, 24 Mar 2006 14:45:35 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> wrote:
>
> This adds hotplug memory support to UML.  The mconsole syntax is
> 	config mem=[+-]n[KMG]
> In other words, add or subtract some number of kilobytes, megabytes, or
> gigabytes.
>  
> Unplugged pages are allocated and then madvise(MADV_REMOVE), which is
> a currently experimental madvise extension.  These pages are tracked so
> they can be plugged back in later if the admin decides to give them back.
> The first page to be unplugged is used to keep track of about 4M of other
> pages.  A list_head is the first thing on this page.  The rest is filled
> with addresses of other unplugged pages.  This first page is not madvised,
> obviously.
> When this page is filled, the next page is used in a similar way and linked
> onto a list with the first page.  Etc.
> This whole process reverses when pages are plugged back in.  When a tracking
> page no longer tracks any unplugged pages, then it is next in line for
> plugging, which is done by freeing pages back to the kernel.
> 
> This patch also removes checking for /dev/anon on the host, which is obsoleted
> by MADVISE_REMOVE.
> 
> ...
>
> +static unsigned long long unplugged_pages_count = 0;

The `= 0;' causes this to consume space in vmlinux's .data.  If we put it
in bss and let crt0.o take care of zeroing it, we save a little disk space.


> +			page = alloc_page(GFP_ATOMIC);

That's potentially quite a few atomically-allocated pages.  I guess UML is
more resistant to oom than normal kernels (?) but it'd be nice to be able to
run page reclaim here.

> +	char buf[sizeof("18446744073709551615\0")];

rofl.  We really ought to have a #define for "this architecture's maximum
length of an asciified int/long/s32/s64".  Generally people do
guess-and-giggle-plus-20%, or they just get it wrong.

> +#ifndef MADV_REMOVE
> +#define MADV_REMOVE	0x5		/* remove these pages & resources */
> +#endif
> +
> +int os_drop_memory(void *addr, int length)
> +{
> +	int err;
> +
> +	err = madvise(addr, length, MADV_REMOVE);
> +	if(err < 0)
> +		err = -errno;
> +	return 0;
> +}

 * NOTE: Currently, only shmfs/tmpfs is supported for this operation.
 * Other filesystems return -ENOSYS.

Are you expecting that this memory is backed by tmpfs?



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
