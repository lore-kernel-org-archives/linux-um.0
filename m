Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201107051128.25262.richard@nod.at>
References: <1309821341.4527.5.camel@vitaliy-Vostro-1400>
	<201107051128.25262.richard@nod.at>
Date: Tue, 5 Jul 2011 14:10:34 +0300
Message-ID: <CAGTPOqcAETWHG3DEOwDZkMG8_qd-opf90psCi=+U+tYcGV=7=A@mail.gmail.com>
From: Vitaliy Ivanov <vitalivanov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/4] uml: cow_user.c warning corrections
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Jul 5, 2011 at 12:28 PM, Richard Weinberger <richard@nod.at> wr=
ote:
> Am Dienstag 05 Juli 2011, 01:15:41 schrieb Vitaliy Ivanov:
>> From 6201d3e862fca8670b206338dc90303ea0acc77d Mon Sep 17 00:00:00 20=
01
>> From: Vitaliy Ivanov <vitalivanov@gmail.com>
>> Date: Tue, 5 Jul 2011 01:57:51 +0300
>> Subject: [PATCH 1/4] uml: cow_user.c warning corrections
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=3DUTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> arch/um/drivers/cow_user.c: In function =91absolutize=92:
>> arch/um/drivers/cow_user.c:189:7: warning: ignoring return value of
>> =91chdir=92, declared with attribute warn_unused_result
>
> What compiler flags are you using?
> Using the default settings this warning does not show up.
> Most of the "ignoring return value" are totally useless.

chdir is defined with warn_unused_result attribute and my gcc on
Ubuntu 11.04 issues warnings.
I don't use any additional flags on compiling UML.

Vitaliy
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

