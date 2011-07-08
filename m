Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201107071927.16237.richard@nod.at>
References: <1310056562.3528.49.camel@vivanov>
	<201107071927.16237.richard@nod.at>
Date: Fri, 8 Jul 2011 13:30:56 +0300
Message-ID: <CAGTPOqfe8JxMsOru=pydy6ofEi0Ax-N=W_2UZwq5y=grrTemhQ@mail.gmail.com>
From: Vitaliy Ivanov <vitalivanov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/3] uml: drivers/net_user.c memory leak fix
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Jul 7, 2011 at 8:27 PM, Richard Weinberger <richard@nod.at> wro=
te:
> Am Donnerstag 07 Juli 2011, 18:36:02 schrieb Vitaliy Ivanov:
>> >From 9b9f36f46aa708c3245f5ded83f96421966b2edf Mon Sep 17 00:00:00 2=
001
>>
>> From: Vitaliy Ivanov <vitalivanov@gmail.com>
>> Date: Thu, 7 Jul 2011 19:23:13 +0300
>> Subject: [PATCH 1/3] uml: drivers/net_user.c memory leak fix
>>
>> Perform memory cleanup on exit.
>> On receiving invalid 'pid' we still should clean 'output' variable.
>>
>> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
>> ---
>> =A0arch/um/drivers/net_user.c | =A0 =A05 +++--
>> =A01 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
>> index 9415dd9..989b653 100644
>> --- a/arch/um/drivers/net_user.c
>> +++ b/arch/um/drivers/net_user.c
>> @@ -228,10 +228,11 @@ static void change(char *dev, char *what, unsi=
gned
>> char *addr, "buffer\n");
>>
>> =A0 =A0 =A0 pid =3D change_tramp(argv, output, output_len);
>> - =A0 =A0 if (pid < 0) return;
>>
>> =A0 =A0 =A0 if (output !=3D NULL) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 printk("%s", output);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pid >=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s", output);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(output);
>> =A0 =A0 =A0 }
>> =A0}
>
> This control logic is a bit strange.
> When change_tramp() fails we should not printk() the output variable.
>
> if (pid < 0){
> =A0free(output);
> =A0return;
> }
>
> Would be much cleaner.

I just didn't want to clone this free-return stuff. So, what you
proposing is like this:
------------
=2E..
        output =3D uml_kmalloc(output_len, UM_GFP_KERNEL);
        if (output =3D=3D NULL)
                printk(UM_KERN_ERR "change : failed to allocate output =
"
                       "buffer\n");

        pid =3D change_tramp(argv, output, output_len);
        if (pid < 0) {
                free(output);               <---------- I'm not sure
but 'output' can be NULL here.
                return;
        }

        if (output !=3D NULL) {
                printk("%s", output);
                kfree(output);
        }
}
------------

I was trying to print 'output' only in case change_tramp is
successful. That's the old logic. And at the same time perform free
only in case output is not NULL.


Vitaliy
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

