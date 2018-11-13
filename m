Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMYma-0001my-8C
 for linux-um@lists.infradead.org; Tue, 13 Nov 2018 13:31:09 +0000
Received: by mail-pf1-x443.google.com with SMTP id g7-v6so6054281pfo.10
 for <linux-um@lists.infradead.org>; Tue, 13 Nov 2018 05:30:57 -0800 (PST)
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
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1d7151d0-62b7-000c-c506-7b321bf788bb@kernel.dk>
Date: Tue, 13 Nov 2018 06:30:53 -0700
MIME-Version: 1.0
In-Reply-To: <e6df0eee-6446-08b1-42be-ee93c95613cc@cambridgegreys.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: richard@nod.at, hch@lst.de

On 11/13/18 3:15 AM, Anton Ivanov wrote:
> I have figured out part of it. It is not caused by the block layer at 
> all. The offending parts are printks in the io thread. You simply cannot 
> printk out of there, that causes the spinlock recursion, irqs, on/off, 
> etc warning.
> 
> This means that any errors MUST be reported only after they have gone 
> back to the main UML kernel thread.

That's a pretty serious issue with UML, there's absolutely nothing wrong
with doing printk from IRQ context, or from an IO thread like this one.
You don't know what the call stack below you will do for functions you
call, this is a ticking time bomb.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

