Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Tue, 5 Jul 2011 13:31:14 +0200
References: <1309821341.4527.5.camel@vitaliy-Vostro-1400> <201107051128.25262.richard@nod.at> <CAGTPOqcAETWHG3DEOwDZkMG8_qd-opf90psCi=+U+tYcGV=7=A@mail.gmail.com>
In-Reply-To: <CAGTPOqcAETWHG3DEOwDZkMG8_qd-opf90psCi=+U+tYcGV=7=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <201107051331.15504.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/4] uml: cow_user.c warning corrections
To: Vitaliy Ivanov <vitalivanov@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Dienstag 05 Juli 2011, 13:10:34 schrieb Vitaliy Ivanov:
> On Tue, Jul 5, 2011 at 12:28 PM, Richard Weinberger <richard@nod.at> =
wrote:
> > Am Dienstag 05 Juli 2011, 01:15:41 schrieb Vitaliy Ivanov:
> >> From 6201d3e862fca8670b206338dc90303ea0acc77d Mon Sep 17 00:00:00 =
2001
> >> From: Vitaliy Ivanov <vitalivanov@gmail.com>
> >> Date: Tue, 5 Jul 2011 01:57:51 +0300
> >> Subject: [PATCH 1/4] uml: cow_user.c warning corrections
> >> MIME-Version: 1.0
> >> Content-Type: text/plain; charset=3DUTF-8
> >> Content-Transfer-Encoding: 8bit
> >>=20
> >> arch/um/drivers/cow_user.c: In function =91absolutize=92:
> >> arch/um/drivers/cow_user.c:189:7: warning: ignoring return value o=
f
> >> =91chdir=92, declared with attribute warn_unused_result
> >=20
> > What compiler flags are you using?
> > Using the default settings this warning does not show up.
> > Most of the "ignoring return value" are totally useless.
>=20
> chdir is defined with warn_unused_result attribute and my gcc on
> Ubuntu 11.04 issues warnings.
> I don't use any additional flags on compiling UML.

Ah, because of -D_FORTIFY_SOURCE=3D2, right?
Then your patches makes sense.

I'll add it to my queue.

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

