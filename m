Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 Apr 2011 07:34:08 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20110420143408.GA22436@kroah.com>
References: <1303299266-10219-1-git-send-email-richard@nod.at>
 <1303299266-10219-2-git-send-email-richard@nod.at>
 <20110420142702.GB22114@kroah.com>
 <201104201629.24099.richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201104201629.24099.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [stable] [PATCH 2/3] um: Add support for 64 bit atomic operations
To: Richard Weinberger <richard@nod.at>
Cc: akpm@linux-foundation.org, Martin Walch <walch.martin@web.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Apr 20, 2011 at 04:29:23PM +0200, Richard Weinberger wrote:
> Am Mittwoch 20 April 2011, 16:27:02 schrieb Greg KH:
> > On Wed, Apr 20, 2011 at 01:34:25PM +0200, Richard Weinberger wrote:
> > > This adds support for 64 bit atomic operations on
> > > 32 bit UML systems.
> > > XFS needs them since 2.6.38.
> > > 
> > > Reported-by: Martin Walch <walch.martin@web.de>
> > > Tested-by: Martin Walch <walch.martin@web.de>
> > > Cc: Martin Walch <walch.martin@web.de>
> > > Cc: <stable@kernel.org> # .38.x 084189a: um: disable CONFIG_CMPXCHG_LOCAL
> > 
> > Why is this a stable patch?
> 
> Because it fixes a build error in 2.6.38.
> See: https://bugzilla.kernel.org/show_bug.cgi?id=32812

Then why not put that in the changelog entry in the first place?

thanks,

greg "please save me time" k-h
