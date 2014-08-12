Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Aug 2014 11:04:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20140812150417.GC16961@redhat.com>
References: <20140812144655.GB16961@redhat.com>
 <53EA297F.1040107@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53EA297F.1040107@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] resource: Fix the case of null pointer access
To: Richard Weinberger <richard@nod.at>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Walter <sahne@0x90.at>, Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Aug 12, 2014 at 04:49:35PM +0200, Richard Weinberger wrote:
> Am 12.08.2014 16:46, schrieb Vivek Goyal:
> > Richard and Daniel reported that UML is broken due to changes to resource
> > traversal functions. Problem is that iomem_resource.child can be null
> > and new code does not consider that possibility. Old code used a for loop
> > and that loop will not even execute if p was null.
> > 
> > Revert back to for() loop logic and bail out if p is null.
> > 
> > I also moved sibling_only check out of resource_lock. There is no
> > reason to keep it inside the lock.
> > 
> > Following is backtrace of the UML crash.
> 
> Shall I pickup this patch and route it via my uml tree to Linus?

I am fine with that. 

Thanks
Vivek
