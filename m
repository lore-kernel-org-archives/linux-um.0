Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <538B314B.2050604@nod.at>
Date: Sun, 01 Jun 2014 15:57:31 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1401628131-1948-1-git-send-email-enjoymindful@gmail.com> <1401628131-1948-2-git-send-email-enjoymindful@gmail.com>
In-Reply-To: <1401628131-1948-2-git-send-email-enjoymindful@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] delete unnecessary bootmem struct page array
To: Real Name <enjoymindful@gmail.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 01.06.2014 15:08, schrieb Real Name:
> From: Honggang Li <enjoymindful@gmail.com>
> 
> 1) uml kernel bootmem managed through bootmem_data->node_bootmem_map,
> not the struct page array, so the array is unnecessary.
> 
> 2) the bootmem struct page array has been pointed by a *local* pointer,
> struct page *map, in init_maps function. The array can be accessed only
> in init_maps's scope. As a result, uml kernel wastes about 1% of total
> memory.

I reread your patch again.
You missed one important point. init_maps() setups max_mapnr which is used by
virt_addr_valid().

We have to be extremely careful here to not introduce a subtle fuckup.

Thanks,
//richard
