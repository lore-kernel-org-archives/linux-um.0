Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jSG8b-000566-2p
 for linux-um@lists.infradead.org; Sat, 25 Apr 2020 08:26:14 +0000
Message-ID: <b86f5469f9b888942b7a6f9862ec98c909121375.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Fix "time-internal.h" include in xor.h
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sat, 25 Apr 2020 10:26:04 +0200
In-Reply-To: <20200425042814.132920-1-davidgow@google.com>
References: <20200425042814.132920-1-davidgow@google.com>
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
To: David Gow <davidgow@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, 2020-04-24 at 21:28 -0700, David Gow wrote:
> It looks like the wrong header was included in xor.h, breaking make
> allyesconfig on UML (or, more specifically, kunit.py run --alltests).
> 
> ----------------------
> In file included from crypto/xor.c:17:
> ./arch/um/include/asm/xor.h:3:10: fatal error: shared/timer-internal.h: No such file or directory
>     3 | #include <shared/timer-internal.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
> ----------------------
> 
> Replacing this with "linux/time-internal.h" builds fine.
> 
> Fixes: d65197ad5249 ("um: fix time-travel=inf-cpu with xor/raid6")

Yeah, sorry about that. Some patches overlapped here, i.e. were pending
from separate branches I had.

I sent Richard a fix quite about three weeks ago:

https://patchwork.ozlabs.org/project/linux-um/patch/20200405213357.b6ce1024b276.I7c370e20580d3122c58df5727ee2d6fb53545576@changeid/

but I guess he hasn't applied it yet.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

