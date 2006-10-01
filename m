Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GU4sg-0002gi-66 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 10:13:34 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GU4sc-0007rJ-GE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 10:13:34 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 1 Oct 2006 19:10:37 +0200
References: <200609271757.k8RHvtNK005742@ccure.user-mode-linux.org>
In-Reply-To: <200609271757.k8RHvtNK005742@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610011910.37805.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 4/5] UML - Close file descriptor leaks
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 19:57, Jeff Dike wrote:
> Close two file descriptor leaks, one in the ubd driver and one to
> /proc/mounts.  The ubd driver bug also leaked some vmalloc space.
> The /proc/mounts leak was a descriptor that was just never closed.
For AKPM:
NACK on the ubd driver part. It adds a bugs and does fix the one you found in 
the right point. ACK on the other hunk.

Now, Andrew, you can ignore what follows if you want:

Jeff, please explain me the exact ubd driver bug - I believe that the open 
must be done there, that it is balanced by ubd_close(), and that the leak fix 
should be done differently. I've done huge changes to the UBD driver and I'll 
send them you briefly for your tree (they work but they're not yet in a 
perfect shape).

For what I can gather from your description and code, the leak you diagnosed 
is a bug in ubd_open_dev(), and is valid for any call to it: generally, if an 
_open function fails it should leave nothing to cleanup, and in particular 
the corresponding _close should not be called (this is the implicit standard 
I've seen in Linux). However, I did not note the ubd_open_dev() leak, and I'm 
fixing it now.

Btw, ubd_open_dev() and ubd_close() are matching functions, while ubd_close() 
does not match ubd_open(), so I renamed ubd_close -> ubd_close_dev.

About the UBD changes, they're mainly about making it SMP-ready. I've done 
also a number of other changes (for instance I removed the allocation in 
fork+execvp() by reimplementing the latter, and fixed the usage of sigio 
spinlocks), so the only big remaining bug I recall is that writes to consoles 
should be lock-free.

When there are sleep-inside-spinlock warnings inside line_open(), for 
instance, the resulting printk hangs because the line spinlock is already 
held (this is, in particular, due to um_request_irq in 
write_sigio_workaround(), and I fixed it).
However, console write driver methods must be lock-free (specified in 
Documentation/tty.txt); I fixed the warnings but I wanted to fix the hang 
caused by them.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> ---
>
>  arch/um/drivers/ubd_kern.c |    9 ++-------
>  arch/um/os-Linux/mem.c     |    6 +++++-
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> Index: linux-2.6.18-mm/arch/um/drivers/ubd_kern.c
> ===================================================================
> --- linux-2.6.18-mm.orig/arch/um/drivers/ubd_kern.c	2006-09-26
> 16:28:58.000000000 -0400 +++
> linux-2.6.18-mm/arch/um/drivers/ubd_kern.c	2006-09-26 16:31:24.000000000
> -0400 @@ -667,18 +667,15 @@ static int ubd_add(int n)
>  	if(dev->file == NULL)
>  		goto out;
>
> -	if (ubd_open_dev(dev))
> -		goto out;
> -
>  	err = ubd_file_size(dev, &dev->size);
>  	if(err < 0)
> -		goto out_close;
> +		goto out;
>
>  	dev->size = ROUND_BLOCK(dev->size);
>
>  	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
>  	if(err)
> -		goto out_close;
> +		goto out;
>
>  	if(fake_major != MAJOR_NR)
>  		ubd_new_disk(fake_major, dev->size, n,
> @@ -690,8 +687,6 @@ static int ubd_add(int n)
>  		make_ide_entries(ubd_gendisk[n]->disk_name);
>
>  	err = 0;
> -out_close:
> -	ubd_close(dev);
>  out:
>  	return err;
>  }

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
