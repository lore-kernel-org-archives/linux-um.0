Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <f71e33e5-dc7b-375e-e086-11ab9aca1311@igalia.com>
Date: Fri, 29 Apr 2022 12:46:11 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 11/30] um: Improve panic notifiers consistency and
 ordering
Content-Language: en-US
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-12-gpiccoli@igalia.com>
 <98a1bff1a4cc798f0a02fd10a5f3b291c68ad1d7.camel@sipsolutions.net>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <98a1bff1a4cc798f0a02fd10a5f3b291c68ad1d7.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, "linux-um@lists.infradead.orgAnton Ivanov" <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>
List-ID: <linux-um.lists.infradead.org>

On 28/04/2022 05:30, Johannes Berg wrote:
> [trimming massive CC list]
> 
> On Wed, 2022-04-27 at 19:49 -0300, Guilherme G. Piccoli wrote:
>>
>> Also, we remove a useless header inclusion.
> 
> I wouldn't say it's useless, generally we try not to rely on implicit
> includes so much? And you at least now use NOTIFY_DONE from it.
> 
> Otherwise looks fine to me.
> 
> johannes

Hi Johannes, thanks for your prompt response, and for clearing a bit the
*huge* CC list, it got really humongous...

I agree with you here - I missed that there's also a reboot notifier in
"mconsole_kern.c", so seems it makes sense to keep the header. I'll fix
that for V2, ok? If it was only a panic notifier I would consider it
useless maybe, but we have non-panic notifier as well heh

Cheers,


Guilherme

