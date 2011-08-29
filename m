Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 29 Aug 2011 23:19:22 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110829221922.GQ2203@ZenIV.linux.org.uk>
References: <1314634419-24766-1-git-send-email-richard@nod.at>
 <1314634419-24766-9-git-send-email-richard@nod.at>
 <20110829142705.5be82d7c.akpm@linux-foundation.org>
 <4E5C06DF.60508@nod.at>
 <20110829221230.GP2203@ZenIV.linux.org.uk>
 <4E5C0F9F.5000405@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E5C0F9F.5000405@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 8/9] um: fix strrchr problems
To: Richard Weinberger <richard@nod.at>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@ftp.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Aug 30, 2011 at 12:15:59AM +0200, Richard Weinberger wrote:
> Am 30.08.2011 00:12, schrieb Al Viro:
> >On Mon, Aug 29, 2011 at 11:38:39PM +0200, Richard Weinberger wrote:
> >>>
> >>>ok, I give up.  How does this work?
> >>
> >>*grrr*, you can drop this patch.
> >>To my excuse, I've dropped it already from my queue but after
> >>pulling a second time from Al's git branch it made it again into my
> >>queue and I forgot about it, sorry!
> >
> >That gets you link errors with libc-2.11...
> 
> Not here.
> I'm using 2.11.3.

Try to build it static...
