Return-Path: <logang@deltatee.com>
References: <1495726955-27497-1-git-send-email-logang@deltatee.com>
 <3c36765c-9e23-7947-b6d9-29ca892bd348@nod.at>
 <1bffdbbd-a317-d9a3-88d2-d02501d2fae1@deltatee.com>
 <CAMuHMdUrDPvNoZ5UpS-qu4JOyq+JSy2tpxttKiUPFexB6yhTYw@mail.gmail.com>
 <8ad31524-dfc3-4fc4-f725-a8899aea9234@deltatee.com>
 <348baf8d-b42f-13a7-3398-cb0268d7c693@deltatee.com>
 <996ae534-92d6-ab7d-df90-7052b86f8039@nod.at>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1d4d3148-fc88-f834-3881-16b85dafc8ef@deltatee.com>
Date: Wed, 21 Jun 2017 15:25:53 -0600
MIME-Version: 1.0
In-Reply-To: <996ae534-92d6-ab7d-df90-7052b86f8039@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] um: add dummy ioremap and iounmap functions
To: Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Stephen Bates <sbates@raithlin.com>, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Poke.

On 08/06/17 01:17 PM, Richard Weinberger wrote:
> Am 08.06.2017 um 20:53 schrieb Logan Gunthorpe:
> IMHO an ifdef in scatterlist code does not hurt.
> It is equally ugly than mocking ioremap for UML.

I disagree. Having ifdefs scattered around all call sites of a function
is *much* worse than having an extra mock function tucked away in a
header file somewhere.

It's a very common pattern in the kernel for providers of functions that
depend on a configuration option to provide mock functions when the
configuration option is not selected. This prevents needing every caller
of said function to put #ifdefs around the call. For a few examples:

include/linux/blkdev.h:1952
include/linux/dax.h:24
include/linux/pci.h:1329

And, frankly, it's _exactly_ what Linus Torvalds himself was arguing
against in the link I sent up-thread [1].

> So, I'm puzzled.
> Arnd, what do you think?
> Shall !HAS_IOMEM archs just mock these functions?

So, once again, 'um' is now the only architecture that has this problem
since tile and s390 accepted my patches (and without a fuss too). So can
you please consider merging this patch or proposing something that will
also fix the problem?

Thanks,

Logan


[1] http://yarchive.net/comp/linux/ifdefs.html

