Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54428500.6020304@nod.at>
Date: Sat, 18 Oct 2014 17:19:28 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <544277C5.9030302@gmx.at> <54427C48.9050608@nod.at> <54428348.2050209@gmx.at>
In-Reply-To: <54428348.2050209@gmx.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Remove unused bp stack-frame pointer
To: Manfred Schlaegl <manfred.schlaegl@gmx.at>, Jeff Dike <jdike@addtoit.com>
Cc: Daniel Walter <dwalter@google.com>, Randy Dunlap <rdunlap@infradead.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 18.10.2014 um 17:12 schrieb Manfred Schlaegl:
> On 2014-10-18 16:42, Richard Weinberger wrote:
>> Am 18.10.2014 um 16:23 schrieb Manfred Schlaegl:
>>> The pointer to bp stack-frame is no longer used. Removed it.
>>
>> Good catch!
> Thank you.
>=20
>>
>>> This also removes a corresponding compiler-warning.
>>
>> Which warning exactly?
>=20
> On "normal" (defconfig) builds the warning does not show up because C=
ONFIG_FRAME_POINTER is set.
> I've found the unused bp because CONFIG_FRAME_POINTER was not set in =
my configuration.
>=20
>   CC      arch/um/kernel/sysrq.o
> arch/um/kernel/sysrq.c: In function =91show_stack=92:
> arch/um/kernel/sysrq.c:32:29: warning: unused variable =91bp=92 [-Wun=
used-variable]

Looks like my gcc need's an upgrade. :D

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

