Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lH3IC-00H1Ei-03
 for linux-um@lists.infradead.org; Tue, 02 Mar 2021 11:34:22 +0000
Subject: Re: linux uml segfault
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
 <c8bb257c-1542-12f5-89f1-5c1f14b8a70a@collabora.com>
 <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
 <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
 <573e256a-990b-ddf6-7965-367bb8b21229@kot-begemot.co.uk>
 <1bdedf3c60058e1ae242a2a7f16eee256b0be3e0.camel@debian.org>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <6370b92a-84fa-aa21-4270-fcaf1bf42407@kot-begemot.co.uk>
Date: Tue, 2 Mar 2021 11:34:05 +0000
MIME-Version: 1.0
In-Reply-To: <1bdedf3c60058e1ae242a2a7f16eee256b0be3e0.camel@debian.org>
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
To: rrs@debian.org, Christopher Obbard <chris.obbard@collabora.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: 983379@bugs.debian.org



On 02/03/2021 09:09, Ritesh Raj Sarraf wrote:
> On Wed, 2021-02-24 at 11:44 +0000, Anton Ivanov wrote:
>> In all cases it boots cleanly and there are no segfaults.
>>
>> So, frankly, no idea what is causing it to crash - I have run most
>> combinations of 5.10 on a 5.10, all work fine here.
> 
> Is there any other way I can help you with this issue ?
> I do have the core dump available on my local machine.

If gdb gives you the exact lines, that may be helpful.

I have looked through the bt several times, it is something through which my set-up cruises through.

The actual moment you see in the backtrace is this one:

[    0.080000] random: get_random_u32 called from bucket_table_alloc.isra.0+0x115/0x13d with crng_init=0

However, in your case, instead of getting this printk warning out it blows up.

Why - I don't know.

A.

> 
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

