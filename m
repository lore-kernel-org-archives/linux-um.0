Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUBOr-00087J-4z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 14:02:09 -0800
Received: from alchar.org ([66.92.236.138] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CUBOq-00049K-6N for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 14:02:09 -0800
From: Kris Van Hees <aedil@alchar.org>
Subject: Re: [uml-devel] Problem booting UML 2.4.26 compiled with gcc 3.3.4
Message-ID: <20041116220207.GB340@alchar.org>
References: <20041116211102.GA340@alchar.org>
	<200411162244.29724.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <200411162244.29724.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 16 Nov 2004 17:02:07 -0500
Content-Transfer-Encoding: quoted-printable
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Nov 16, 2004 at 10:44:29PM +0100, Blaisorblade wrote:
> On Tuesday 16 November 2004 22:11, Kris Van Hees wrote:
> > Has anyone else experienced trouble with running a UML kernel 2.4.26 th=
at
> > was compiled with GCC 3.3.4?  My instances ran perfectly fine (compiled)
> > with GCC 2.94
> 2.95.4 I guess (I think GCC 2.94 does not exist, but you may be correct, =
so I=20
> just ask).
> > but when I upgraded my GCC and recompiled everything,=20
> > suddenly they started giving me trouble, ranging from tracing thread
> > crashes to kernel mode panics.
> Which GCC 3.3.4 and which UML?

Everything is running on a debian (stable) system, 3.0r3, so the older GCC =
is
actually 2.95.4 (sorry for the typo in my original message), and the new one
(installed from testing because I need it for Xen) is GCC 3.3.4.  I am using
the stock 2.4.26 kernel, and UML patch uml-patch-2.4.26-3.bz2, along with
UML tools uml_utilities_20040406.tar.bz2.

Here is the end of the console:

Initializing stdio console driver
Netdevice 0 : TUN/TAP backend -=20
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
INIT: version 2.84 booting

And here is the backtrace from gdb:

(gdb) bt
#0  panic (
    fmt=3D0xa009af99 "=F3=A5t\f\017=B7\006\203=C6\002f\211\a\203=C7\002=F6=
=C2\001t\005\017=B6\006\210\a\213E\f\213@L\205=C0t\006\215CX\211CL\213\034$=
\213t$\004\213|$\b\211=EC]=C3\215=B4&") at panic.c:58
#1  0xa0090ab2 in segv () at trap_kern.c:149
#2  0xa0090f05 in segv_handler (sig=3D11, regs=3D0x0) at trap_user.c:74
#3  0xa0095251 in sig_handler_common_tt (sig=3D11, sc_ptr=3D0xa08ff498)
    at trap_user.c:43
#4  0xa0091001 in sig_handler (sig=3D0, sc=3D
      {gs =3D 0, __gsh =3D 0, fs =3D 0, __fsh =3D 0, es =3D 43, __esh =3D 0=
, ds =3D 43, __dsh =3D 0, edi =3D 2694020392, esi =3D 2, ebp =3D 2693789564=
, esp =3D 2693789552, ebx =3D 2694020392, edx =3D 716, ecx =3D 179, eax =3D=
 2694020392, trapno =3D 14, err =3D 4, eip =3D 2684989337, cs =3D 35, __csh=
 =3D 0, eflags =3D 66118, esp_at_signal =3D 2693789552, ss =3D 43, __ssh =
=3D 0, fpstate =3D 0x0, oldmask =3D 134285824, cr2 =3D 2}) at trap_user.c:1=
08
#5  <signal handler called>
#6  0xa009af99 in sc_to_sc (to_ptr=3D0xa0937d28, from_ptr=3D0x11)
    at sigcontext.c:26
#7  0xa0093153 in copy_thread_tt (nr=3D0, clone_flags=3D2694020392, sp=3D0,=
=20
    stack_top=3D0, p=3D0xa0934000, regs=3D0x0) at process_kern.c:305

Given that from_ptr is being reported as 0x11 in the arguments to sc_to_sc()
I am assuming that the argument actually got overwritten by something else
(most likely the signal number).  The point of failure is where the kernel =
is
trying to start 'init', as can be seen from this:

(gdb) frame 7
#7  0xa0093153 in copy_thread_tt (nr=3D0, clone_flags=3D2694020392, sp=3D0,=
=20
    stack_top=3D0, p=3D0xa0934000, regs=3D0x0) at process_kern.c:305
305                              UPT_SC(&current->thread.regs.regs));
(gdb) print p.comm
$4 =3D "init\0er\0\0\0\0\0\0\0\0"

> UML 2.4.26-3 should be safe from this, older ones may not.
> Also, for instance, Gcc 3.3.2 from Mandrake 10.0 Official is not able to =

> compile any UML 2.4 (no problem for UML/2.6), but like for Linux, even fo=
r=20
> GCC some vendor ship patched versions, and the problem will probably lie =
in=20
> the patch (since I've been using GCC 3.3.4 from Slackware to compile with=
=20
> success UML 2.4).
>=20
> Please let me know your results.
> --=20
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729

--=20
Never underestimate a Mage with:
 - the Intelligence to cast Magic Missile,
 - the Constitution to survive the first hit, and
 - the Dexterity to run fast enough to avoid being hit a second time.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
