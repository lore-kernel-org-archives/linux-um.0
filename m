Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 22 Dec 2015 22:30:16 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20151222223016.GC20997@ZenIV.linux.org.uk>
References: <1450817041-21236-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1450817041-21236-1-git-send-email-mic@digikod.net>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Fix pointer cast
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Linus Torvalds <torvalds@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Dec 22, 2015 at 09:44:01PM +0100, Micka=EBl Sala=FCn wrote:
> Fix a pointer cast typo introduced in v4.4-rc5 especially visible for
> the i386 subarchitecture where it results in a kernel crash.

Why the hell bother casting it at all?  _Any_ pointer will quietly conv=
ert
to void *, no typecasts needed.  The second argument of copy_from_user
is const void __user *; sc is struct sigcontext __user *sc, so
&sb->oldmask is either __u32 __user * or __u64 __user *, for 32bit and
64bit builds resp.  Either is assignment-compatible with
const void __user *.

Basically, cast is telling the typechecking logics "sod off, I know bet=
ter".
And here it's not needed at all.  Moreover, the bug you are fixing here=
 is
precisely that this code did *not* know better - if not for that cast,
compiler would've immediately pointed to the problem.

> -	if (copy_from_user(&set.sig[0], (void *)sc->oldmask, sizeof(set.sig=
[0])) ||
> +	if (copy_from_user(&set.sig[0], (void *)&sc->oldmask, sizeof(set.si=
g[0])) ||

Please, remove the cast completely.  Simply pass it &sc->oldmask and be
done with that.
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

