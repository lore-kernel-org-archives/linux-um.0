Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: Fix compile failure due to current_text_address()
 definition
References: <20161110015326.GA51351@juliacomputing.com>
 <f95971bb-8e9a-3937-a3f7-b1904fb61af1@nod.at>
 <CABV8kRxxjigyieEZJwywUxDmf_LAqSqHpsvd46nWueJe7hFCsg@mail.gmail.com>
 <b2baeaa1-b19c-c95f-2cee-4b4ba0411ca7@nod.at>
 <CABV8kRyr+PZmfd8B+rN2vWfbnmjmp85oGH_BU7zbUyqDQt+NxQ@mail.gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <eaa15fe0-dee2-3969-012a-9a0356acc069@nod.at>
Date: Thu, 10 Nov 2016 21:19:16 +0100
MIME-Version: 1.0
In-Reply-To: <CABV8kRyr+PZmfd8B+rN2vWfbnmjmp85oGH_BU7zbUyqDQt+NxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Keno Fischer <keno@juliacomputing.com>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Keno,

On 10.11.2016 21:14, Keno Fischer wrote:
> Yes

Can you please reply to Sebastian's patch series and explain him how you trigger
that error?
I don't have a gcc broken by Debian on my machine right now.

> On Thu, Nov 10, 2016 at 3:14 PM, Richard Weinberger <richard@nod.at> wrote:
>> Keno,
>>
>> On 10.11.2016 21:10, Keno Fischer wrote:
>>>> The problem is ready being solved in a generic way:
>>>> http://marc.info/?l=linux-kernel&m=147828481602561&w=2
>>>>
>>>> Can you please give this patch a try?
>>>
>>> No dice. After backing out my patch and applying that one I get:
>>>
>>> /usr/bin/ld: error: net/built-in.o: requires unsupported dynamic reloc
>>> 11; recompile with -fPIC
>>
>> But you applied the whole series, right?

Thanks,
//richard

