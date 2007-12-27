Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Message-ID: <64587.80.144.206.235.1198785312.squirrel@fsmath.mathematik.uni-dortmund.de>
In-Reply-To: <4773F11D.7060803@BitWagon.com>
References: <4773F11D.7060803@BitWagon.com>
Date: Thu, 27 Dec 2007 20:55:12 +0100 (CET)
From: "Michael Abshoff" <Michael.Abshoff@fsmath.mathematik.uni-dortmund.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] [Valgrind-developers] running UserModeLinux under
	Valgrind(memcheck)
Reply-To: Michael.Abshoff@fsmath.mathematik.uni-dortmund.de
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: valgrind-developers@lists.sourceforge.net
Cc: John Reiser <jreiser@BitWagon.com>, user-mode-linux-devel@lists.sourceforge.net

John Reiser wrote

Hi John,

> Patches have been developed which enable UserModeLinux for i686 to
> run under the memcheck tool of Valgrind on i686.  Thus it is possible
> to check dynamically the memory accesses made by a running Linux kernel
> against memcheck's model of allowed behavior.  This work was supported
> by Google Inc.
>
> The combined patches are at "alpha" quality.

I applied your patch against a vanilla 3.3.0 and with both gcc 4.2 and a
recent gcc 4.3 snapshot I get the following compilation failure on Linux
x86-64 (Centos 5)

if gcc -DHAVE_CONFIG_H -I. -I. -I..  -I../coregrind -I..
-I../coregrind/amd64 -I../coregrind/linux -I../coregrind/amd64-linux
-I../include -I../VEX/pub -DVG_PLATFORM=3D"\"amd64-linux\"" -DVGA_amd64=3D1
-DVGO_linux=3D1 -DVGP_amd64_linux=3D1
-DVG_LIBDIR=3D"\"/usr/local/valgrind-3.3.0-asap/lib/valgrind"\"   -m64
-fomit-frame-pointer -O2 -g -Wmissing-prototypes -Wall -Wshadow
-Wpointer-arith -Wstrict-prototypes -Wmissing-declarations
-fno-strict-aliasing -Wno-long-long -Wno-pointer-sign
-Wdeclaration-after-statement -fno-stack-protector -MT
libcoregrind_amd64_linux_a-syswrap-linux.o -MD -MP -MF
".deps/libcoregrind_amd64_linux_a-syswrap-linux.Tpo" -c -o
libcoregrind_amd64_linux_a-syswrap-linux.o `test -f
'm_syswrap/syswrap-linux.c' || echo './'`m_syswrap/syswrap-linux.c; \
        then mv -f ".deps/libcoregrind_amd64_linux_a-syswrap-linux.Tpo"
".deps/libcoregrind_amd64_linux_a-syswrap-linux.Po"; else rm -f
".deps/libcoregrind_amd64_linux_a-syswrap-linux.Tpo"; exit 1; fi
m_syswrap/syswrap-linux.c: In function =91vgModuleLocal_do_fork_clone=92:
m_syswrap/syswrap-linux.c:338: error: =91VexGuestArchState=92 has no member
named =91guest_EAX=92
m_syswrap/syswrap-linux.c:340: error: =91VexGuestArchState=92 has no member
named =91guest_ESP=92
m_syswrap/syswrap-linux.c:349: warning: implicit declaration of function
=91letgo_vex_x86_linux=92
make[3]: *** [libcoregrind_amd64_linux_a-syswrap-linux.o] Error 1
make[3]: Leaving directory `/tmp/Work/valgrind-3.3.0/coregrind'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/tmp/Work/valgrind-3.3.0/coregrind'


>  They have memchecked
> an entire trivial session (boot UML, login, halt), and have identified
> a couple specific problems in kernel code.  The steps necessary to reach
> "beta" quality (a motivated kernel developer can get useful results)
> have been outlined and are being pursued.
>
> The goods:
>  15KB  http://bitwagon.com/valgrind+uml/valgrind-3.3.0-2007-12-27.patch.gz
>  60KB  http://bitwagon.com/valgrind+uml/uml-2.6.22.5-2007-12-27.patch.gz
>
> Current status and updates will be maintained on the [coming] web page
>        http://bitwagon.com/valgrind+uml/index.html
>
> As a convenience for when the official sites are not responding,
> here are copies of the original unpatched software that is required:
>   4MB  http://bitwagon.com/valgrind+uml/valgrind-3.3.0.tar.bz2
>  45MB  http://bitwagon.com/valgrind+uml/linux-2.6.22.5.tar.bz2
> 103MB  http://bitwagon.com/valgrind+uml/FedoraCore5-x86-root_fs.bz2
> Approximately 2.5GB of disk space is required to play.
>
> Motivated in part by the difficulty of tracking down the causes of
> "Conditional jump or move depends on uninitialised data", the patches
> include a new *optional* mode for memcheck: --complain-asap=3Dyes.

This is a very, very cool feature. Any way you can split that patch out
from the patchset?

> In this mode, memcheck issues a complaint immediately for any load
> from memory that contains uninitialized bits.  This gives a very early
> notice of potential trouble.  It also squawks for uninitialized
> holes in structures or bitfields, conditions which later become ignored
> or "don't care", certain compiler optimizations for speed, etc.
> The intent is to reduce the blizzard of "false positive" complaints
> by using the glibc-audit patches to provide a "quiet" glibc,
> by making the holes in kernel structures explicit (and filling them),
> by writing suppressions for known cases, by and further enhancing
> this new mode of memcheck.
>
> On the UML side, there is a significant technical issue: the semantics
> of kmalloc+kfree do not match the semantics of malloc+free.  The kernel
> slab allocator caches and re-issues identified objects, which accumulate
> state and retain it throughout execution, including from kfree to kmalloc.
> In contrast, a region that is passed to free() loses both its contents
> and its identity.  Also, size is an important parameter to malloc,
> but is implicit to kmalloc.  The initial patches finesse these issues
> (for instance: by supplying the size as trailing parameter to kmalloc,
> and by noticing that SLAB_POISON =3D=3D> free()), but there will be
> significant discussion and work in resolving the differences.
>
> --
> John Reiser, jreiser@BitWagon.com


Cheers,

Michael

>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Valgrind-developers mailing list
> Valgrind-developers@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/valgrind-developers
>



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
