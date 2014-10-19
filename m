Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5443F4A7.6010900@gmx.at>
Date: Sun, 19 Oct 2014 19:28:07 +0200
From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
MIME-Version: 1.0
References: <544277C5.9030302@gmx.at> <54427C48.9050608@nod.at> <54428348.2050209@gmx.at> <54428500.6020304@nod.at> <5442862A.4090408@gmx.at> <544289F8.3020704@nod.at>
In-Reply-To: <544289F8.3020704@nod.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Remove unused bp stack-frame pointer
To: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>
Cc: Daniel Walter <dwalter@google.com>, Randy Dunlap <rdunlap@infradead.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 2014-10-18 17:40, Richard Weinberger wrote:
> Am 18.10.2014 um 17:24 schrieb Manfred Schlaegl:
>> On 2014-10-18 17:19, Richard Weinberger wrote:
>>> Am 18.10.2014 um 17:12 schrieb Manfred Schlaegl:
>>>> On 2014-10-18 16:42, Richard Weinberger wrote:
>>>>> Am 18.10.2014 um 16:23 schrieb Manfred Schlaegl:
>>>>>> The pointer to bp stack-frame is no longer used. Removed it.
>>>>>
>>>>> Good catch!
>>>> Thank you.
>>>>
>>>>>
>>>>>> This also removes a corresponding compiler-warning.
>>>>>
>>>>> Which warning exactly?
>>>>
>>>> On "normal" (defconfig) builds the warning does not show up becaus=
e CONFIG_FRAME_POINTER is set.
>>>> I've found the unused bp because CONFIG_FRAME_POINTER was not set =
in my configuration.
>>>>
>>>>   CC      arch/um/kernel/sysrq.o
>>>> arch/um/kernel/sysrq.c: In function =91show_stack=92:
>>>> arch/um/kernel/sysrq.c:32:29: warning: unused variable =91bp=92 [-=
Wunused-variable]
>>>
>>> Looks like my gcc need's an upgrade. :D
>>>
>>> Thanks,
>>> //richard
>>>
>>
>> I'm using gcc version 4.7.2 (Debian 4.7.2-5). -> not THAT new ;-)
>=20
> With a cup of coffee applied I managed it to read your mail correctly=
=2E
> The warning triggers only with CONFIG_FRAME_POINTER=3Dn. Now it makes=
 sense.

Misunderstanding solved! Miracle cure caffeine ;-)

greetings
manfred

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

