Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icQUX-0003TC-OR
 for linux-um@lists.infradead.org; Wed, 04 Dec 2019 08:58:39 +0000
Subject: Re: I get 5.4 fail to start
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
References: <973c61bb-d1c4-a3ef-fec4-d492fa513d15@cambridgegreys.com>
 <CAFLxGvyKsT_Yjs9KRndqadYHQeFWpN9yzyCX8BLX6Zzigsg1vw@mail.gmail.com>
 <4d50a04d-9bef-9c12-3763-50ad80580b9e@cambridgegreys.com>
Message-ID: <6c270dbe-a6c3-e2db-01d2-7d2239d6c0ee@cambridgegreys.com>
Date: Wed, 4 Dec 2019 08:58:32 +0000
MIME-Version: 1.0
In-Reply-To: <4d50a04d-9bef-9c12-3763-50ad80580b9e@cambridgegreys.com>
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
Cc: linux-um <linux-um@lists.infradead.org>



On 03/12/2019 14:49, Anton Ivanov wrote:
> 
> 
> On 02/12/2019 20:14, Richard Weinberger wrote:
>> On Thu, Nov 28, 2019 at 6:27 PM Anton Ivanov
>> <anton.ivanov@cambridgegreys.com> wrote:
>>>
>>> Hi all,
>>>
>>> I get 5.4 fail to start. 5.4 gives:
>>>
>>> Checking that ptrace can change system call numbers...check_ptrace :
>>> child exited with exitcode 6, while expecting 0; status 0x67f
>>> Aborted
>>>
>>> And stops right at the very start.
>>>
>>> I do not recall anything there changing in the 5.2 - 5.4 timeframe so
>>> this is weird.
>>
>> Hmm, I don't see this failure. What is your host kernel, your uml
>> kernel .config and commandline?
>>
>> I agree that the macro usage is odd but why is it failing now?
>>
>> _______________________________________________
>> linux-um mailing list
>> linux-um@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-um
>>
> 
> 5.3 up to latest stable works.
> 5.4 fails.
> 5.5 fails.
> 
> Tested on 3 different Ryzen hosts (4 core and 2 different 6 core ones) 
> and an old A4 host. Same result. Tested with and without cpu pinning to 
> same core. Same result.
> 
> The failure is always the same
> 
> Checking that ptrace can change system call numbers...check_ptrace : 
> child exited with exitcode 6, while expecting 0; status 0x67f
> 
> With some extra debug statements it deciphers as follows:
> 
> WIFEXITED(status) at that point is zero. So it is not the second half of 
> the if, it is the first half which is satisfied to enter the if {}
> 
> That explains the NXIO code in the result as it is not something which 
> the ptraced child should return under normal circumstances.
> 
> What I have no idea of what happens that can return control to a WAIT on 
> a speicific PID, but without exiting (WIFEXITED being 0).
> 
> I tried to loop it until WIFEXITED is true, but that just hangs - I am 
> looking at this at the moment.
> 
> It fails even for the most basic command line - just memory, root and umid
> 
> [snip]

If I comment out the checks or make them to expect 6 it runs fine after 
that.

No idea what's going on - I do not see where the 6 can come from.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

