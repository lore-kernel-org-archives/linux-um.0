Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI40u-00Fcmc-Am
 for linux-um@lists.infradead.org; Mon, 23 Aug 2021 07:05:01 +0000
Date: Mon, 23 Aug 2021 09:04:26 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH, RFC] um: remove set_fs
Message-ID: <20210823070426.GA22184@lst.de>
References: <20210709133836.3821559-1-hch@lst.de>
 <b7b4f02385c2b103d66eadb1dfcff607a28a82b2.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b7b4f02385c2b103d66eadb1dfcff607a28a82b2.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org

Richard, Anton - any comments?

On Fri, Jul 09, 2021 at 04:47:34PM +0200, Johannes Berg wrote:
> On Fri, 2021-07-09 at 15:38 +0200, Christoph Hellwig wrote:
> > Remove address space overrides using set_fs() for user mode Linux.
> > 
> > Compile tested only.
> 
> Seems to survive my normal (wireless related) tests :)
> 
> But I don't really understand what any of it does, so ...
> 
> In particular, why no pagefaults for kernel addresses?
> 
> johannes
---end quoted text---

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

