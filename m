Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPooS-0006W0-AX	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 15:11:04 -0700
Received: from newmail.brainfood.com ([146.82.138.14] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:RC4-SHA:128)	(Exim 4.44)
	id 1EPooQ-0006l2-VU	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 15:11:04 -0700
From: Adam Heath <doogie@debian.org>
Subject: Re: [uml-devel] ubd and write barriers
In-Reply-To: <HDubM/jULNDp.FiIUPkbI/sUT/mvVu1/2/A@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.58.0510121710380.8567@gradall.private.brainfood.com>
References: <HDubM/jULNDp.FiIUPkbI/sUT/mvVu1/2/A@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 12 Oct 2005 17:11:00 -0500 (CDT)
To: Chris Lightfoot <chris@ex-parrot.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 4 Oct 2005, Chris Lightfoot wrote:

> --- ubd_kern.c.orig     2005-10-04 10:17:50.000000000 +0100
> +++ ubd_kern.c  2005-10-04 10:22:59.000000000 +0100
> @@ -68,6 +68,7 @@
>         unsigned long long cow_offset;
>         unsigned long bitmap_words[2];
>         int error;
> +        int barrier;
>  };
>
>  extern int open_ubd_file(char *file, struct openflags *openflags,
> @@ -825,6 +826,8 @@
>                 unregister_blkdev(MAJOR_NR, "ubd");
>                 return -1;
>         }
> +
> +        blk_queue_ordered(ubd_queue, QUEUE_ORDERED_TAG);
>
>         if (fake_major != MAJOR_NR) {
>                 char name[sizeof("ubd_nnn\0")];
> @@ -1003,6 +1006,8 @@
>         io_req->buffer = req->buffer;
>         io_req->sectorsize = 1 << 9;
>
> +        io_req->barrier = blk_barrier_rq(req);
> +
>         if(dev->cow.file != NULL)
>                 cowify_req(io_req, dev->cow.bitmap, dev->cow.bitmap_offset,
>                            dev->cow.bitmap_len);
> @@ -1334,6 +1339,8 @@
>                 start = end;
>         } while(start < nsectors);
>
> +        if (req->barrier) fdatasync(req->fds[bit]); /* XXX also sync before this write? */
> +
>         req->error = update_bitmap(req);
>  }

Fix your tabbing.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
