Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Sat, 21 May 2011 00:53:50 +0200
References: <201105191526.31904.toralf.foerster@gmx.de> <1305907458.1465.23.camel@gandalf.stny.rr.com> <1305907896.1465.27.camel@gandalf.stny.rr.com>
In-Reply-To: <1305907896.1465.27.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <201105210053.51314.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Darren Hart <dvhart@linux.intel.com>, richard -rw- weinberger <richard.weinberger@gmail.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


Steven Rostedt wrote at 18:11:36
> Could you apply these patches:
>=20
> 2092e6be WARN_ON_SMP(): Allow use in if() statements on UP
> 29096202 futex: Fix WARN_ON() test for UP
>=20
> On top of this commit, and see if the problem goes away. What could h=
ave
> happened, is that you have two bugs, with one of them fixed. If the g=
it
> bisect stumbled on this bug, it will show this one, even though later
> on, this code was fixed. If you apply the above two patches and it wo=
rks
> again, then this isn't the bug you are looking for.

I bisected it again and applied at every step those 2 commits, if commi=
t=20
2e12978 was in the source too.

=46urthermore it was necessary to use a fresh instance of firefox every=
 time to=20
reproduce a now shomehow changed issue: the UML system wasn't longer=20
reachable, neither ping nor ssh into it was possible as soon as I tried=
 to=20
point firefox to https://n22_uml/phpmyadmin/ and no crash occured any l=
onger.=20
=46urthermore a previously opened ssh session to that UML hangs complet=
ely.


Bisecting gave :


git bisect badd123375425d7df4b6081a631fc1203fceafa59b2 is the first bad=
 commit
commit d123375425d7df4b6081a631fc1203fceafa59b2
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Jan 26 21:32:01 2011 +0100

    rwsem: Remove redundant asmregparm annotation
   =20
    Peter Zijlstra pointed out, that the only user of asmregparm (x86) =
is
    compiling the kernel already with -mregparm=3D3. So the annotation =
of
    the rwsem functions is redundant. Remove it.
   =20
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: David Howells <dhowells@redhat.com>
    Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Cc: Matt Turner <mattst88@gmail.com>
    Cc: Tony Luck <tony.luck@intel.com>
    Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
    Cc: Paul Mundt <lethal@linux-sh.org>
    Cc: David Miller <davem@davemloft.net>
    Cc: Chris Zankel <chris@zankel.net>
    LKML-Reference:=20
<alpine.LFD.2.00.1101262130450.31804@localhost6.localdomain6>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

:040000 040000 f373822625e4f5d03d89997cc9f06ef0e21c6d08=20
272479d3450a4924f3ad2d06a058d77c577ec0d4 M      include
:040000 040000 9294321acb9db51e4db72b8e7c95fbd1531a7f26=20
393fc63299ae482792439384485618a492619787 M      lib

/enjoy
:-)

--=20
MfG/Sincerely
Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

