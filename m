Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51F4F19D.3000300@gmail.com>
Date: Sun, 28 Jul 2013 12:25:33 +0200
From: Gabriel de Perthuis <g2p.code@gmail.com>
MIME-Version: 1.0
References: <1374938607-25747-1-git-send-email-g2p.code@gmail.com> <51F4D275.70009@nod.at>
In-Reply-To: <51F4D275.70009@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Accept /dev/fd/* uml block devices
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Le dim. 28 juil. 2013 10:12:37 CEST, Richard Weinberger a =C3=A9crit :
> Am 27.07.2013 17:23, schrieb Gabriel de Perthuis:
>> Useful for
>> * limiting privileges
>> * opening block devices O_EXCL
>
> So, the goal of this patch is to allow passing a file descriptor
> number as block device instead of a file?

Yes.  It turns out it already works, but not after dropping privileges.

> I assume you have already a wrapper around UML which exec()'s it such=
 that
> it can reuse a fd?

Yes, vido: https://github.com/g2p/vido

Here's the relevant commit:
https://github.com/g2p/vido/commit/42d4b86eab13d90ee63138b73146485dc4e4=
7ec6

>> Use dup to work around the fact /proc/self/fd
>> can't be opened after dropping privileges.
>> This proc behaviour doesn't match TLPI and might be a bug.
>>
>> Qemu has a slightly more complex fdset approach
>> that provides fds with different access permissions.
>
> I really don't like that you patch os_open_file(), this is a
> generic function.

The justification was that it unbreaks open("/dev/fd") to be more like
standards suggest, but I can see how that makes it a special case.

> What about this one?
> Allow ubda=3D (and all other UML block device kernel parameters) to
> accept arguments like file:/foo/bar and fd:N.
> Where N is a number and file: is default such that we do not break
> old kernels.

Okay, I'll add a prefix.  Maybe file:// + /abs/path | rel/path
since that's already standard.
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

