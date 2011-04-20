Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Wed, 20 Apr 2011 16:29:23 +0200
References: <1303299266-10219-1-git-send-email-richard@nod.at> <1303299266-10219-2-git-send-email-richard@nod.at> <20110420142702.GB22114@kroah.com>
In-Reply-To: <20110420142702.GB22114@kroah.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201104201629.24099.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [stable] [PATCH 2/3] um: Add support for 64 bit atomic operations
To: Greg KH <greg@kroah.com>
Cc: akpm@linux-foundation.org, Martin Walch <walch.martin@web.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Mittwoch 20 April 2011, 16:27:02 schrieb Greg KH:
> On Wed, Apr 20, 2011 at 01:34:25PM +0200, Richard Weinberger wrote:
> > This adds support for 64 bit atomic operations on
> > 32 bit UML systems.
> > XFS needs them since 2.6.38.
> > 
> > Reported-by: Martin Walch <walch.martin@web.de>
> > Tested-by: Martin Walch <walch.martin@web.de>
> > Cc: Martin Walch <walch.martin@web.de>
> > Cc: <stable@kernel.org> # .38.x 084189a: um: disable CONFIG_CMPXCHG_LOCAL
> 
> Why is this a stable patch?

Because it fixes a build error in 2.6.38.
See: https://bugzilla.kernel.org/show_bug.cgi?id=32812

Thanks,
//richard

> confused,
> 
> greg k-h

