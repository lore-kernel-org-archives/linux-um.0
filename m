Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard.weinberger@gmail.com>) id 1PxM2Z-0000JV-Rf
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2011 16:15:11 +0000
Received: from mail-qy0-f175.google.com ([209.85.216.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PxM2Y-0007bz-94
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2011 16:15:11 +0000
Received: by qyk35 with SMTP id 35so3742921qyk.13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 09 Mar 2011 08:15:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTimxoB9n5L-Kz-V4XgDDwJ8jG68ereF6DhtH7YC3@mail.gmail.com>
References: <AANLkTi=tCx=04dwqxyZ9DJioibMURzXbTMgoKpSg03jf@mail.gmail.com>
	<AANLkTimDptv_OJOSs8+ENO8SWZFySDahE1zvGGwEMGXt@mail.gmail.com>
	<AANLkTimxoB9n5L-Kz-V4XgDDwJ8jG68ereF6DhtH7YC3@mail.gmail.com>
Date: Wed, 9 Mar 2011 17:15:04 +0100
Message-ID: <AANLkTikKVi_t-U3kX1cCXbPBs8dr4-GEipQqSo3bCnhJ@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] make_tempfile: Fix potential memory leak.
To: Thomas Roth <code@stacksmashing.net>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

On Wed, Mar 9, 2011 at 5:01 PM, Thomas Roth <code@stacksmashing.net> wrote:
> On Wed, Mar 9, 2011 at 4:53 PM, richard -rw- weinberger
> <richard.weinberger@gmail.com> wrote:
>> On Wed, Mar 9, 2011 at 3:21 PM, Thomas Roth <code@stacksmashing.net> wro=
te:
>>> This patch removes a potential memory leak in make_tempfile (in
>>> arch/um/os-Linux/mem.c).
>>
>> This is not really a problem because UML terminates anyway
>> when tempdir =3D=3D NULL.
>> Why should we waste CPU cycles with free()ing memory in the exit path?
>
> This patch doesn't add any overhead to the function, as no additional cod=
e was
> introduced. The 'old' way now wastes more CPU cycles if tempdir is NULL. I
> just stumbled upon it while looking for something entirely different
> and it didn't
> look right to me.

Sorry, my fault. Your path does not add code.
But it also does not fix any real problem.

>>> If tempdir is NULL or as long as MAXPATHLEN, the function will return
>>> without freeing the previously
>>> malloced tempname, resulting in a memory leak. Another way to fix this
>>> issue is to replace :
>>> =A0 =A0 =A0 =A0if ((tempdir =3D=3D NULL) || (strlen(tempdir) >=3D MAXPA=
THLEN))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>>> with:
>>> =A0 =A0 =A0 =A0if ((tempdir =3D=3D NULL) || (strlen(tempdir) >=3D MAXPA=
THLEN))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>>>
>>> But I think the way in the attached patch is cleaner, as it doesn't
>>> malloc tempname at all if it's not necessary.
>>>
>>> Cheers,
>>>
>>> Thomas
>>>
>>> ---
>>> =A0arch/um/os-Linux/mem.c | =A0 =A08 ++++----
>>> =A01 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
>>> index e696144..e135422 100644
>>> --- a/arch/um/os-Linux/mem.c
>>> +++ b/arch/um/os-Linux/mem.c
>>> @@ -170,14 +170,14 @@ static int __init make_tempfile(const char
>>> *template, char **out_tempname,
>>> =A0 =A0 =A0 =A0int fd;
>>>
>>> =A0 =A0 =A0 =A0which_tmpdir();
>>> - =A0 =A0 =A0 tempname =3D malloc(MAXPATHLEN);
>>> - =A0 =A0 =A0 if (tempname =3D=3D NULL)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>> -
>>> =A0 =A0 =A0 =A0find_tempdir();
>>> =A0 =A0 =A0 =A0if ((tempdir =3D=3D NULL) || (strlen(tempdir) >=3D MAXPA=
THLEN))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>>>
>>> + =A0 =A0 =A0 tempname =3D malloc(MAXPATHLEN);
>>> + =A0 =A0 =A0 if (tempname =3D=3D NULL)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>> +
>>> =A0 =A0 =A0 =A0if (template[0] !=3D '/')
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(tempname, tempdir);
>>> =A0 =A0 =A0 =A0else
>>> --
>>> 1.7.2.3
>>>
>>> -----------------------------------------------------------------------=
-------
>>> Colocation vs. Managed Hosting
>>> A question and answer guide to determining the best fit
>>> for your organization - today and in the future.
>>> http://p.sf.net/sfu/internap-sfd2d
>>> _______________________________________________
>>> User-mode-linux-devel mailing list
>>> User-mode-linux-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>>>
>>
>> --
>> Thanks,
>> //richard
>>
>

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

