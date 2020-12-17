Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <20201217131556.6d1a5546bd43.I2fcd1dfac11d31e1a83a26488f396d97ba03ddda@changeid>
In-Reply-To: <20201217131556.6d1a5546bd43.I2fcd1dfac11d31e1a83a26488f396d97ba03ddda@changeid>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 17 Dec 2020 15:52:56 +0100
Message-ID: <CAK8P3a3=orVNeUNermxzHBynoG4td+W07wfBb=yADBBZg6JndA@mail.gmail.com>
Subject: Re: [PATCH] um: return error from ioremap()
Content-Type: text/plain; charset="UTF-8"
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um <linux-um@lists.infradead.org>, Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Johannes Berg <johannes.berg@intel.com>
List-ID: <linux-um.lists.infradead.org>

On Thu, Dec 17, 2020 at 1:15 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> Back a few years ago, ioremap() was added to UML so that we'd
> not break the build for everything all the time. However, for
> some reason, v1 of the patch got applied, rather than the v2
> that returned NULL, which was discussed here:
>
> https://lore.kernel.org/lkml/1495726955-27497-1-git-send-email-logang@deltatee.com/
>
> Fix that now.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

