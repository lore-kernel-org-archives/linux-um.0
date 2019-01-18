Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkaJg-0007cG-LR
 for linux-um@lists.infradead.org; Fri, 18 Jan 2019 20:00:38 +0000
Subject: Re: [PATCH] um: Remove duplicate headers
References: <5c41e99b.1c69fb81.f240b.506a@mx.google.com>
 <dfdf5e70-f782-d90e-1059-a524a5e72b7d@cambridgegreys.com>
 <4621128.kXzvTGAT2u@blindfold>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <d9f525fb-847f-312e-43e7-c80b65936680@cambridgegreys.com>
Date: Fri, 18 Jan 2019 20:00:22 +0000
MIME-Version: 1.0
In-Reply-To: <4621128.kXzvTGAT2u@blindfold>
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
To: Richard Weinberger <richard@nod.at>
Cc: Sabyasachi Gupta <sabyasachi.linux@gmail.com>, yuehaibing@huawei.com, jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, jrdr.linux@gmail.com, brajeswar.linux@gmail.com



On 18/01/2019 19:42, Richard Weinberger wrote:
> Am Freitag, 18. Januar 2019, 20:23:07 CET schrieb Anton Ivanov:
>>
>> On 18/01/2019 14:58, Sabyasachi Gupta wrote:
>>> Remove sys/socket.h and sys/uio.h which are included more than once
>>>
>>> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>>> ---
>>>    arch/um/drivers/vector_user.c | 2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
>>> index d2c17dd..c863921 100644
>>> --- a/arch/um/drivers/vector_user.c
>>> +++ b/arch/um/drivers/vector_user.c
>>> @@ -23,7 +23,6 @@
>>>    #include <netinet/ether.h>
>>>    #include <linux/if_ether.h>
>>>    #include <linux/if_packet.h>
>>> -#include <sys/socket.h>
>>>    #include <sys/wait.h>
>>>    #include <sys/uio.h>
>>>    #include <linux/virtio_net.h>
>>> @@ -31,7 +30,6 @@
>>>    #include <stdlib.h>
>>>    #include <os.h>
>>>    #include <um_malloc.h>
>>> -#include <sys/uio.h>
>>>    #include "vector_user.h"
>>>    
>>>    #define ID_GRE 0
>>>
>>
>> Hi Sabyasachi,
>>
>> I believe we have an identical patch enqueued already from a couple of
>> weeks back.
> 
> Hmm, did I miss that one in patchwork?
> 
> Thanks,
> //richard
> 
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 
https://patchwork.ozlabs.org/patch/1020163/

A.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

