Return-Path: <logang@deltatee.com>
References: <1495726955-27497-1-git-send-email-logang@deltatee.com>
 <3c36765c-9e23-7947-b6d9-29ca892bd348@nod.at>
 <1bffdbbd-a317-d9a3-88d2-d02501d2fae1@deltatee.com>
 <CAMuHMdUrDPvNoZ5UpS-qu4JOyq+JSy2tpxttKiUPFexB6yhTYw@mail.gmail.com>
 <8ad31524-dfc3-4fc4-f725-a8899aea9234@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <348baf8d-b42f-13a7-3398-cb0268d7c693@deltatee.com>
Date: Thu, 8 Jun 2017 12:53:40 -0600
MIME-Version: 1.0
In-Reply-To: <8ad31524-dfc3-4fc4-f725-a8899aea9234@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] um: add dummy ioremap and iounmap functions
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Stephen Bates <sbates@raithlin.com>, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Any thoughts on this? My patches for the other architectures are already
in linux-next. um is the only one that remains.

Thanks,

Logan

On 27/05/17 12:15 PM, Logan Gunthorpe wrote:
> Hi,
> 
> On 27/05/17 12:08 PM, Geert Uytterhoeven wrote:
>> Still, those code patch could be protected by #ifdef CONFIG_HAS_IOMEM,
>> or better, if (IS_ENABLED(CONFIG_HAS_IOMEM)).
> 
> Well I think it would have to be the former seeing the latter would
> still end up trying to compile the missing function. But having ifdefs
> inside code is not generally seen as good idea[1].
> 
> I'd really like to go forward with either this patch or something like
> it. The other two arches that have this problem are fine with merging a
> fix and adding ifdefs to work around a single arch doesn't feel right to me.
> 
> Thanks,
> 
> Logan
> 
> [1] http://yarchive.net/comp/linux/ifdefs.html
> 

