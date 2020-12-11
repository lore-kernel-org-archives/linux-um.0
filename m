Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knq0U-0006iH-7f
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 21:31:19 +0000
Subject: Re: [PATCH v4 3/7] um: "borrow" atomics from x86 architecture
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
 <20201211174559.26010-4-anton.ivanov@cambridgegreys.com>
 <d5ca568663ab7394ead9a5345ce42df16b5f6aaa.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <ff45d437-a79f-7678-6127-d772080fa838@cambridgegreys.com>
Date: Fri, 11 Dec 2020 21:31:13 +0000
MIME-Version: 1.0
In-Reply-To: <d5ca568663ab7394ead9a5345ce42df16b5f6aaa.camel@sipsolutions.net>
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

On 11/12/2020 20:08, Johannes Berg wrote:
> On Fri, 2020-12-11 at 17:45 +0000, anton.ivanov@cambridgegreys.com
> wrote:
>> +++ b/arch/um/include/asm/atomic.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_ATOMIC_XOR_H
> XOR?

Brainfart

Will fix it in v5.

>
> And also here - are the symlinks really needed?
>
> Not that I mind them too much, but it's a bit strange ... and would be a
> lot harder to port to other arches, if anyone should be inclined, if
> there are hard symlinks to x86.
>
> johannes
>
>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

