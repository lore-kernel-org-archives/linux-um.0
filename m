Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXqnh-00AA4A-Hp
 for linux-um@lists.infradead.org; Sat, 17 Apr 2021 19:40:19 +0000
Message-ID: <9722b8ce233ad4d7020588f9dd60a3037455754d.camel@sipsolutions.net>
Subject: Re: [PATCH] uml/helper: Fix stack alignment
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sat, 17 Apr 2021 21:40:07 +0200
In-Reply-To: <20210417163949.530921-1-zhuyifei1999@gmail.com>
References: <20210417163949.530921-1-zhuyifei1999@gmail.com>
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
To: YiFei Zhu <zhuyifei1999@gmail.com>, linux-um@lists.infradead.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Sat, 2021-04-17 at 11:39 -0500, YiFei Zhu wrote:
> GCC assumes that stack is aligned to 16-byte on function entry [1].

Fun.

> Therefore, there is no need to have the stack pointer
> pointer always point to valid memory unless the stack is poped;
> so the `- sizeof(void *)` in the code is unnecessary.
> 

I've always wondered about that - sizeof(void *) thing there ... didn't
seem to make much sense :)

> On the other hand, glibc reserves the 16 bytes it needs on stack
> and pops itself, so by the call instruction the stack pointer
> is exactly the caller-supplied sp. It then push the 16 bytes of
> the return address and the saved stack pointer, so the base
> pointer will be 16-byte aligned if and only if the caller
> supplied sp is 16-byte aligned. Therefore, the caller must supply
> a 16-byte aligned pointer, which `stack + UM_KERN_PAGE_SIZE`
> already satisfies.
> 
> On a side note, musl is unaffected by this issue because it forces
> 16 byte alignment via `and $-16,%rsi` in its clone wrapper.
> Similarly, glibc i386 is also uneffected because it has

typo: unaffected :)


> To reproduce this bug, enable CONFIG_UML_RTC. uml_rtc will call
> add_sigio_fd which will then cause write_sigio_thread to go
> into segfault loop.

Probably not the only way you can do this, but yeah ...


How about the same pattern in start_userspace() and new_thread()?
Doesn't matter for some reason? Or just didn't hit it yet because
there's no 16-byte "thing" on the stack?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

