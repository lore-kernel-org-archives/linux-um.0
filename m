Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1448746350-19998-1-git-send-email-mic@digikod.net>
 <1448746350-19998-3-git-send-email-mic@digikod.net> <565A258D.4040206@nod.at>
 <565A3128.8010605@digikod.net>
From: Richard Weinberger <richard@nod.at>
Message-ID: <565A31B6.5050802@nod.at>
Date: Sat, 28 Nov 2015 23:59:02 +0100
MIME-Version: 1.0
In-Reply-To: <565A3128.8010605@digikod.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] um: Use race-free temporary file creation
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Tristan Schmelcher <tschmelcher@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 28.11.2015 um 23:56 schrieb Micka=EBl Sala=FCn:
>=20
> On 28/11/2015 23:07, Richard Weinberger wrote:
>> Am 28.11.2015 um 22:32 schrieb Micka=EBl Sala=FCn:
>>> Open the memory mapped file with the O_TMPFILE flag when available.
>>>
>>> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
>>> ---
>>>  arch/um/os-Linux/mem.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
>>> index 798aeb4..fe52e2d 100644
>>> --- a/arch/um/os-Linux/mem.c
>>> +++ b/arch/um/os-Linux/mem.c
>>> @@ -106,6 +106,18 @@ static int __init make_tempfile(const char *te=
mplate)
>>>  		}
>>>  	}
>>> =20
>>> +#ifdef O_TMPFILE
>>> +	fd =3D open(tempdir, O_CLOEXEC | O_RDWR | O_EXCL | O_TMPFILE, 070=
0);
>>> +	/*
>>> +	 * If the running system does not support O_TMPFILE flag then ret=
ry
>>> +	 * without it.
>>> +	 */
>>> +	if (fd !=3D -1 || (errno !=3D EINVAL && errno !=3D EISDIR &&
>>
>> Why are you handling EISDIR?
>=20
> I follow the man page for open [1], I think it was a workaround neede=
d for some kernel versions just after the O_TMPFILE was added but befor=
e the support for EOPNOTSUPP.
> We may need to add the EACCES too for some version of glibc [2, 3]?

Makes sense! :)

> 1. http://man7.org/linux/man-pages/man2/openat.2.html#BUGS
> 2. Commit 69a91c237ab0ebe4e9fdeaf6d0090c85275594ec and https://source=
ware.org/bugzilla/show_bug.cgi?id=3D17523
> 3. https://bugs.gentoo.org/529044
>=20
>>
>>> +			errno !=3D EOPNOTSUPP))
>>> +		return fd;
>>> +	errno =3D 0;
>>
>> Why are you resetting errno?
>=20
> It's to ignore/reset the error code from open, but it may not be need=
ed because of the next call to malloc?

But then you'd have to reset errno after every syscall. :-)

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

