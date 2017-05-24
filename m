Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 24 May 2017 23:05:10 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] um: add dummy ioremap and iounmap functions
Message-ID: <20170524220510.GF390@ZenIV.linux.org.uk>
References: <1495663252-22434-1-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495663252-22434-1-git-send-email-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Stephen Bates <sbates@raithlin.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, May 24, 2017 at 04:00:52PM -0600, Logan Gunthorpe wrote:
> The user mode architecture does not provide ioremap or iounmap, and
> because of this, the arch won't build when the functions are used in some
> core libraries.
> 
> I have designs to use these functions in scatterlist.c where they'd
> almost certainly never be called on the um architecture but it does need
> to compile.

Then make it fail there.

Incidentally, s390 has ioremap() only when CONFIG_PCI is set.

