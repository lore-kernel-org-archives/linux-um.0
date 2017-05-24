Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1495663252-22434-1-git-send-email-logang@deltatee.com>
 <20170524220510.GF390@ZenIV.linux.org.uk>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b8de9b34-0f7c-1486-3a64-5b727cef7925@deltatee.com>
Date: Wed, 24 May 2017 16:09:06 -0600
MIME-Version: 1.0
In-Reply-To: <20170524220510.GF390@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] um: add dummy ioremap and iounmap functions
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Stephen Bates <sbates@raithlin.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>



On 24/05/17 04:05 PM, Al Viro wrote:
>> I have designs to use these functions in scatterlist.c where they'd
>> almost certainly never be called on the um architecture but it does need
>> to compile.
> 
> Then make it fail there.

Ok, will do. I'll send a v2 patch shortly.

> Incidentally, s390 has ioremap() only when CONFIG_PCI is set.

Hmm, ok, I'll take a peek. The kbuild robot never reported any build
issues with that architecture. I did see exactly this on the tile
architecture which I sent another patch for (that your feedback also
applies to).

Thanks for the quick review and feedback,

Logan


