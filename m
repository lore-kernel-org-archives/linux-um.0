Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4CA0A502.5040404@turmel.org>
Date: Mon, 27 Sep 2010 10:06:58 -0400
From: Phil Turmel <philip@turmel.org>
MIME-Version: 1.0
Subject: Re: {painfully BISECTED} Please revert f25c80a4b2:  arch/um/drivers:
 remove duplicate structure field initialization
References: <4CA09977.80506@panasas.com>
In-Reply-To: <4CA09977.80506@panasas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Julia Lawall <julia@diku.dk>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Stephen Hemminger <shemminger@vyatta.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 09/27/2010 09:17 AM, Boaz Harrosh wrote:
[snip /]
> 
> <RANT A HEAD CAN BE IGNORED>
> 
> It has become extremely hard to bisect a simple problem in latest Kernels!
> 
> Most mainline merges during a merge window are based on an rc1 of the previous
> Kernel. In the last 5 Kernels there was a 90% chance of a BAD bug in systems
> I use, at rc1. If a bug is found that needs bisecting. The other bugs creep
> up during bisect and mask out the possibility to bisect.

I had similar problems when bisecting the recent USB HID regression.  Once I
realized that "bisect skip" kept dropping me into a rats nest, I guessed on
-rc2 and was able to proceed from there.

...

> In short I wish at some 2.6.XX-rc[45] of every Kernel cycle. Maintainers
> would rebase their next's tree of [XX+1] to a some what more stable rc.
> Sure re-run all the tests. They still have time for the new tree in next
> to be tested and verified before the next merge window.
> (Hell one of my bisect points took me as back as 2.6.34)
> 
> Please remind me why maintainers should not rebase their trees once
> committed, to the point that they don't rebase even for buggy patches
> that are already in next, and apply fix patches, all within the same
> merge window. The same is also done with merge conflicts with the
> rc-cycle of their own code, instead of rebasing.
> 
> So in short this is a call for, possibly, cleaner History in main Kernel.
> Please remind me why re-writing history is a bad thing.

I can't comment on whether rebasing is reasonable at that level, but I
was wondering if it made sense to teach git bisect to automatically
cherry-pick known regression fixes.  If I recall correctly, someone once
suggested a  history tag of the form "Fixes: <git-commit-id>".  By itself,
that's probably not sufficient, as I'm sure some relevant commits would
get through without that tag.  A separate index file containing pairs of
commit-ids could supplement the main history.

If that sounds like a reasonable approach, I'm willing to take a stab at
implementing it.  (Unless someone smarter than me beats me to it, of course.)

Phil
