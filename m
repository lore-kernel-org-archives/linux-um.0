Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1752887AbZFXMXT@vger.kernel.org>
Message-ID: <4A421AA6.5060908@panasas.com>
Date: Wed, 24 Jun 2009 15:23:02 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] UML: Fix some apparent bitrot
References: <20090620005524.25582.69677.stgit@menage.mtv.corp.google.com> <20090622024610.GC5893@cr0.nay.redhat.com>
In-Reply-To: <20090622024610.GC5893@cr0.nay.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Amerigo Wang <xiyou.wangcong@gmail.com>
Cc: Paul Menage <menage@google.com>, akpm@linux-foundation.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/22/2009 05:46 AM, Amerigo Wang wrote:
> On Fri, Jun 19, 2009 at 05:55:24PM -0700, Paul Menage wrote:
>> UML: Fix some apparent bitrot
>>
>> - migration of net_device methods into net_device_ops
>> - dma_sync_single() changes
>> - cpumask_clear() -> cpumask_clear_cpu()
>>
>> Signed-off-by: Paul Menage <menage@google.com>
> 
> 
> Looks good.
> 
> Acked-by: WANG Cong <xiyou.wangcong@gmail.com>
> 
> 

Dear Jeff, Amerigo

who is pushing this patch to Linus for 2.6.31. (ASAP)
Linus has threatened to cut -rc1 soon, and it is
unbuildable for UML currently.

Thanks in advance
Boaz
