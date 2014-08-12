Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53EA297F.1040107@nod.at>
Date: Tue, 12 Aug 2014 16:49:35 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <20140812144655.GB16961@redhat.com>
In-Reply-To: <20140812144655.GB16961@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] resource: Fix the case of null pointer access
To: Vivek Goyal <vgoyal@redhat.com>, linux kernel mailing list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Walter <sahne@0x90.at>, =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 12.08.2014 16:46, schrieb Vivek Goyal:
> Richard and Daniel reported that UML is broken due to changes to resource
> traversal functions. Problem is that iomem_resource.child can be null
> and new code does not consider that possibility. Old code used a for loop
> and that loop will not even execute if p was null.
> 
> Revert back to for() loop logic and bail out if p is null.
> 
> I also moved sibling_only check out of resource_lock. There is no
> reason to keep it inside the lock.
> 
> Following is backtrace of the UML crash.

Shall I pickup this patch and route it via my uml tree to Linus?

Thanks,
//richard
