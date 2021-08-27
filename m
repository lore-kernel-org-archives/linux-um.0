Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJUbF-00BdC9-Ut
 for linux-um@lists.infradead.org; Fri, 27 Aug 2021 05:40:23 +0000
Date: Fri, 27 Aug 2021 07:40:12 +0200
From: hch <hch@lst.de>
Subject: Re: [PATCH, RFC] um: remove set_fs
Message-ID: <20210827054012.GA21703@lst.de>
References: <20210709133836.3821559-1-hch@lst.de>
 <b7b4f02385c2b103d66eadb1dfcff607a28a82b2.camel@sipsolutions.net>
 <20210823070426.GA22184@lst.de>
 <169368f3-1651-8b5c-d979-6ec9e060f6ca@cambridgegreys.com>
 <20210823121741.GA12605@lst.de>
 <e159919a-7401-580a-412c-1185701e7398@cambridgegreys.com>
 <1583675106.6324.1630005333356.JavaMail.zimbra@nod.at>
 <50ef0553-6b9f-32b4-3ee9-20464c01d634@cambridgegreys.com>
 <1948049684.7020.1630015460699.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1948049684.7020.1630015460699.JavaMail.zimbra@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, hch <hch@lst.de>, Johannes Berg <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>

On Fri, Aug 27, 2021 at 12:04:20AM +0200, Richard Weinberger wrote:
> Sounds like a decent patch. :-)
>  
> > I am OK with it.
> 
> So, let's be keen and merge it.

With all the merge conflicts including the one with the asm-generic
tree that causes the TASK_SIZE_MAX redefinition it might be worth to
drop it and merge it for the next merge window instead.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

