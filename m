Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmKyn-0000UM-Q0
 for linux-um@lists.infradead.org; Mon, 07 Dec 2020 18:11:22 +0000
Subject: Re: [PATCH 1/3] um: Monitor error events in IRQ controller
References: <20201207171940.25240-1-anton.ivanov@cambridgegreys.com>
 <3904ecc6b329edc1af908f7701bc08fb18316fff.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <f5f1c309-461c-592c-2d6a-7de8511c2e8e@cambridgegreys.com>
Date: Mon, 7 Dec 2020 18:11:16 +0000
MIME-Version: 1.0
In-Reply-To: <3904ecc6b329edc1af908f7701bc08fb18316fff.camel@sipsolutions.net>
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
Cc: richard@nod.at

On 07/12/2020 17:35, Johannes Berg wrote:
> On Mon, 2020-12-07 at 17:19 +0000, anton.ivanov@cambridgegreys.com
> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Ensure that file closes, connection closes, etc are propagated
>> as interrupts in the interrupt controller.
>>
>> Fixes: ff6a17989c08 ("Epoll based IRQ controller")
>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> ---
>>   arch/um/os-Linux/irq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
>> index d508310ee5e1..f1732c308c61 100644
>> --- a/arch/um/os-Linux/irq.c
>> +++ b/arch/um/os-Linux/irq.c
>> @@ -48,7 +48,7 @@ int os_epoll_triggered(int index, int events)
>>   int os_event_mask(int irq_type)
>>   {
>>   	if (irq_type == IRQ_READ)
>> -		return EPOLLIN | EPOLLPRI;
>> +		return EPOLLIN | EPOLLPRI | EPOLLERR | EPOLLHUP | EPOLLRDHUP;
>>   	if (irq_type == IRQ_WRITE)
>>   		return EPOLLOUT;
> 
> Why not monitor it also for write?

The write code in most drivers has no error checking and no close upon 
error.

I will have to go through them and ensure they behave correctly first.

So - yes, it's a good idea and we will add it later, once I have 
double-checked all drivers.

> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

