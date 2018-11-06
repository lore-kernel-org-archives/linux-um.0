Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gK2xB-00071P-4Z
 for linux-um@lists.infradead.org; Tue, 06 Nov 2018 15:07:42 +0000
Subject: Re: 4.20-rc1 looks broken for UML
References: <4a096c4f-6552-dbcb-676b-a87306dde07a@kot-begemot.co.uk>
 <1ae6cae1-25a2-30e8-5078-ac318ce73f33@kot-begemot.co.uk>
 <11176055.DIHjKAC0ao@blindfold>
 <a14a0d2e-d734-7f1c-847b-7aa31e9affac@kot-begemot.co.uk>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <5de426d0-9707-f470-95fe-a442a5ff91ed@kot-begemot.co.uk>
Date: Tue, 6 Nov 2018 15:07:17 +0000
MIME-Version: 1.0
In-Reply-To: <a14a0d2e-d734-7f1c-847b-7aa31e9affac@kot-begemot.co.uk>
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
To: linux-um@lists.infradead.org
Cc: gregkh@linuxfoundation.org, ldr709@gmail.com

Resend - got Greg's address wrong and missed the commit author. Apologies.

On 11/6/18 3:00 PM, Anton Ivanov wrote:
>
> On 11/5/18 10:07 PM, Richard Weinberger wrote:
>> Anton,
>>
>> Am Montag, 5. November 2018, 16:22:36 CET schrieb Anton Ivanov:
>>> This looks like something specific to ttys - the io there gets
>>> corruption and/or hangs.
>>>
>>> I cannot reproduce it when I ssh in.
>>>
>>> It does not look like it is the new write IRQ bugfix - that works fine
>>> over 4.19.
>>>
>>> Still debugging...
>> Hmm, I don't see this with my Debian userspace.
>> What exactly is your setup/config?
>
>
> Gotcha.
>
> 8ebfe885c65ec82a0b1e955cf99ed62664e84414 is the guilty party.
>
> With it, I get tty corruption on UML. Any attempt to push a large 
> amount of data via the console results in spurious echoes or even a hang.
>
> Reverting it fixes things.
>
> Cc-ing Greg - it was merged from his tree.
>
> I will try to figure out what exactly is wrong with it in the 
> meantime. On first reading it looked OK.
>
> A
>
>
>> Thanks,
>> //richard
>>
>>
>>
>> _______________________________________________
>> linux-um mailing list
>> linux-um@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-um
>>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

