Return-Path: <anton.ivanov@cambridgegreys.com>
Subject: Re: I get 5.4 fail to start
References: <973c61bb-d1c4-a3ef-fec4-d492fa513d15@cambridgegreys.com>
 <CAFLxGvyKsT_Yjs9KRndqadYHQeFWpN9yzyCX8BLX6Zzigsg1vw@mail.gmail.com>
 <4d50a04d-9bef-9c12-3763-50ad80580b9e@cambridgegreys.com>
 <6c270dbe-a6c3-e2db-01d2-7d2239d6c0ee@cambridgegreys.com>
 <1054145.106334.1575450216775.JavaMail.zimbra@nod.at>
 <aaaa5a05-efd3-4f6c-7728-86c8b0f08a7d@cambridgegreys.com>
 <CAMuHMdVrLPKwXxfyG3-Y5yUF9KPrTzosydxN1rkBFcJXsWi86Q@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <a9620d0a-31cd-f208-76de-63406496e4a0@cambridgegreys.com>
Date: Wed, 4 Dec 2019 10:27:42 +0000
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVrLPKwXxfyG3-Y5yUF9KPrTzosydxN1rkBFcJXsWi86Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>



On 04/12/2019 10:13, Geert Uytterhoeven wrote:
> Hi Anton,
> 
> On Wed, Dec 4, 2019 at 10:20 AM Anton Ivanov
> <anton.ivanov@cambridgegreys.com> wrote:
>> On 04/12/2019 09:03, Richard Weinberger wrote:
>>> ----- Ursprüngliche Mail -----
>>>> Von: "anton ivanov" <anton.ivanov@cambridgegreys.com>
>>>>> [snip]
>>>>
>>>> If I comment out the checks or make them to expect 6 it runs fine after
>>>> that.
>>>>
>>>> No idea what's going on - I do not see where the 6 can come from.
>>>
>>> I suspect a change/regression on the host side, not the UML side.
>>> Maybe some LSM module which makes ptrace() "better"?
>>
>> This is possible. I will run host regression as well to see if it is any
>> different.
>>
>> I still do not have any ideas on why do I get UML with up to 5.3 guest
>> working and breaking in 5.4 and 5.5-rc...
>>
>> The change in that case is guest only - they are all being run on the
>> same 5.3 host (and occasionally on a 4.19).
>>
>> I am going through the kbuild and makefile changes between 5.3 and 5.4
>> at the moment to try to figure it out.
> 
> Have you tried git bisect?

Under way at the moment. I first tried to have a look at usual suspects 
before I resorted to that because the window is quite big.

I have 5.3 - good and 5.4-rc1 bad which is 12733 commits :)



> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

