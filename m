Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfKDb-0000TX-6Y
 for linux-um@lists.infradead.org; Fri, 04 Jan 2019 07:48:36 +0000
Subject: Re: [PATCH] um: Try to avoid kmalloc in signal handling
References: <20190103160917.10217-1-anton.ivanov@cambridgegreys.com>
 <cfcec59e-e1fd-1dd9-48ac-9645152cca4d@cambridgegreys.com>
 <da88ec54-3d0b-360a-863d-59e29c8eaa00@cambridgegreys.com>
 <8232816.4fJl4d8jsT@blindfold>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <62055169-65ce-f2e9-7247-4cbd5fd296cc@cambridgegreys.com>
Date: Fri, 4 Jan 2019 07:48:30 +0000
MIME-Version: 1.0
In-Reply-To: <8232816.4fJl4d8jsT@blindfold>
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
Cc: linux-um@lists.infradead.org

On 03/01/2019 21:42, Richard Weinberger wrote:
> Am Donnerstag, 3. Januar 2019, 22:29:17 CET schrieb Anton Ivanov:
>> Second thought - this should not use kmalloc at all if it can. It should
>> either go on the stack the way it used to do before
>> b6024b21fec8367ef961a771cc9dde31f1831965 or it should have a sufficient
>> "register stack" to push registers for all use cases.
>>
>> Kmalloc/ATOMIC can fail just because it feels like it which means that
>> this can throw a panic() under very heavy IO.
> 
> Not good. :-(
> We cannot go back to stack based allocation. The stack is too small for
> AVX register sets.

If I read it correctly it still uses the stack even for the new register 
sets.

> Maybe we can preallocate it.
> (And check what arch/x86/ does)
> 
> Thanks,
> //richard
> 
> 
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

