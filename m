Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1is023-0000ZE-I2
 for linux-um@lists.infradead.org; Thu, 16 Jan 2020 07:57:40 +0000
Message-ID: <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 16 Jan 2020 08:57:22 +0100
In-Reply-To: <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
 (sfid-20200115_235651_948442_0F0A0073)
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
 <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
 (sfid-20200115_235651_948442_0F0A0073)
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
To: Patricia Alfonso <trishalfonso@google.com>
Cc: richard@nod.at, jdike@addtoit.com, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, aryabinin@virtuozzo.com, dvyukov@google.com, anton.ivanov@cambridgegreys.com

Hi,

> This seems like a good idea. I'll keep the #ifdef around
> KASAN_SHADOW_SIZE, but add "select HAVE_ARCH_KASAN if X86_64" as well.
> This will make extending it later easier.

Yeah, that makes a lot of sense.

I think once somebody (Anton? Richard?) start applying patches again,
they will pick up my revert for CONFIG_CONSTRUCTORS:

https://patchwork.ozlabs.org/patch/1204275/

(See there for why I had to revert it)

If I remember correctly, KASAN depends on CONSTRUCTORS, so that revert
will then break your patch here?

And if I remember from looking at KASAN, some of the constructors there
depended on initializing after the KASAN data structures were set up (or
at least allocated)? It may be that you solved that by allocating the
shadow so very early though.

In any case, I think you should pick up that revert of
CONFIG_CONSTRUCTORS and see what you have to do to make it still work,
if that's possible.

If not, then ... tricky, not sure what to do. Maybe then we could
somehow hook in and have our own constructor that's called even before
the compiler-emitted ASAN constructors, to allocate the necessary data
structures.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

