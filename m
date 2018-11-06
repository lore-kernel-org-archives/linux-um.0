Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gK5Mz-00013z-ME
 for linux-um@lists.infradead.org; Tue, 06 Nov 2018 17:42:30 +0000
Subject: Re: 4.20-rc1 looks broken for UML
References: <4a096c4f-6552-dbcb-676b-a87306dde07a@kot-begemot.co.uk>
 <11176055.DIHjKAC0ao@blindfold>
 <a14a0d2e-d734-7f1c-847b-7aa31e9affac@kot-begemot.co.uk>
 <1819644.8DN5KTyJeP@blindfold>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <ce0ede07-20f2-800d-4e20-3d47a0980d57@kot-begemot.co.uk>
Date: Tue, 6 Nov 2018 17:42:16 +0000
MIME-Version: 1.0
In-Reply-To: <1819644.8DN5KTyJeP@blindfold>
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
Cc: gregkh@linuxfoundation.org, linux-um@lists.infradead.org


On 11/6/18 5:04 PM, Richard Weinberger wrote:
> Am Dienstag, 6. November 2018, 16:00:59 CET schrieb Anton Ivanov:
>> On 11/5/18 10:07 PM, Richard Weinberger wrote:
>>> Anton,
>>>
>>> Am Montag, 5. November 2018, 16:22:36 CET schrieb Anton Ivanov:
>>>> This looks like something specific to ttys - the io there gets
>>>> corruption and/or hangs.
>>>>
>>>> I cannot reproduce it when I ssh in.
>>>>
>>>> It does not look like it is the new write IRQ bugfix - that works fine
>>>> over 4.19.
>>>>
>>>> Still debugging...
>>> Hmm, I don't see this with my Debian userspace.
>>> What exactly is your setup/config?
>>
>> Gotcha.
>>
>> 8ebfe885c65ec82a0b1e955cf99ed62664e84414 is the guilty party.
>>
>> With it, I get tty corruption on UML. Any attempt to push a large amount
>> of data via the console results in spurious echoes or even a hang.
>>
>> Reverting it fixes things.
> Really?!
> This is "TTY: sn_console: Replace spin_is_locked() with spin_trylock()".
> sn_console is "SGI Altix L1 serial console"...

Mea culpa.

I was going through the commits from the tty changes one by one and for 
some reason things started working after reverting this one.

I cannot reproduce the original issue now with a totally clean build and 
a clean image.

I am going back through my local tree and images to see what caused in 
the first place.

For now it looks like 4.20-rc1 is OK.

A.


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

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

