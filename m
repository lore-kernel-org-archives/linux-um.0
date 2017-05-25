Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1495726955-27497-1-git-send-email-logang@deltatee.com>
 <3c36765c-9e23-7947-b6d9-29ca892bd348@nod.at>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1bffdbbd-a317-d9a3-88d2-d02501d2fae1@deltatee.com>
Date: Thu, 25 May 2017 09:53:17 -0600
MIME-Version: 1.0
In-Reply-To: <3c36765c-9e23-7947-b6d9-29ca892bd348@nod.at>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] um: add dummy ioremap and iounmap functions
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: Stephen Bates <sbates@raithlin.com>, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@ZenIV.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>



On 25/05/17 09:48 AM, Richard Weinberger wrote:
> Which ones are failing?
> I thought we killed the problem by making CONFIG_COMPILE_TEST depend on !UML.

None, at the moment. My work is trying to add iomem support to scatter
lists and thus I want to call ioremap in scatterlist.c. That's when
things fail to build. We could put an '#ifdef HAS_IOMEM' around only the
uses, but I thought this approach was cleaner. However, if people would
rather I do that, let me know and I will.

> I was never a fan of that approach because in my opinion drivers should have
> proper dependencies, including a dependency on HAS_IOMEM.

This doesn't really work when we try to use it in a core library which
can't depend on HAS_IOMEM.

Thanks,

Logan

