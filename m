Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI8td-00GjQy-9Q
 for linux-um@lists.infradead.org; Mon, 23 Aug 2021 12:17:46 +0000
Date: Mon, 23 Aug 2021 14:17:41 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH, RFC] um: remove set_fs
Message-ID: <20210823121741.GA12605@lst.de>
References: <20210709133836.3821559-1-hch@lst.de>
 <b7b4f02385c2b103d66eadb1dfcff607a28a82b2.camel@sipsolutions.net>
 <20210823070426.GA22184@lst.de>
 <169368f3-1651-8b5c-d979-6ec9e060f6ca@cambridgegreys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <169368f3-1651-8b5c-d979-6ec9e060f6ca@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Christoph Hellwig <hch@lst.de>, Johannes Berg <johannes@sipsolutions.net>, richard@nod.at, linux-um@lists.infradead.org

On Mon, Aug 23, 2021 at 09:28:37AM +0100, Anton Ivanov wrote:
> In first read - you do not want to do that.
>
> buffer_op is slow (even with all the tweaks we have done to that). It is one of the reasons UML userspace is slower than it should be.
>
> The primary reason for that is that it never copies more than a page at a time and pages in/out a page at a time.
>
> We retain reasonable kernel speed because we bypass it for kernel - "if (uaccess_kernel())".
>
> Unless I am missing something, this change will use the slow path currently used for userspace for the kernel.

uaccess_kernel() is not the fast path, it is the exception path when
someone uses the uaccess helper on kernel pointer after doing a
set_fs(KERNEL_DS).  And this path is entirel gone once CONFIG_SET_FS
is not set and replaced with calls to __get_kernel_nofault /
__put_kernel_nofault.

In other words - very little generated code actually changes with
this patch, except for the context switch path, which gets simplified.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

