Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ms.lwn.net ([45.79.88.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hqLYj-0005Ud-RP
 for linux-um@lists.infradead.org; Wed, 24 Jul 2019 18:00:15 +0000
Date: Wed, 24 Jul 2019 12:00:05 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: move Documentation/virtual to
 Documentation/virt
Message-ID: <20190724120005.31a990af@lwn.net>
In-Reply-To: <b9baabbb-9e9b-47cf-f5a8-ea42ba1ddc25@redhat.com>
References: <20190724072449.19599-1-hch@lst.de>
 <b9baabbb-9e9b-47cf-f5a8-ea42ba1ddc25@redhat.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, richard@nod.at, jdike@addtoit.com, rkrcmar@redhat.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, anton.ivanov@cambridgegreys.com

On Wed, 24 Jul 2019 10:51:36 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 24/07/19 09:24, Christoph Hellwig wrote:
> > Renaming docs seems to be en vogue at the moment, so fix on of the
> > grossly misnamed directories.  We usually never use "virtual" as
> > a shortcut for virtualization in the kernel, but always virt,
> > as seen in the virt/ top-level directory.  Fix up the documentation
> > to match that.
> > 
> > Fixes: ed16648eb5b8 ("Move kvm, uml, and lguest subdirectories under a common "virtual" directory, I.E:")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>  
> 
> Queued, thanks.  I can't count how many times I said "I really should
> rename that directory".

...and it's up to Linus before I even got a chance to look at it - one has
to be fast around here...:)

There's nothing wrong with this move, but it does miss the point of much
of the reorganization that has been going on in the docs tree.  It's not
just a matter of getting more pleasing names; the real idea is to create a
better, more reader-focused organization on kernel documentation as a
whole.  Documentation/virt still has the sort of confusion of audiences
that we're trying to fix:

 - kvm/api.txt pretty clearly belongs in the userspace-api book, rather
   than tossed in with:

 - kvm/review-checklist.txt, which belongs in the subsystem guide, if only
   we'd gotten around to creating it yet, or

 - kvm/mmu.txt, which is information for kernel developers, or

 - uml/UserModeLinux-HOWTO.txt, which belongs in the admin guide.

I suspect that organization is going to be one of the main issues to talk
about in Lisbon.  Meanwhile, I hope that this rename won't preclude
organizational work in the future.

Thanks,

jon

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

