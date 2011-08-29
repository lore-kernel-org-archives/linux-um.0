Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20110829221922.GQ2203@ZenIV.linux.org.uk>
References: <1314634419-24766-1-git-send-email-richard@nod.at>
	<1314634419-24766-9-git-send-email-richard@nod.at>
	<20110829142705.5be82d7c.akpm@linux-foundation.org>
	<4E5C06DF.60508@nod.at>
	<20110829221230.GP2203@ZenIV.linux.org.uk>
	<4E5C0F9F.5000405@nod.at>
	<20110829221922.GQ2203@ZenIV.linux.org.uk>
Date: Mon, 29 Aug 2011 18:39:06 -0400
Message-ID: <CACqU3MV_6_KZ0n3cEdP3oCxREjQ4yKmdBbEV8-he7Fn1M5jqaQ@mail.gmail.com>
From: Arnaud Lacombe <lacombar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 8/9] um: fix strrchr problems
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@ftp.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,

On Mon, Aug 29, 2011 at 6:19 PM, Al Viro <viro@zeniv.linux.org.uk> wrot=
e:
> On Tue, Aug 30, 2011 at 12:15:59AM +0200, Richard Weinberger wrote:
>> Am 30.08.2011 00:12, schrieb Al Viro:
>> >On Mon, Aug 29, 2011 at 11:38:39PM +0200, Richard Weinberger wrote:
>> >>>
>> >>>ok, I give up. =A0How does this work?
>> >>
>> >>*grrr*, you can drop this patch.
>> >>To my excuse, I've dropped it already from my queue but after
>> >>pulling a second time from Al's git branch it made it again into m=
y
>> >>queue and I forgot about it, sorry!
>> >
>> >That gets you link errors with libc-2.11...
>>
>> Not here.
>> I'm using 2.11.3.
>
> Try to build it static...
>
maybe you can just include the full error message you are getting, and
the context in which it is triggered.

[Not to say this is the first things we ask newbs to add in the commit
log, ie *what* problem does it fix. ;-)]

Thanks,
 - Arnaud
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

