Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] um: add dummy ioremap and iounmap functions
References: <1495726955-27497-1-git-send-email-logang@deltatee.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <3c36765c-9e23-7947-b6d9-29ca892bd348@nod.at>
Date: Thu, 25 May 2017 17:48:28 +0200
MIME-Version: 1.0
In-Reply-To: <1495726955-27497-1-git-send-email-logang@deltatee.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: Stephen Bates <sbates@raithlin.com>, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@ZenIV.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Logan,

Am 25.05.2017 um 17:42 schrieb Logan Gunthorpe:
> The user mode architecture does not provide ioremap or iounmap, and
> because of this, the arch won't build when the functions are used in some
> core libraries.

Which ones are failing?
I thought we killed the problem by making CONFIG_COMPILE_TEST depend on !UML.

> I have designs to use these functions in scatterlist.c where they'd
> almost certainly never be called on the um architecture but it does need
> to compile. Thus, if the function is ever hit it returns NULL.

I was never a fan of that approach because in my opinion drivers should have
proper dependencies, including a dependency on HAS_IOMEM.

But I'll no longer block these attempts if we can get rid of tons of fallout
every kernel release.

Thanks,
//richard

