Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51F998EE.80208@gmail.com>
Date: Thu, 01 Aug 2013 01:08:30 +0200
From: Gabriel de Perthuis <g2p.code@gmail.com>
MIME-Version: 1.0
References: <1374938607-25747-1-git-send-email-g2p.code@gmail.com> <51F4D275.70009@nod.at> <51F4F19D.3000300@gmail.com>
In-Reply-To: <51F4F19D.3000300@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Accept /dev/fd/* uml block devices
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Le 28/07/2013 12:25, Gabriel de Perthuis a =C3=A9crit :
> Le dim. 28 juil. 2013 10:12:37 CEST, Richard Weinberger a =C3=A9crit =
:
>> Am 27.07.2013 17:23, schrieb Gabriel de Perthuis:
>>> Useful for
>>> * limiting privileges
>>> * opening block devices O_EXCL
>>
>> So, the goal of this patch is to allow passing a file descriptor
>> number as block device instead of a file?
>=20
> Yes.  It turns out it already works, but not after dropping privilege=
s.
>=20
>> I assume you have already a wrapper around UML which exec()'s it suc=
h that
>> it can reuse a fd?
>=20
> Yes, vido: https://github.com/g2p/vido
>=20
> Here's the relevant commit:
> https://github.com/g2p/vido/commit/42d4b86eab13d90ee63138b73146485dc4=
e47ec6
>=20
>>> Use dup to work around the fact /proc/self/fd
>>> can't be opened after dropping privileges.
>>> This proc behaviour doesn't match TLPI and might be a bug.
>>>
>>> Qemu has a slightly more complex fdset approach
>>> that provides fds with different access permissions.
>>
>> I really don't like that you patch os_open_file(), this is a
>> generic function.
>=20
> The justification was that it unbreaks open("/dev/fd") to be more lik=
e
> standards suggest, but I can see how that makes it a special case.
>=20
>> What about this one?
>> Allow ubda=3D (and all other UML block device kernel parameters) to
>> accept arguments like file:/foo/bar and fd:N.
>> Where N is a number and file: is default such that we do not break
>> old kernels.
>=20
> Okay, I'll add a prefix.  Maybe file:// + /abs/path | rel/path
> since that's already standard.

I've done some work on this approach, but it turns out to clash
with the cow syntax; in ubd0=3Dfile:cowfile, ":" is a path separator.
Changing things in ubd_kern.c is also more intrusive, even with
the limited goal of making it work for plain, non-cow files I
need to duplicate a few code paths to work with fds instead of
names and the diffstat is getting large.

Because of that I'd like to come back to /dev/fd/<n>.
It does overload the generic file opener, but does so consistently,
so that you can think of /dev/fd as a virtual filesystem.
The (arguably broken) /proc/self/fd behaviour remains available
through the /proc path.

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

