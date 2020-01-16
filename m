Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1is080-0002gc-Ej
 for linux-um@lists.infradead.org; Thu, 16 Jan 2020 08:03:50 +0000
Message-ID: <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 16 Jan 2020 09:03:35 +0100
In-Reply-To: <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
 <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
 (sfid-20200115_235651_948442_0F0A0073)
 <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
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
Cc: richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, dvyukov@google.com, David Gow <davidgow@google.com>, aryabinin@virtuozzo.com, Brendan Higgins <brendanhiggins@google.com>, anton.ivanov@cambridgegreys.com

On Thu, 2020-01-16 at 08:57 +0100, Johannes Berg wrote:
> 
> And if I remember from looking at KASAN, some of the constructors there
> depended on initializing after the KASAN data structures were set up (or
> at least allocated)? It may be that you solved that by allocating the
> shadow so very early though.

Actually, no ... it's still after main(), and the constructors run
before.

So I _think_ with the CONFIG_CONSTRUCTORS revert, this will no longer
work (but happy to be proven wrong!), if so then I guess we do have to
find a way to initialize the KASAN things from another (somehow
earlier?) constructor ...

Or find a way to fix CONFIG_CONSTRUCTORS and not revert, but I looked at
it quite a bit and didn't.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

