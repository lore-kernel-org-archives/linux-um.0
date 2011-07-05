Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vitalivanov@gmail.com>) id 1Qe441-0008Vj-R7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jul 2011 11:45:13 +0000
Received: from mail-ew0-f47.google.com ([209.85.215.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Qe441-0006h4-2Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jul 2011 11:45:13 +0000
Received: by ewy5 with SMTP id 5so2725395ewy.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 05 Jul 2011 04:45:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201107051142.39733.richard@nod.at>
References: <1309821347.4527.6.camel@vitaliy-Vostro-1400>
	<201107051142.39733.richard@nod.at>
Date: Tue, 5 Jul 2011 14:45:06 +0300
Message-ID: <CAGTPOqebcT_Dd5nPSNEkrDvnCgYhqcU=ayjEA8L7Zh0Wr_pj5w@mail.gmail.com>
From: Vitaliy Ivanov <vitalivanov@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 2/4] uml: helper.c warning corrections
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>

Richard,

On Tue, Jul 5, 2011 at 12:42 PM, Richard Weinberger <richard@nod.at> wrote:
> Am Dienstag 05 Juli 2011, 01:15:47 schrieb Vitaliy Ivanov:
>> From 7296c5b9770e95cd6ad4e9e71d2d14c972abdfe1 Mon Sep 17 00:00:00 2001
>> From: Vitaliy Ivanov <vitalivanov@gmail.com>
>> Date: Tue, 5 Jul 2011 02:03:06 +0300
>> Subject: [PATCH 2/4] uml: helper.c warning corrections
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=3DUTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> arch/um/os-Linux/helper.c: In function =91helper_child=92:
>> arch/um/os-Linux/helper.c:38:7: warning: ignoring return value of =91wri=
te=92,
>> declared with attribute warn_unused_result
>
> Same question as before...

Same answer is here:)

>> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
>> ---
>> =A0arch/um/os-Linux/helper.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
>> index b6b1096..feff22d 100644
>> --- a/arch/um/os-Linux/helper.c
>> +++ b/arch/um/os-Linux/helper.c
>> @@ -28,14 +28,14 @@ static int helper_child(void *arg)
>> =A0{
>> =A0 =A0 =A0 struct helper_data *data =3D arg;
>> =A0 =A0 =A0 char **argv =3D data->argv;
>> - =A0 =A0 int err;
>> + =A0 =A0 int err, ret;
>>
>> =A0 =A0 =A0 if (data->pre_exec !=3D NULL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*data->pre_exec)(data->pre_data);
>> =A0 =A0 =A0 err =3D execvp_noalloc(data->buf, argv[0], argv);
>>
>> =A0 =A0 =A0 /* If the exec succeeds, we don't get here */
>> - =A0 =A0 write(data->fd, &err, sizeof(err));
>> + =A0 =A0 CATCH_EINTR(ret =3D write(data->fd, &err, sizeof(err)));
>
> Is there really a realistic chance that this write() can be interrupted?
> helper_child() gets called via clone() in run_helper().

It's always better not to think whether it's possible but simply kill
all the chances for this to happen.
In this case that's pretty trivial thing and also it solves issue with warn=
ing.

Vitaliy

---------------------------------------------------------------------------=
---
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security =

threats, fraudulent activity, and more. Splunk takes this data and makes =

sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

