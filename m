Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMZAv-0005Av-C9
 for linux-um@lists.infradead.org; Tue, 13 Nov 2018 13:56:18 +0000
Subject: Re: New Patch series for the UBD Driver
References: <20181112174201.12290-1-anton.ivanov@cambridgegreys.com>
 <62f14981-9804-8fac-c3ec-b544a90751c3@kernel.dk>
 <58614d39-8c3b-4e8e-7b41-633bb52b533e@cambridgegreys.com>
 <880075e6-1032-fe4f-0001-085d7409eb54@kernel.dk>
 <b332d9d1-a5ee-c69f-fa3b-f5e0703c1153@cambridgegreys.com>
 <2b318d17-7fde-991b-fda4-271fde2a7db9@kernel.dk>
 <0e31d0a6-64f0-208e-bfc8-acd05db432f1@cambridgegreys.com>
 <b50be83c-8309-5068-b5bb-8dad89f24913@kernel.dk>
 <1d334c50-0f89-70e7-b6c7-fe0d719ed5df@cambridgegreys.com>
 <1e27868d-974b-9554-1010-a7e28a238479@kernel.dk>
 <17fab2bf-416b-3c61-e5c6-d315fb9105b3@kernel.dk>
 <651eb31c-4f75-0174-cd1a-a045d8d93991@cambridgegreys.com>
 <e6df0eee-6446-08b1-42be-ee93c95613cc@cambridgegreys.com>
 <1d7151d0-62b7-000c-c506-7b321bf788bb@kernel.dk>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <80368030-ddd5-df57-1ecd-28fa91cc37b0@cambridgegreys.com>
Date: Tue, 13 Nov 2018 13:56:02 +0000
MIME-Version: 1.0
In-Reply-To: <1d7151d0-62b7-000c-c506-7b321bf788bb@kernel.dk>
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
To: Jens Axboe <axboe@kernel.dk>, linux-um@lists.infradead.org
Cc: richard@nod.at, hch@lst.de

On 13/11/2018 13:30, Jens Axboe wrote:
> On 11/13/18 3:15 AM, Anton Ivanov wrote:
>> I have figured out part of it. It is not caused by the block layer at
>> all. The offending parts are printks in the io thread. You simply cannot
>> printk out of there, that causes the spinlock recursion, irqs, on/off,
>> etc warning.
>>
>> This means that any errors MUST be reported only after they have gone
>> back to the main UML kernel thread.
> That's a pretty serious issue with UML, there's absolutely nothing wrong
> with doing printk from IRQ context, or from an IO thread like this one.
> You don't know what the call stack below you will do for functions you
> call, this is a ticking time bomb.

This is not a normal kernel IO thread. It is a host-side helper thread. 
There are two of those - one for UBD and and one for sigio.

I am not qualified to judge what is normal and not there, but they 
operate "outside" normal kernel authority and communicate only via their 
IPC pipe.

It is not interrupt context - it is an equivalent of "inside the actual 
device".

They are doing specific "hardware emulation". In fact, while their IPC 
presently assumes shared address space with the kernel, that does not 
need to be the case.

So there is little or no reason for them to have access to any normal 
kernel facilities after their initial startup. The benefits of printks 
there are minimal (if any). If there is an error in the IPC pipe it goes 
both way so the kernel side will see it. If there is an error in the 
actual operation, it is conveyed via the IPC so the kernel sees it as well.

So I am not sure about the ticking bomb. Unpleasant limitation for 
debugging - yes. Ticking bomb... Not sure.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

