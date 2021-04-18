Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lY1zb-00ALDo-8d
 for linux-um@lists.infradead.org; Sun, 18 Apr 2021 07:37:23 +0000
Subject: Re: [PATCH] uml/helper: Fix stack alignment
References: <20210417163949.530921-1-zhuyifei1999@gmail.com>
 <9722b8ce233ad4d7020588f9dd60a3037455754d.camel@sipsolutions.net>
 <CABqSeATg2558BgMWMBs3O3vuR9wWS30d=x2iug3S-M1eMFi+qQ@mail.gmail.com>
 <CABqSeATiUxfev8O4ZRdi_jvLEXC2MMuomE_nKv=mG2b_3eP-qA@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <dd72c089-b631-c658-f320-4de52a283dc0@cambridgegreys.com>
Date: Sun, 18 Apr 2021 08:36:58 +0100
MIME-Version: 1.0
In-Reply-To: <CABqSeATiUxfev8O4ZRdi_jvLEXC2MMuomE_nKv=mG2b_3eP-qA@mail.gmail.com>
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
To: YiFei Zhu <zhuyifei1999@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>

On 18/04/2021 07:56, YiFei Zhu wrote:
> On Sat, Apr 17, 2021 at 11:56 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>>    * um on um x86_64: I'm having trouble testing um within um, getting
>> a weird error ("start_userspace : expected SIGSTOP, got status = 2943"
>> when starting init, might try to debug later), but the code in
>> handle_signal also aligns the stack.
> 
> Figured this one out. The inner um, in userspace_tramp, is trying to
> mmap the syscall stub to the same syscall stub at the same location as
> the outer um, and that fails with ENOMEM. In theory, this would cause
> the printk of "mapping mmap stub at ... failed, errno = ..." to occur,
> but because:
> * call stack: vprintk_store -> printk_caller_id -> in_task -> in_nmi
> -> nmi_count -> preempt_count -> current_thread_info
> * um's current_thread_info is at the current stack pointer & mask,
> hence it is often not valid when on small temporary stacks.
> Therefore, userspace_tramp can't printk.
> 
> I'm wondering, is this issue of printk being broken in userspace_tramp
> an issue worth fixing? Has there been prior discussions on it?
> 
> YiFei Zhu
> 

Based ob experience - printk does not work correctly out of some uml 
threads. We had to kill printk use in the ubd helper thread.

I never got to the bottom of that, it was easier to kill it. In that 
case it was not particularly informative.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

