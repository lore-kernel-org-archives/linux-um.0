Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] UML: don't discard .text.exit section
References: <CAFLxGvzB=WGNEdNJVvPpQLpwCqT6oNcvEQnyT2xk0Jv2L3FBaA@mail.gmail.com>
 <1471446611-16250-1-git-send-email-aryabinin@virtuozzo.com>
 <CACT4Y+bEnGV0X1MeGvdZM1VWqr25f61GyVqRKvQO46UGpE0VhA@mail.gmail.com>
 <995ff767-9220-f9c8-c052-2b717cc7e91d@virtuozzo.com>
 <CACT4Y+bMvLrg_PBrGYPok3j8Y90m2FNzTY9-LuRNNGR_3FgifA@mail.gmail.com>
 <627a7126-87e6-0a89-19c5-612c5fb9d18f@virtuozzo.com>
 <e9536af2-7e69-8a53-96d0-7a7a92dbea31@nod.at>
 <3bc79e3a-9604-3d61-fc68-443d8d8a70b6@virtuozzo.com>
 <CACT4Y+a+MagkN-sWkiVjYdRrvfnYmB8ewYsDBU-PcAD0FzQtdA@mail.gmail.com>
 <7ebc07c8-83fd-f5f7-4f80-f53f44ae4c55@nod.at>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <496b07cd-2737-e828-3568-f319b9681386@virtuozzo.com>
Date: Tue, 23 Aug 2016 12:59:00 +0300
MIME-Version: 1.0
In-Reply-To: <7ebc07c8-83fd-f5f7-4f80-f53f44ae4c55@nod.at>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, Dmitry Vyukov <dvyukov@google.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, Stefan Traby <stefan@hello-penguin.com>, stable <stable@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>



On 08/22/2016 11:10 PM, Richard Weinberger wrote:
> On 19.08.2016 17:24, Dmitry Vyukov wrote:
>> If it exits then
>>
>> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> 
> Andrey, shall I carry this patch through the UML tree or
> do you have something else in mind?
> 

Take it in the UML tree please.

> Thanks,
> //richard
> 

