Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1rn5-001yE8-3B
 for linux-um@lists.infradead.org; Fri, 09 Jul 2021 14:47:44 +0000
Message-ID: <b7b4f02385c2b103d66eadb1dfcff607a28a82b2.camel@sipsolutions.net>
Subject: Re: [PATCH, RFC] um: remove set_fs
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 09 Jul 2021 16:47:34 +0200
In-Reply-To: <20210709133836.3821559-1-hch@lst.de>
References: <20210709133836.3821559-1-hch@lst.de>
MIME-Version: 1.0
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
To: Christoph Hellwig <hch@lst.de>, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org

On Fri, 2021-07-09 at 15:38 +0200, Christoph Hellwig wrote:
> Remove address space overrides using set_fs() for user mode Linux.
> 
> Compile tested only.

Seems to survive my normal (wireless related) tests :)

But I don't really understand what any of it does, so ...

In particular, why no pagefaults for kernel addresses?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

