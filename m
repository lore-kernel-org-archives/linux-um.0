Return-Path: <johannes@sipsolutions.net>
Message-ID: <0523cc8788bfe47ffba185d0436a7c77c85c6e4c.camel@sipsolutions.net>
Subject: Re: Build regressions/improvements in v5.16-rc7
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 04 Jan 2022 10:04:03 +0100
In-Reply-To: <alpine.DEB.2.22.394.2112271142250.1704790@ramsan.of.borg>
References: <20211227083126.1153239-1-geert@linux-m68k.org>
	 <alpine.DEB.2.22.394.2112271142250.1704790@ramsan.of.borg>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

On Mon, 2021-12-27 at 11:44 +0100, Geert Uytterhoeven wrote:
> 
> sparc64-gcc11/sparc-allmodconfig
> 
>    + /kisskb/src/drivers/video/fbdev/nvidia/nvidia.c: error: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]:  => 1439:10, 1414:10
> 

This should be fixed by

commit 5f174ec3c1d62013f86db6597249174d8cb227b2
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Sep 20 21:32:49 2021 +0000

    logic_io instance of iounmap() needs volatile on argument


when it lands.

johannes

