Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gLECT-0007sG-57
 for linux-um@lists.infradead.org; Fri, 09 Nov 2018 21:20:21 +0000
Subject: Re: [PATCH] Add DISCARD support to UML udb driver
References: <20181109091937.25470-1-anton.ivanov@cambridgegreys.com>
 <CAFLxGvxy7d_9--b_SPcPQ_e=Er0aJds5TBqfd5Q-OANCj6DOaQ@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <79343bcf-8cf7-27e8-1d53-ee404f6431bd@cambridgegreys.com>
Date: Fri, 9 Nov 2018 21:20:03 +0000
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxy7d_9--b_SPcPQ_e=Er0aJds5TBqfd5Q-OANCj6DOaQ@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-um@lists.infradead.org, Christoph Hellwig <hch@lst.de>

On 09/11/2018 21:04, Richard Weinberger wrote:
> On Fri, Nov 9, 2018 at 10:20 AM <anton.ivanov@cambridgegreys.com> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> 1. Remove UBD specific opcode definitions and reuse the block-mq
>> ones
>> 2. Add DISCARD and ZERO fill support (tested with ext4).
>> 3. Further cleanup on the request forming, request checking and
>> handling of unexpected command codes.
> As Jens already asked, please one patch per logical change.
> Also make sure to use a proper subject line.
> Either prefix with "um: ..."  or "ubd: ...".
> If prefer "um", but if it really affects only the ubd driver, "ubd:"
> is fine too.
Ack. I should have revised series on Monday.
>
>> +int os_falloc_punch(int fd, unsigned long long offset, int len)
>> +{
>> +       int n = fallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, offset, len);
>> +
>> +       if (n < 0)
>> +               return -errno;
>> +       return n;
>> +}
> What shall happen if the host filesystem does not support these
> fallocate() operations?
> I guess we need to probe for them first and decide whether to
> accept/offer the discard command
> at run time.

If it the filesystem is using periodic (not realtime) fstrim, It will 
return IO error on those and fstrim will fail. Normal file ops - write, 
read, fsync should continue as this should not force a remount.

I could not test with realtime fstrim ans btrfs was having some issues 
in 4.20-rc1. It was hitting spinlock recursions and irq on/off where 
they should not be BUG()s.

Non-destructive probing is a bit difficult. IMHO, we should leave this 
to the user and add flags the way nbd and loop have done it. We can also 
add a config option to set a default on or off at compile time (same as 
for sync io on ubd).

Most major filesystems support the relevant flags since 3.x. I am not 
aware at what point did the libc function appear.

A.


>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

