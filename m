Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Sep 2010 19:27:37 -0700 (PDT)
Message-Id: <20100929.192737.242138187.davem@davemloft.net>
Subject: Re: {painfully BISECTED} Please revert f25c80a4b2:
 arch/um/drivers: remove duplicate structure field initialization
From: David Miller <davem@davemloft.net>
In-Reply-To: <AANLkTi=aqtzLskpTeZkQwEGRg9jb=NJ8UcQG=vkdc20z@mail.gmail.com>
References: <AANLkTi=E7+CpJZE3XC7O1LvJu6LWfmvSxonskH4CYg25@mail.gmail.com>
	<4CA2FBBB.3040004@panasas.com>
	<AANLkTi=aqtzLskpTeZkQwEGRg9jb=NJ8UcQG=vkdc20z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: bharrosh@panasas.com, akpm@linux-foundation.org, julia@diku.dk, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, shemminger@vyatta.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Sep 2010 08:01:07 -0700

> On Wed, Sep 29, 2010 at 1:41 AM, Boaz Harrosh <bharrosh@panasas.com> wrote:
>>
>> With this I'm now back to my usual: boots fine but half of the times
>> not halting. But I think that's a Fedora12 problem with interaction
>> with uml. (Which I do not have time to investigate)
> 
> So that "half of the time not halting" happened with the revert too?
> If so, we should just do the fix. Thanks for testing.

Linus, I've queued up your fix into my tree.
