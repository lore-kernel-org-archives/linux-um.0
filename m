Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMUPp-009a6P-F5
 for linux-um@lists.infradead.org; Tue, 22 Feb 2022 12:37:15 +0000
Subject: Re: [PATCH] um: Fix uml_mconsole stop/go
References: <20220222105756.1354219-1-anton.ivanov@cambridgegreys.com>
 <c70a79c3996ef58320e8265c8e1dc89a8b0b2e6d.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <6aa0f2af-c81e-fc96-a3af-c397e6803799@cambridgegreys.com>
Date: Tue, 22 Feb 2022 12:37:00 +0000
MIME-Version: 1.0
In-Reply-To: <c70a79c3996ef58320e8265c8e1dc89a8b0b2e6d.camel@sipsolutions.net>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: rrs@debian.org, 1005900@bugs.debian.org, quake2iasi@gmail.com, richard@nod.at


On 22/02/2022 12:11, Johannes Berg wrote:
> On Tue, 2022-02-22 at 10:57 +0000, anton.ivanov@cambridgegreys.com
> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Moving to an EPOLL based IRQ controller broke uml_mconsole stop/go
>> commands. This fixes it and restores stop/go functionality.
>>
>> Fixes: ff6a17989c08b0bb0fd490cc500b084581b3a9b9 Epoll based IRQ controller
> The right format would be
>
> Fixes: ff6a17989c08 ("Epoll based IRQ controller")

Ack, will resubmit shortly.

>
> Don't think I can comment on the patch itself, sorry.

The old poll controller had all IO IRQs shared and disabled IRQ processing while in the IRQ loop. Thus a while(;;) in the IRQ loop combined with a blocking read was an effective way to stop processing.

That is no longer the case.

1. While individual IRQs are not reentrant (there is a check for that in the IRQ handler), other IRQs will be processed and each FD is allocated a separate one. So looping inside one will not stop the kernel. It will still handle timer IRQs and other IO.

2. In the old controller disable_fd() was the reentrance guard. It removed the fd from the poll set so that it is not triggered again until the IRQ is handled. It was used everywhere in the beginning of each handler (followed by re-enable at IRQ exit). It has different semantics, cost and should not be used without need in the epoll case. In fact, I removed it throughout, but somehow missed the mconsole. Still having it was a bug.

As we do not have any means to shut-off the IRQs in the IRQ controller itself, the easiest way to stop them is to kill signals - as per the patch.

>
> johannes
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

