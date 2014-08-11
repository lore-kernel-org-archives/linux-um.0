Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53E91894.3060501@gmx.de>
Date: Mon, 11 Aug 2014 21:25:08 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <53E7A42E.4090702@nod.at> <20140811122229.GA26869@redhat.com>	<53E8B654.2000807@nod.at> <20140811184401.GE1863@redhat.com>
In-Reply-To: <20140811184401.GE1863@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] "resource: provide new functions to walk through
 resources" breaks UML
To: Vivek Goyal <vgoyal@redhat.com>, Richard Weinberger <richard@nod.at>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, sahne@0x90.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 08/11/2014 08:44 PM, Vivek Goyal wrote:
> 
> Hi Richard,
> 
> Can you please give the attached patch a try and see if it fixes the UML
> issue.
> 
> I noticed that previous code had a for() loop which will not execute
> if p was null. I have resorted back to same code now. 
> 
> Thanks
> Vivek
> 
> 
> ---
>  kernel/resource.c |   11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6/kernel/resource.c
> ===================================================================
> --- linux-2.6.orig/kernel/resource.c	2014-08-11 13:36:19.942423192 -0400
> +++ linux-2.6/kernel/resource.c	2014-08-11 13:50:20.529387653 -0400
> @@ -351,15 +351,12 @@ static int find_next_iomem_res(struct re
>  	end = res->end;
>  	BUG_ON(start >= end);
>  
> -	read_lock(&resource_lock);
> -
> -	if (first_level_children_only) {
> -		p = iomem_resource.child;
> +	if (first_level_children_only)
>  		sibling_only = true;
> -	} else
> -		p = &iomem_resource;
>  
> -	while ((p = next_resource(p, sibling_only))) {
> +	read_lock(&resource_lock);
> +
> +	for (p = iomem_resource.child; p; p = next_resource(p, sibling_only)) {
>  		if (p->flags != res->flags)
>  			continue;
>  		if (name && strcmp(p->name, name))
> 
At least at my system (32 bit x86) the patch seems to work (applied on top of v3.16-10473-gc8d6637)

-- 
Toralf

