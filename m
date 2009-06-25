Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1760200AbZFYKp5@vger.kernel.org>
Date: Thu, 25 Jun 2009 18:47:00 +0800
From: Amerigo Wang <xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [PATCH] UML: Fix some apparent bitrot
Message-ID: <20090625104700.GF6374@cr0.nay.redhat.com>
References: <20090620005524.25582.69677.stgit@menage.mtv.corp.google.com> <20090622024610.GC5893@cr0.nay.redhat.com> <4A421AA6.5060908@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A421AA6.5060908@panasas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Amerigo Wang <xiyou.wangcong@gmail.com>, Paul Menage <menage@google.com>, akpm@linux-foundation.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


On Wed, Jun 24, 2009 at 03:23:02PM +0300, Boaz Harrosh wrote:
>On 06/22/2009 05:46 AM, Amerigo Wang wrote:
>> On Fri, Jun 19, 2009 at 05:55:24PM -0700, Paul Menage wrote:
>>> UML: Fix some apparent bitrot
>>>
>>> - migration of net_device methods into net_device_ops
>>> - dma_sync_single() changes
>>> - cpumask_clear() -> cpumask_clear_cpu()
>>>
>>> Signed-off-by: Paul Menage <menage@google.com>
>> 
>> 
>> Looks good.
>> 
>> Acked-by: WANG Cong <xiyou.wangcong@gmail.com>
>> 
>> 
>
>Dear Jeff, Amerigo
>
>who is pushing this patch to Linus for 2.6.31. (ASAP)
>Linus has threatened to cut -rc1 soon, and it is
>unbuildable for UML currently.

Hello, Boaz.

It is supposed to be Jeff who should take UML patches,
but since we haven't seen Jeff for a long time, Andrew
should help us to take them.

So Andrew? ping... :)
