Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-it1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKVfg-0002MV-5G
 for linux-um@lists.infradead.org; Wed, 07 Nov 2018 21:47:33 +0000
Received: by mail-it1-x12c.google.com with SMTP id b7-v6so25155743itd.5
 for <linux-um@lists.infradead.org>; Wed, 07 Nov 2018 13:47:21 -0800 (PST)
Subject: Re: Summary so far - ubd breakage in 4.20-rc1
References: <94397e9b-36a6-92b0-b074-ce3640cee00e@kot-begemot.co.uk>
 <2067083.opUWeOxqyK@blindfold>
 <fe020526-ac24-0279-ca27-7ccabba7a6cc@kernel.dk>
 <4373302.HifUKF8Eoy@blindfold>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <edaa00ed-7e65-7303-1034-7672d1ecd8cb@kernel.dk>
Date: Wed, 7 Nov 2018 14:47:18 -0700
MIME-Version: 1.0
In-Reply-To: <4373302.HifUKF8Eoy@blindfold>
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
To: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, hch@lst.de

On 11/7/18 2:46 PM, Richard Weinberger wrote:
> Am Mittwoch, 7. November 2018, 22:16:20 CET schrieb Jens Axboe:
>>>> Does the below help things?
>>>>
>>>
>>> It does!
>>> Anton, please give it also a try.
>>
>> OK good, it's definitely a bug, and given the symptoms, sounds like
>> THE bug in this case.
> 
> Shall I send your fix as patch or do you want to?

I'm going to queue it up, just waiting for Anton to also test so I
can add the appropriate Tested-by.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

