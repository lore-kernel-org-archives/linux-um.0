Return-Path: <joe@perches.com>
Message-ID: <1348949312.3294.0.camel@joe-AO722>
From: Joe Perches <joe@perches.com>
Date: Sat, 29 Sep 2012 13:08:32 -0700
In-Reply-To: <1348938460-20919-1-git-send-email-geert@linux-m68k.org>
References: <1348938460-20919-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] arch/um/drivers: Drop UM_ prefix from printk()
 level specifiers
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, x86@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, 2012-09-29 at 19:07 +0200, Geert Uytterhoeven wrote:
> Since commit 9429ec96c2718c0d1e3317cf60a87a0405223814 ("um: Preinclude
> include/linux/kern_levels.h") the non-prefixed printk() level specifiers
> are usable for the user parts of UML.


Thanks Geert.



