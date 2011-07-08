Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201107071848.50411.richard@nod.at>
References: <1310056668.3528.51.camel@vivanov>
	<201107071848.50411.richard@nod.at>
Date: Fri, 8 Jul 2011 13:16:20 +0300
Message-ID: <CAGTPOqfT=L4s8-db58mCRXQFvuYOVwNsNDfc4YuRaO7azpZa4A@mail.gmail.com>
From: Vitaliy Ivanov <vitalivanov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 3/3] uml: os-Linux/main.c memory leak fix
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Jul 7, 2011 at 7:48 PM, Richard Weinberger <richard@nod.at> wro=
te:
> Am Donnerstag 07 Juli 2011, 18:37:48 schrieb Vitaliy Ivanov:
>> >From 6db3c87f57e3e61d968da79f01fb21ba17fd5bc0 Mon Sep 17 00:00:00 2=
001
>>
>> From: Vitaliy Ivanov <vitalivanov@gmail.com>
>> Date: Thu, 7 Jul 2011 19:29:06 +0300
>> Subject: [PATCH 3/3] uml: os-Linux/main.c memory leak fix
>>
>> We should cleanup memory even though 'putenv' fails.
>>
>> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
>> ---
>> =A0arch/um/os-Linux/main.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
>> index fb2a97a..67fe012 100644
>> --- a/arch/um/os-Linux/main.c
>> +++ b/arch/um/os-Linux/main.c
>> @@ -107,8 +107,8 @@ static void setup_env_path(void)
>> =A0 =A0 =A0 snprintf(new_path, path_len, "PATH=3D%s" UML_LIB_PATH, o=
ld_path);
>> =A0 =A0 =A0 if (putenv(new_path)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 perror("couldn't putenv to set a new PAT=
H");
>> - =A0 =A0 =A0 =A0 =A0 =A0 free(new_path);
>> =A0 =A0 =A0 }
>> + =A0 =A0 free(new_path);
>
> Uhhh, this will kill the PATH variable.
> putenv() does not copy the string...

That's actually depends on the version of glibc that you use. But yes,
agree, my fault. Please drop this one.
I hope I'm not in your shit-list already.:)

BTW, you said that you will share your git tree on kernel.org, is
there any news? I'm tracking what patches are accepted not to resend
them again.

Thanks,
Vitaliy
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

