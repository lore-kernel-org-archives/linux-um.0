Return-Path: <anton.ivanov@cambridgegreys.com>
Subject: Re: I get 5.4 fail to start
References: <973c61bb-d1c4-a3ef-fec4-d492fa513d15@cambridgegreys.com>
 <CAFLxGvyKsT_Yjs9KRndqadYHQeFWpN9yzyCX8BLX6Zzigsg1vw@mail.gmail.com>
 <4d50a04d-9bef-9c12-3763-50ad80580b9e@cambridgegreys.com>
 <6c270dbe-a6c3-e2db-01d2-7d2239d6c0ee@cambridgegreys.com>
 <1054145.106334.1575450216775.JavaMail.zimbra@nod.at>
 <aaaa5a05-efd3-4f6c-7728-86c8b0f08a7d@cambridgegreys.com>
 <CAMuHMdVrLPKwXxfyG3-Y5yUF9KPrTzosydxN1rkBFcJXsWi86Q@mail.gmail.com>
 <a9620d0a-31cd-f208-76de-63406496e4a0@cambridgegreys.com>
 <86abb3cc-1557-b5de-9c35-fdc67855030c@cambridgegreys.com>
 <6aaec3f72344246f10b0fb65a08efae5d258be9a.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <0bb1c370-8a63-a2e8-afd6-6e95acf9efb2@cambridgegreys.com>
Date: Wed, 4 Dec 2019 12:51:42 +0000
MIME-Version: 1.0
In-Reply-To: <6aaec3f72344246f10b0fb65a08efae5d258be9a.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Johannes Berg <johannes@sipsolutions.net>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>



On 04/12/2019 11:58, Johannes Berg wrote:
> On Wed, 2019-12-04 at 11:34 +0000, Anton Ivanov wrote:
>>
>> 786b2384bf1c1b53dc23dc493aaaae29ef01e6ce - enable CONSTRUCTORS
>>
>> Previous before it is good. From there onwards it's a fail.
> 
> Oops. Try to revert it? We don't _really_ need it right now. It did work
> on my system, but there's a good chance that there's something gcc/libc
> dependent in there.

It tests out fine if I revert it.

I still do not understand how and why it managed to produce this weird 
effect with ptrace though.


> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

