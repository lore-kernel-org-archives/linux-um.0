Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Dec 2014 12:03:37 +0100
Message-ID: <2739506.ACK9B2Kt4q@wuerfel>
In-Reply-To: <54882533.6080901@nod.at>
References: <20141210104624.GB32280@tucsk.suse.de> <54882533.6080901@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [BUG] uml panics with "Segfault with no mm" in v3.19-rc
To: Richard Weinberger <richard@nod.at>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ley Foon Tan <lftan@altera.com>, linux-kernel@vger.kernel.org, Daniel Walter <sahne@0x90.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wednesday 10 December 2014 11:49:23 Richard Weinberger wrote:
> Hi!
> 
> Am 10.12.2014 um 11:46 schrieb Miklos Szeredi:
> > The guilty commit is:
> > 
> >   00f634bc522d "asm-generic: add generic futex for !CONFIG_SMP"
> 
> Thanks a lot Miklos!
> Your bisecting faster than I do.
> 
> Let's dig into the issue!
> 

Did this happen on linux-next as well?

Does this happen only on non-SMP UML running on an SMP host, or also
in other combinations?

	Arnd
