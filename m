Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1758845AbZCWQkf@vger.kernel.org>
Date: Mon, 23 Mar 2009 17:38:38 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] fix ptrace slowness
Message-ID: <20090323163838.GA24454@elte.hu>
References: <E1LllkK-0000zF-1h@pomaz-ex.szeredi.hu> <20090323151954.GC21267@elte.hu> <E1Llmpk-0001A3-2E@pomaz-ex.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Llmpk-0001A3-2E@pomaz-ex.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, oleg@redhat.com, peterz@infradead.org, roland@redhat.com, efault@gmx.de, rjw@sisk.pl, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, torvalds@linux-foundation.org, akpm@linux-foundation.org, stable@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> On Mon, 23 Mar 2009, Ingo Molnar wrote:
> > * Miklos Szeredi <miklos@szeredi.hu> wrote:
> > 
> > > This one incorporates comments from Oleg and Ingo.  Please apply 
> > > to 2.6.29 and 2.6.2[78]-stable trees.
> > 
> > The fix first needs to go upstream. There's an alternative patch 
> > below. Would you mind to give it a test? Chances are that it 
> > will make UML even faster than your fix.
> 
> Just the opposite.  With my patch a UML image boots in 17 
> seconnds, with your patch it boots in 33 seconds.  Without either 
> patch it boots in about 5 minutes.

okay - i've queued up your fix.

	Ingo
