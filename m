Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BK1lo-0000gs-ON for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 May 2004 14:11:36 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BK1lm-000494-UH for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 May 2004 14:11:35 -0700
Message-ID: <006f01c42fc1$d16b4bc0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.58.0404162157280.29213@boston.corp.fedex.com>
	<Pine.LNX.4.58.0404211409570.2147@boston.corp.fedex.com>
	<08bf01c427fb$86cb9520$2000000a@schlepptopp>
	<200404301545.10555.blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] patch for 2.6.6-rc1
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0067_01C42FD2.9194C420"
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
Date: Sat, 1 May 2004 23:18:10 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, Jeff Chua <jeff98@silk.corp.fedex.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


This is a multi-part message in MIME format.

------=_NextPart_000_0067_01C42FD2.9194C420
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nerdnet.nl id
	i41LEdAV013648

Hi Paolo/Jeff,

>Please post the arch/um/kernel/config.c file the build produced, which g=
ave
>the error. The change to the "QUOTE" line is to be analyzed.

i think the change to  $$config =3D~ s/\\n/\\\n"\\n"/g probably was a mis=
take
(i`m not good in regexes, though). it seems, that all the quotes and \n`s=
 are
being stripped from that file and so it`s no correct "c-source" anymore, =
imho.

before:
---snipp---
static __initdata char *config =3D "#\n"
"# Automatically generated make config: don`t edit\n"
"#\n"
"CONFIG_USERMODE=3Dy\n"
---snipp---

after applying patch.266rc1-1 and running make again, it is:
---snipp---
static __initdata char *config =3D "#
# Automatically generated make config: don`t edit
#
CONFIG_USERMODE=3Dy
---snipp---

i changed the line in the Makefile back to:
$$config =3D~ s/\n/\\n"\n"/g
which made things better again.

the error i reported is gone, but now "make linux ARCH=3Dum" fails with:

-> see make.log

which doesn`t seem to be related to that change of the regex before.
since this error looks "skas related" for me, i gave it a further try and
disabled skas support in .config - after that, the compile for that
"TT only"-UML runs fine for a while, but unfortunately it also fails in
the end:

-> see make_tt.log

so still no 2.6.6-rc1 or 2.6.6-rc2 (tried both)

for all interested here:
i`m referring to this "build procedure":
http://marc.theaimsgroup.com/?l=3Duser-mode-linux-devel&m=3D1082553644095=
40&w=3D2

regards
roland

ps:
>probably because the PERL code needs to be quoted once more.
err - i have a problem in understanding:
why PERL code ?
the statement is in arch/um/kernel/Makefile - is that being parsed by a p=
erl interpreter
during "make" - or does make just use similar language ?
sorry if this sounds dumb - but i`m no developer and i never wrote a make=
file myself.


----- Original Message -----=20
From: "BlaisorBlade" <blaisorblade_spam@yahoo.it>
To: "roland" <for_spam@gmx.de>; "Jeff Chua" <jeff98@silk.corp.fedex.com>
Cc: "UserModeLinux" <user-mode-linux-devel@lists.sourceforge.net>
Sent: Friday, April 30, 2004 3:45 PM
Subject: Re: [uml-devel] patch for 2.6.6-rc1


Alle 01:51, gioved=EC 22 aprile 2004, roland ha scritto:
> hi jeff,
> sorry, but it still doesn`t work for me.
> i tried both kernel 2.6.6-rc1 and 2.6.6-rc2 sources to compile a guest
> kernel.
>
> i have attached a log from what i have done - errors are at the end.

Please post the arch/um/kernel/config.c file the build produced, which ga=
ve
the error. The change to the "QUOTE" line is to be analyzed. The other pe=
rson
("gboutwel" <gboutwel@praize.com>) having problems had not this one becau=
se
he did not reach this step.

I've finally seen what it does:

-QUOTE =3D 'my $$config=3D`cat $(TOPDIR)/.config`; $$config =3D~ s/"/\\"/=
g ;
$$config =3D~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =3D~ s/CONFIG/$$confi=
g/;
print $$_ }'
+QUOTE =3D 'my $$config=3D`cat $(TOPDIR)/.config`; $$config =3D~ s/"/\\"/=
g ;
$$config =3D~ s/\\n/\\\n"\\n"/g ; while(<STDIN>) { $$_ =3D~ s/CONFIG/$$co=
nfig/;
print $$_ }'

the change is from:

$$config =3D~ s/\n/\\n"\n"/g

to:

$$config =3D~ s/\\n/\\\n"\\n"/g

probably because the PERL code needs to be quoted once more.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id149&alloc_id=8166&op=3Dick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

------=_NextPart_000_0067_01C42FD2.9194C420
Content-Type: application/octet-stream;
	name="make_tt.log"
Content-Disposition: attachment;
	filename="make_tt.log"
Content-Transfer-Encoding: quoted-printable

make[1]: `arch/um/sys-i386/util/mk_sc' is up to date.=0A=
  CHK     arch/um/include/sysdep-i386/sc.h=0A=
  CHK     arch/um/include/task.h=0A=
  CHK     arch/um/include/kern_constants.h=0A=
make[1]: `arch/um/sys-i386/util/mk_thread' is up to date.=0A=
  CHK     arch/um/include/sysdep-i386/thread.h=0A=
  CHK     include/linux/compile.h=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/process.o arch/um/kernel/process.c=0A=
  CC      arch/um/kernel/process_kern.o=0A=
  CC      arch/um/kernel/ptrace.o=0A=
  CC      arch/um/kernel/reboot.o=0A=
  CC      arch/um/kernel/resource.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/sigio_user.o arch/um/kernel/sigio_user.c=0A=
  CC      arch/um/kernel/sigio_kern.o=0A=
  CC      arch/um/kernel/signal_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/signal_user.o arch/um/kernel/signal_user.c=0A=
  CC      arch/um/kernel/smp.o=0A=
  CC      arch/um/kernel/syscall_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/syscall_user.o arch/um/kernel/syscall_user.c=0A=
  CC      arch/um/kernel/sysrq.o=0A=
  CC      arch/um/kernel/sys_call_table.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tempfile.o arch/um/kernel/tempfile.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/time.o arch/um/kernel/time.c=0A=
arch/um/kernel/time.c: In function `get_host_hz':=0A=
arch/um/kernel/time.c:109: warning: implicit declaration of function =
`strlen'=0A=
  CC      arch/um/kernel/time_kern.o=0A=
  CC      arch/um/kernel/tlb.o=0A=
  CC      arch/um/kernel/trap_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/trap_user.o arch/um/kernel/trap_user.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/uaccess_user.o arch/um/kernel/uaccess_user.c=0A=
  CC      arch/um/kernel/um_arch.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/umid.o arch/um/kernel/umid.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/user_util.o arch/um/kernel/user_util.c=0A=
  CC      arch/um/kernel/initrd_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/initrd_user.o arch/um/kernel/initrd_user.c=0A=
  CC      arch/um/kernel/tt/exec_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/exec_user.o arch/um/kernel/tt/exec_user.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/gdb.o arch/um/kernel/tt/gdb.c=0A=
arch/um/kernel/tt/gdb.c: In function `config_gdb_cb':=0A=
arch/um/kernel/tt/gdb.c:129: warning: implicit declaration of function =
`TASK_EXTERN_PID'=0A=
  CC      arch/um/kernel/tt/ksyms.o=0A=
  CC      arch/um/kernel/tt/mem.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/mem_user.o arch/um/kernel/tt/mem_user.c=0A=
  CC      arch/um/kernel/tt/process_kern.o=0A=
  CC      arch/um/kernel/tt/syscall_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/syscall_user.o =
arch/um/kernel/tt/syscall_user.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/time.o arch/um/kernel/tt/time.c=0A=
  CC      arch/um/kernel/tt/tlb.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/tracer.o arch/um/kernel/tt/tracer.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/trap_user.o arch/um/kernel/tt/trap_user.c=0A=
  CC      arch/um/kernel/tt/uaccess.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/uaccess_user.o =
arch/um/kernel/tt/uaccess_user.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/ptproxy/proxy.o =
arch/um/kernel/tt/ptproxy/proxy.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/ptproxy/ptrace.o =
arch/um/kernel/tt/ptproxy/ptrace.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/ptproxy/sysdep.o =
arch/um/kernel/tt/ptproxy/sysdep.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/ptproxy/wait.o =
arch/um/kernel/tt/ptproxy/wait.c=0A=
  LD      arch/um/kernel/tt/ptproxy/built-in.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/sys-i386/sigcontext.o =
arch/um/kernel/tt/sys-i386/sigcontext.c=0A=
  LD      arch/um/kernel/tt/sys-i386/built-in.o=0A=
  CC      arch/um/kernel/tt/gdb_kern.o=0A=
  LD      arch/um/kernel/tt/built-in.o=0A=
gcc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/tt/unmap.o arch/um/kernel/tt/unmap.c=0A=
ld -r -o arch/um/kernel/tt/unmap_fin.o arch/um/kernel/tt/unmap.o -lc =
-L/usr/lib=0A=
  LD      arch/um/kernel/built-in.o=0A=
  CPP     arch/um/kernel/vmlinux.lds.s=0A=
  CC      arch/um/drivers/ssl.o=0A=
  CC      arch/um/drivers/daemon_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/daemon_user.o arch/um/drivers/daemon_user.c=0A=
  CC      arch/um/drivers/hostaudio_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/hostaudio_user.o =
arch/um/drivers/hostaudio_user.c=0A=
  CC      arch/um/drivers/mcast_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/mcast_user.o arch/um/drivers/mcast_user.c=0A=
  CC      arch/um/drivers/mconsole_kern.o=0A=
arch/um/drivers/mconsole_kern.c: In function `mconsole_proc':=0A=
arch/um/drivers/mconsole_kern.c:140: warning: implicit declaration of =
function `put_filesystem'=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/mconsole_user.o arch/um/drivers/mconsole_user.c=0A=
  CC      arch/um/drivers/net_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/net_user.o arch/um/drivers/net_user.c=0A=
  CC      arch/um/drivers/port_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/port_user.o arch/um/drivers/port_user.c=0A=
  CC      arch/um/drivers/slip_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/slip_user.o arch/um/drivers/slip_user.c=0A=
  CC      arch/um/drivers/slirp_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/slirp_user.o arch/um/drivers/slirp_user.c=0A=
  CC      arch/um/drivers/ubd_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/ubd_user.o arch/um/drivers/ubd_user.c=0A=
  LD      arch/um/drivers/slip.o=0A=
  LD      arch/um/drivers/slirp.o=0A=
  LD      arch/um/drivers/daemon.o=0A=
  LD      arch/um/drivers/mcast.o=0A=
  LD      arch/um/drivers/net.o=0A=
  LD      arch/um/drivers/mconsole.o=0A=
  LD      arch/um/drivers/ubd.o=0A=
  LD      arch/um/drivers/hostaudio.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/fd.o arch/um/drivers/fd.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/null.o arch/um/drivers/null.c=0A=
  LD      arch/um/drivers/port.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/pty.o arch/um/drivers/pty.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/tty.o arch/um/drivers/tty.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/xterm.o arch/um/drivers/xterm.c=0A=
  CC      arch/um/drivers/xterm_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/cow_user.o arch/um/drivers/cow_user.c=0A=
  CC      arch/um/drivers/stdio_console.o=0A=
  CC      arch/um/drivers/chan_kern.o=0A=
arch/um/drivers/chan_kern.c:78: warning: `not_configged_ops' defined but =
not used=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/drivers/chan_user.o arch/um/drivers/chan_user.c=0A=
  CC      arch/um/drivers/line.o=0A=
  LD      arch/um/drivers/built-in.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/sys-i386/bugs.o arch/um/sys-i386/bugs.c=0A=
  AS      arch/um/sys-i386/checksum.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/sys-i386/fault.o arch/um/sys-i386/fault.c=0A=
  CC      arch/um/sys-i386/ksyms.o=0A=
  CC      arch/um/sys-i386/ldt.o=0A=
  CC      arch/um/sys-i386/ptrace.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/sys-i386/ptrace_user.o arch/um/sys-i386/ptrace_user.c=0A=
rm -f arch/um/sys-i386/semaphore.c=0A=
ln -sf /tmp/uml/linux-2.6.6-rc2/arch/i386/kernel/semaphore.c =
arch/um/sys-i386/semaphore.c=0A=
  CC      arch/um/sys-i386/semaphore.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/sys-i386/sigcontext.o arch/um/sys-i386/sigcontext.c=0A=
  CC      arch/um/sys-i386/syscalls.o=0A=
  CC      arch/um/sys-i386/sysrq.o=0A=
  CC      arch/um/sys-i386/time.o=0A=
  LD      arch/um/sys-i386/built-in.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/os-Linux/file.o arch/um/os-Linux/file.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/os-Linux/process.o arch/um/os-Linux/process.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/os-Linux/tty.o arch/um/os-Linux/tty.c=0A=
  CC      arch/um/os-Linux/user_syms.o=0A=
  CC      arch/um/os-Linux/drivers/ethertap_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/os-Linux/drivers/ethertap_user.o =
arch/um/os-Linux/drivers/ethertap_user.c=0A=
  CC      arch/um/os-Linux/drivers/tuntap_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/os-Linux/drivers/tuntap_user.o =
arch/um/os-Linux/drivers/tuntap_user.c=0A=
  LD      arch/um/os-Linux/drivers/ethertap.o=0A=
  LD      arch/um/os-Linux/drivers/tuntap.o=0A=
  LD      arch/um/os-Linux/drivers/built-in.o=0A=
  LD      arch/um/os-Linux/built-in.o=0A=
  CC      kernel/sched.o=0A=
  CC      kernel/fork.o=0A=
  CC      kernel/exec_domain.o=0A=
  CC      kernel/panic.o=0A=
  CC      kernel/printk.o=0A=
  CC      kernel/profile.o=0A=
  CC      kernel/exit.o=0A=
  CC      kernel/itimer.o=0A=
  CC      kernel/time.o=0A=
  CC      kernel/softirq.o=0A=
  CC      kernel/resource.o=0A=
  CC      kernel/sysctl.o=0A=
  CC      kernel/capability.o=0A=
  CC      kernel/ptrace.o=0A=
  CC      kernel/timer.o=0A=
  CC      kernel/user.o=0A=
  CC      kernel/signal.o=0A=
  CC      kernel/sys.o=0A=
  CC      kernel/kmod.o=0A=
  CC      kernel/workqueue.o=0A=
  CC      kernel/pid.o=0A=
  CC      kernel/rcupdate.o=0A=
  CC      kernel/intermodule.o=0A=
  CC      kernel/extable.o=0A=
  CC      kernel/params.o=0A=
  CC      kernel/posix-timers.o=0A=
  CC      kernel/kthread.o=0A=
  CC      kernel/futex.o=0A=
  CC      kernel/uid16.o=0A=
kernel/uid16.c: In function `groups16_from_user':=0A=
kernel/uid16.c:121: warning: initialization from incompatible pointer =
type=0A=
  CC      kernel/kallsyms.o=0A=
  CC      kernel/acct.o=0A=
  LD      kernel/built-in.o=0A=
  CC      mm/bootmem.o=0A=
  CC      mm/filemap.o=0A=
  CC      mm/mempool.o=0A=
  CC      mm/oom_kill.o=0A=
  CC      mm/fadvise.o=0A=
  CC      mm/page_alloc.o=0A=
  CC      mm/page-writeback.o=0A=
  CC      mm/pdflush.o=0A=
  CC      mm/readahead.o=0A=
  CC      mm/slab.o=0A=
  CC      mm/swap.o=0A=
  CC      mm/truncate.o=0A=
  CC      mm/vmscan.o=0A=
  CC      mm/fremap.o=0A=
  CC      mm/highmem.o=0A=
  CC      mm/madvise.o=0A=
  CC      mm/memory.o=0A=
  CC      mm/mincore.o=0A=
  CC      mm/mlock.o=0A=
  CC      mm/mmap.o=0A=
  CC      mm/mprotect.o=0A=
  CC      mm/mremap.o=0A=
  CC      mm/msync.o=0A=
  CC      mm/rmap.o=0A=
  CC      mm/shmem.o=0A=
  CC      mm/vmalloc.o=0A=
  CC      mm/page_io.o=0A=
  CC      mm/swap_state.o=0A=
  CC      mm/swapfile.o=0A=
  CC      mm/proc_mm.o=0A=
  LD      mm/built-in.o=0A=
  CC      fs/open.o=0A=
  CC      fs/read_write.o=0A=
  CC      fs/file_table.o=0A=
  CC      fs/buffer.o=0A=
  CC      fs/bio.o=0A=
  CC      fs/super.o=0A=
  CC      fs/block_dev.o=0A=
  CC      fs/char_dev.o=0A=
  CC      fs/stat.o=0A=
  CC      fs/exec.o=0A=
  CC      fs/pipe.o=0A=
  CC      fs/namei.o=0A=
  CC      fs/fcntl.o=0A=
  CC      fs/ioctl.o=0A=
  CC      fs/readdir.o=0A=
  CC      fs/select.o=0A=
  CC      fs/fifo.o=0A=
  CC      fs/locks.o=0A=
  CC      fs/dcache.o=0A=
  CC      fs/inode.o=0A=
  CC      fs/attr.o=0A=
  CC      fs/bad_inode.o=0A=
  CC      fs/file.o=0A=
  CC      fs/dnotify.o=0A=
  CC      fs/filesystems.o=0A=
  CC      fs/namespace.o=0A=
  CC      fs/seq_file.o=0A=
  CC      fs/xattr.o=0A=
  CC      fs/libfs.o=0A=
  CC      fs/fs-writeback.o=0A=
  CC      fs/mpage.o=0A=
  CC      fs/direct-io.o=0A=
  CC      fs/aio.o=0A=
  CC      fs/eventpoll.o=0A=
  CC      fs/binfmt_misc.o=0A=
  CC      fs/binfmt_script.o=0A=
  CC      fs/binfmt_elf.o=0A=
  CC      fs/dquot.o=0A=
  CC      fs/quota.o=0A=
  CC      fs/autofs/dirhash.o=0A=
  CC      fs/autofs/init.o=0A=
  CC      fs/autofs/inode.o=0A=
  CC      fs/autofs/root.o=0A=
  CC      fs/autofs/symlink.o=0A=
  CC      fs/autofs/waitq.o=0A=
  LD      fs/autofs/autofs.o=0A=
  LD      fs/autofs/built-in.o=0A=
  CC      fs/autofs4/init.o=0A=
  CC      fs/autofs4/inode.o=0A=
  CC      fs/autofs4/root.o=0A=
  CC      fs/autofs4/symlink.o=0A=
  CC      fs/autofs4/waitq.o=0A=
  CC      fs/autofs4/expire.o=0A=
  LD      fs/autofs4/autofs4.o=0A=
  LD      fs/autofs4/built-in.o=0A=
  CC      fs/devfs/base.o=0A=
  CC      fs/devfs/util.o=0A=
  LD      fs/devfs/devfs.o=0A=
  LD      fs/devfs/built-in.o=0A=
  CC      fs/devpts/inode.o=0A=
  LD      fs/devpts/devpts.o=0A=
  LD      fs/devpts/built-in.o=0A=
  CC      fs/ext2/balloc.o=0A=
  CC      fs/ext2/bitmap.o=0A=
  CC      fs/ext2/dir.o=0A=
  CC      fs/ext2/file.o=0A=
  CC      fs/ext2/fsync.o=0A=
  CC      fs/ext2/ialloc.o=0A=
  CC      fs/ext2/inode.o=0A=
  CC      fs/ext2/ioctl.o=0A=
  CC      fs/ext2/namei.o=0A=
  CC      fs/ext2/super.o=0A=
  CC      fs/ext2/symlink.o=0A=
  LD      fs/ext2/ext2.o=0A=
  LD      fs/ext2/built-in.o=0A=
  CC      fs/fat/cache.o=0A=
  CC      fs/fat/dir.o=0A=
  CC      fs/fat/file.o=0A=
  CC      fs/fat/inode.o=0A=
  CC      fs/fat/misc.o=0A=
  CC      fs/fat/fatfs_syms.o=0A=
  LD      fs/fat/fat.o=0A=
  LD      fs/fat/built-in.o=0A=
  CC      fs/hostfs/hostfs_kern.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include -D_GNU_SOURCE -O2 =
-g -DSTAT64_INO_FIELD=3D__st_ino -c -o fs/hostfs/hostfs_user.o =
fs/hostfs/hostfs_user.c=0A=
  LD      fs/hostfs/hostfs.o=0A=
  LD      fs/hostfs/built-in.o=0A=
  CC      fs/hppfs/hppfs_kern.o=0A=
  LD      fs/hppfs/hppfs.o=0A=
  LD      fs/hppfs/built-in.o=0A=
  CC      fs/isofs/namei.o=0A=
  CC      fs/isofs/inode.o=0A=
  CC      fs/isofs/dir.o=0A=
  CC      fs/isofs/util.o=0A=
  CC      fs/isofs/rock.o=0A=
  LD      fs/isofs/isofs.o=0A=
  LD      fs/isofs/built-in.o=0A=
  CC      fs/jffs/jffs_fm.o=0A=
  CC      fs/jffs/intrep.o=0A=
  CC      fs/jffs/inode-v23.o=0A=
  LD      fs/jffs/jffs.o=0A=
  LD      fs/jffs/built-in.o=0A=
  CC      fs/minix/bitmap.o=0A=
  CC      fs/minix/itree_v1.o=0A=
  CC      fs/minix/itree_v2.o=0A=
  CC      fs/minix/namei.o=0A=
  CC      fs/minix/inode.o=0A=
  CC      fs/minix/file.o=0A=
  CC      fs/minix/dir.o=0A=
  LD      fs/minix/minix.o=0A=
  LD      fs/minix/built-in.o=0A=
  CC      fs/msdos/namei.o=0A=
  CC      fs/msdos/msdosfs_syms.o=0A=
  LD      fs/msdos/msdos.o=0A=
  LD      fs/msdos/built-in.o=0A=
  CC      fs/nls/nls_base.o=0A=
  LD      fs/nls/built-in.o=0A=
  CC      fs/partitions/check.o=0A=
  CC      fs/partitions/devfs.o=0A=
  CC      fs/partitions/msdos.o=0A=
  LD      fs/partitions/built-in.o=0A=
  CC      fs/proc/task_mmu.o=0A=
  CC      fs/proc/inode.o=0A=
  CC      fs/proc/root.o=0A=
  CC      fs/proc/base.o=0A=
  CC      fs/proc/generic.o=0A=
  CC      fs/proc/array.o=0A=
  CC      fs/proc/kmsg.o=0A=
  CC      fs/proc/proc_tty.o=0A=
  CC      fs/proc/proc_misc.o=0A=
  CC      fs/proc/kcore.o=0A=
  LD      fs/proc/proc.o=0A=
  LD      fs/proc/built-in.o=0A=
  CC      fs/ramfs/inode.o=0A=
  LD      fs/ramfs/ramfs.o=0A=
  LD      fs/ramfs/built-in.o=0A=
  CC      fs/reiserfs/bitmap.o=0A=
  CC      fs/reiserfs/do_balan.o=0A=
  CC      fs/reiserfs/namei.o=0A=
  CC      fs/reiserfs/inode.o=0A=
  CC      fs/reiserfs/file.o=0A=
  CC      fs/reiserfs/dir.o=0A=
  CC      fs/reiserfs/fix_node.o=0A=
  CC      fs/reiserfs/super.o=0A=
  CC      fs/reiserfs/prints.o=0A=
  CC      fs/reiserfs/objectid.o=0A=
  CC      fs/reiserfs/lbalance.o=0A=
  CC      fs/reiserfs/ibalance.o=0A=
  CC      fs/reiserfs/stree.o=0A=
  CC      fs/reiserfs/hashes.o=0A=
  CC      fs/reiserfs/tail_conversion.o=0A=
  CC      fs/reiserfs/journal.o=0A=
  CC      fs/reiserfs/resize.o=0A=
  CC      fs/reiserfs/item_ops.o=0A=
  CC      fs/reiserfs/ioctl.o=0A=
  CC      fs/reiserfs/procfs.o=0A=
  LD      fs/reiserfs/reiserfs.o=0A=
  LD      fs/reiserfs/built-in.o=0A=
  CC      fs/sysfs/inode.o=0A=
  CC      fs/sysfs/file.o=0A=
  CC      fs/sysfs/dir.o=0A=
  CC      fs/sysfs/symlink.o=0A=
  CC      fs/sysfs/mount.o=0A=
  CC      fs/sysfs/bin.o=0A=
  CC      fs/sysfs/group.o=0A=
  LD      fs/sysfs/built-in.o=0A=
  CC      fs/vfat/namei.o=0A=
  CC      fs/vfat/vfatfs_syms.o=0A=
  LD      fs/vfat/vfat.o=0A=
  LD      fs/vfat/built-in.o=0A=
  LD      fs/built-in.o=0A=
  CC      ipc/util.o=0A=
  CC      ipc/msgutil.o=0A=
  CC      ipc/msg.o=0A=
  CC      ipc/sem.o=0A=
  CC      ipc/shm.o=0A=
  LD      ipc/built-in.o=0A=
  CC      security/commoncap.o=0A=
  CC      security/capability.o=0A=
  LD      security/built-in.o=0A=
  LD      crypto/built-in.o=0A=
  CC      drivers/base/core.o=0A=
  CC      drivers/base/sys.o=0A=
  CC      drivers/base/interface.o=0A=
  CC      drivers/base/bus.o=0A=
  CC      drivers/base/driver.o=0A=
  CC      drivers/base/class.o=0A=
  CC      drivers/base/class_simple.o=0A=
  CC      drivers/base/platform.o=0A=
  CC      drivers/base/cpu.o=0A=
  CC      drivers/base/firmware.o=0A=
  CC      drivers/base/init.o=0A=
  CC      drivers/base/map.o=0A=
  CC      drivers/base/dmapool.o=0A=
  CC      drivers/base/power/shutdown.o=0A=
  LD      drivers/base/power/built-in.o=0A=
  LD      drivers/base/built-in.o=0A=
  CC      drivers/block/elevator.o=0A=
  CC      drivers/block/ll_rw_blk.o=0A=
  CC      drivers/block/ioctl.o=0A=
  CC      drivers/block/genhd.o=0A=
  CC      drivers/block/scsi_ioctl.o=0A=
  CC      drivers/block/noop-iosched.o=0A=
  CC      drivers/block/as-iosched.o=0A=
  CC      drivers/block/deadline-iosched.o=0A=
  CC      drivers/block/cfq-iosched.o=0A=
  CC      drivers/block/rd.o=0A=
  CC      drivers/block/loop.o=0A=
  CC      drivers/block/nbd.o=0A=
  LD      drivers/block/built-in.o=0A=
  LD      drivers/cdrom/built-in.o=0A=
  CC      drivers/char/mem.o=0A=
  CC      drivers/char/random.o=0A=
  CC      drivers/char/tty_io.o=0A=
  CC      drivers/char/n_tty.o=0A=
  CC      drivers/char/tty_ioctl.o=0A=
  CC      drivers/char/pty.o=0A=
  CC      drivers/char/misc.o=0A=
  CC      drivers/char/sysrq.o=0A=
  LD      drivers/char/built-in.o=0A=
  LD      drivers/firmware/built-in.o=0A=
  LD      drivers/media/common/built-in.o=0A=
  LD      drivers/media/dvb/b2c2/built-in.o=0A=
  LD      drivers/media/dvb/bt8xx/built-in.o=0A=
  LD      drivers/media/dvb/dvb-core/built-in.o=0A=
  LD      drivers/media/dvb/frontends/built-in.o=0A=
  LD      drivers/media/dvb/ttpci/built-in.o=0A=
  LD      drivers/media/dvb/ttusb-budget/built-in.o=0A=
  LD      drivers/media/dvb/ttusb-dec/built-in.o=0A=
  LD      drivers/media/dvb/built-in.o=0A=
  LD      drivers/media/radio/built-in.o=0A=
  LD      drivers/media/video/built-in.o=0A=
  LD      drivers/media/built-in.o=0A=
  LD      drivers/misc/built-in.o=0A=
  CC      drivers/mtd/mtdcore.o=0A=
  CC      drivers/mtd/mtdchar.o=0A=
  CC      drivers/mtd/mtdblock.o=0A=
  CC      drivers/mtd/mtd_blkdevs.o=0A=
  CC      drivers/mtd/chips/chipreg.o=0A=
In file included from drivers/mtd/chips/chipreg.c:14:=0A=
include/linux/mtd/map.h: In function `map_read8':=0A=
include/linux/mtd/map.h:106: warning: implicit declaration of function =
`__raw_readb'=0A=
include/linux/mtd/map.h: In function `map_read16':=0A=
include/linux/mtd/map.h:111: warning: implicit declaration of function =
`__raw_readw'=0A=
include/linux/mtd/map.h: In function `map_read32':=0A=
include/linux/mtd/map.h:116: warning: implicit declaration of function =
`__raw_readl'=0A=
include/linux/mtd/map.h: In function `map_write8':=0A=
include/linux/mtd/map.h:131: warning: implicit declaration of function =
`__raw_writeb'=0A=
include/linux/mtd/map.h: In function `map_write16':=0A=
include/linux/mtd/map.h:137: warning: implicit declaration of function =
`__raw_writew'=0A=
include/linux/mtd/map.h: In function `map_write32':=0A=
include/linux/mtd/map.h:143: warning: implicit declaration of function =
`__raw_writel'=0A=
include/linux/mtd/map.h: In function `map_copy_from':=0A=
include/linux/mtd/map.h:159: warning: implicit declaration of function =
`memcpy_fromio'=0A=
include/linux/mtd/map.h: In function `map_copy_to':=0A=
include/linux/mtd/map.h:164: warning: implicit declaration of function =
`memcpy_toio'=0A=
  LD      drivers/mtd/chips/built-in.o=0A=
  CC      drivers/mtd/devices/blkmtd.o=0A=
  LD      drivers/mtd/devices/built-in.o=0A=
  LD      drivers/mtd/maps/built-in.o=0A=
  LD      drivers/mtd/nand/built-in.o=0A=
  LD      drivers/mtd/built-in.o=0A=
  CC      drivers/net/Space.o=0A=
  CC      drivers/net/net_init.o=0A=
  CC      drivers/net/loopback.o=0A=
  CC      drivers/net/ppp_generic.o=0A=
  CC      drivers/net/slhc.o=0A=
  CC      drivers/net/slip.o=0A=
  CC      drivers/net/dummy.o=0A=
  CC      drivers/net/tun.o=0A=
  LD      drivers/net/built-in.o=0A=
  LD      drivers/serial/built-in.o=0A=
  LD      drivers/video/built-in.o=0A=
  LD      drivers/built-in.o=0A=
  CC      sound/sound_core.o=0A=
  CC      sound/sound_firmware.o=0A=
  LD      sound/soundcore.o=0A=
  LD      sound/built-in.o=0A=
  CC      net/socket.o=0A=
  CC      net/802/p8023.o=0A=
  CC      net/802/sysctl_net_802.o=0A=
  LD      net/802/built-in.o=0A=
  CC      net/core/sock.o=0A=
  CC      net/core/skbuff.o=0A=
  CC      net/core/iovec.o=0A=
  CC      net/core/datagram.o=0A=
  CC      net/core/scm.o=0A=
  CC      net/core/sysctl_net_core.o=0A=
  CC      net/core/flow.o=0A=
  CC      net/core/dev.o=0A=
  CC      net/core/ethtool.o=0A=
  CC      net/core/net-sysfs.o=0A=
  CC      net/core/dev_mcast.o=0A=
  CC      net/core/dst.o=0A=
  CC      net/core/neighbour.o=0A=
  CC      net/core/rtnetlink.o=0A=
  CC      net/core/utils.o=0A=
  CC      net/core/link_watch.o=0A=
  CC      net/core/filter.o=0A=
  LD      net/core/built-in.o=0A=
  CC      net/ethernet/eth.o=0A=
  CC      net/ethernet/sysctl_net_ether.o=0A=
  LD      net/ethernet/built-in.o=0A=
  CC      net/ipv4/utils.o=0A=
  CC      net/ipv4/route.o=0A=
  CC      net/ipv4/inetpeer.o=0A=
  CC      net/ipv4/protocol.o=0A=
  CC      net/ipv4/ip_input.o=0A=
  CC      net/ipv4/ip_fragment.o=0A=
  CC      net/ipv4/ip_forward.o=0A=
  CC      net/ipv4/ip_options.o=0A=
  CC      net/ipv4/ip_output.o=0A=
  CC      net/ipv4/ip_sockglue.o=0A=
  CC      net/ipv4/tcp.o=0A=
  CC      net/ipv4/tcp_input.o=0A=
  CC      net/ipv4/tcp_output.o=0A=
  CC      net/ipv4/tcp_timer.o=0A=
  CC      net/ipv4/tcp_ipv4.o=0A=
  CC      net/ipv4/tcp_minisocks.o=0A=
  CC      net/ipv4/tcp_diag.o=0A=
  CC      net/ipv4/raw.o=0A=
  CC      net/ipv4/udp.o=0A=
  CC      net/ipv4/arp.o=0A=
  CC      net/ipv4/icmp.o=0A=
  CC      net/ipv4/devinet.o=0A=
  CC      net/ipv4/af_inet.o=0A=
  CC      net/ipv4/igmp.o=0A=
  CC      net/ipv4/sysctl_net_ipv4.o=0A=
  CC      net/ipv4/fib_frontend.o=0A=
  CC      net/ipv4/fib_semantics.o=0A=
  CC      net/ipv4/fib_hash.o=0A=
  CC      net/ipv4/proc.o=0A=
  LD      net/ipv4/built-in.o=0A=
  CC      net/netlink/af_netlink.o=0A=
  LD      net/netlink/built-in.o=0A=
  CC      net/packet/af_packet.o=0A=
  LD      net/packet/built-in.o=0A=
  CC      net/sched/sch_generic.o=0A=
  LD      net/sched/built-in.o=0A=
  CC      net/unix/af_unix.o=0A=
  CC      net/unix/garbage.o=0A=
  CC      net/unix/sysctl_net_unix.o=0A=
  LD      net/unix/unix.o=0A=
  LD      net/unix/built-in.o=0A=
  LD      net/xfrm/built-in.o=0A=
  CC      net/sysctl_net.o=0A=
  LD      net/built-in.o=0A=
  CC      lib/kref.o=0A=
  LD      lib/built-in.o=0A=
  CC      lib/bitmap.o=0A=
  CC      lib/bust_spinlocks.o=0A=
  CC      lib/cmdline.o=0A=
  CC      lib/ctype.o=0A=
  CC      lib/dec_and_lock.o=0A=
  CC      lib/div64.o=0A=
  CC      lib/dump_stack.o=0A=
  CC      lib/errno.o=0A=
  CC      lib/extable.o=0A=
  CC      lib/idr.o=0A=
  CC      lib/int_sqrt.o=0A=
  CC      lib/kobject.o=0A=
  CC      lib/parser.o=0A=
  CC      lib/radix-tree.o=0A=
  CC      lib/rbtree.o=0A=
  CC      lib/rwsem-spinlock.o=0A=
  CC      lib/string.o=0A=
  CC      lib/vsprintf.o=0A=
  AR      lib/lib.a=0A=
  GEN     .version=0A=
  CHK     include/linux/compile.h=0A=
  UPD     include/linux/compile.h=0A=
  CC      init/version.o=0A=
  LD      init/built-in.o=0A=
  LD      .tmp_vmlinux1=0A=
  KSYM    .tmp_kallsyms1.S=0A=
  AS      .tmp_kallsyms1.o=0A=
  LD      .tmp_vmlinux2=0A=
  KSYM    .tmp_kallsyms2.S=0A=
  AS      .tmp_kallsyms2.o=0A=
  MAIN    arch/um/main.o=0A=
  LD      vmlinux=0A=
  CPP     arch/um/uml.lds.s=0A=
gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free =
-Wl,--wrap,calloc \=0A=
	-o linux arch/um/main.o vmlinux -L/usr/lib -lutil=0A=
vmlinux(.text+0xcf52): In function `config_gdb_cb':=0A=
arch/um/kernel/tt/gdb.c:129: undefined reference to `TASK_EXTERN_PID'=0A=
collect2: ld returned 1 exit status=0A=
make: *** [linux] Error 1=0A=

------=_NextPart_000_0067_01C42FD2.9194C420
Content-Type: application/octet-stream;
	name="make.log"
Content-Disposition: attachment;
	filename="make.log"
Content-Transfer-Encoding: quoted-printable

  HOSTCC  arch/um/sys-i386/util/mk_sc=0A=
  CHK     arch/um/include/sysdep-i386/sc.h=0A=
  HOSTCC  arch/um/util/mk_constants_kern.o=0A=
  HOSTCC  arch/um/util/mk_constants_user.o=0A=
  HOSTCC  arch/um/util/mk_task_kern.o=0A=
  HOSTCC  arch/um/util/mk_task_user.o=0A=
  HOSTLD  arch/um/util/mk_task=0A=
  HOSTLD  arch/um/util/mk_constants=0A=
  CHK     arch/um/include/task.h=0A=
  CHK     arch/um/include/kern_constants.h=0A=
  HOSTCC  arch/um/sys-i386/util/mk_thread_kern.o=0A=
  HOSTCC  arch/um/sys-i386/util/mk_thread_user.o=0A=
  HOSTLD  arch/um/sys-i386/util/mk_thread=0A=
  CHK     arch/um/include/sysdep-i386/thread.h=0A=
  HOSTCC  scripts/basic/fixdep=0A=
  HOSTCC  scripts/basic/split-include=0A=
  HOSTCC  scripts/basic/docproc=0A=
  HOSTCC  scripts/conmakehash=0A=
  HOSTCC  scripts/kallsyms=0A=
  CC      scripts/empty.o=0A=
  HOSTCC  scripts/mk_elfconfig=0A=
  MKELF   scripts/elfconfig.h=0A=
  HOSTCC  scripts/file2alias.o=0A=
  HOSTCC  scripts/modpost.o=0A=
  HOSTCC  scripts/sumversion.o=0A=
  HOSTLD  scripts/modpost=0A=
  HOSTCC  scripts/pnmtologo=0A=
  HOSTCC  scripts/bin2c=0A=
  CC      init/main.o=0A=
  CHK     include/linux/compile.h=0A=
  UPD     include/linux/compile.h=0A=
  CC      init/version.o=0A=
  CC      init/do_mounts.o=0A=
  CC      init/do_mounts_devfs.o=0A=
  CC      init/do_mounts_rd.o=0A=
  CC      init/do_mounts_initrd.o=0A=
  LD      init/mounts.o=0A=
  CC      init/initramfs.o=0A=
  LD      init/built-in.o=0A=
  HOSTCC  usr/gen_init_cpio=0A=
  CPIO    usr/initramfs_data.cpio=0A=
  GZIP    usr/initramfs_data.cpio.gz=0A=
  AS      usr/initramfs_data.o=0A=
  LD      usr/built-in.o=0A=
  CC      arch/um/kernel/checksum.o=0A=
  QUOTE arch/um/kernel/config.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/skas/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/config.o arch/um/kernel/config.c=0A=
  CC      arch/um/kernel/exec_kern.o=0A=
  CC      arch/um/kernel/exitcode.o=0A=
  CC      arch/um/kernel/frame_kern.o=0A=
gcc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/skas/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/frame.o arch/um/kernel/frame.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/skas/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/helper.o arch/um/kernel/helper.c=0A=
  CC      arch/um/kernel/init_task.o=0A=
  CC      arch/um/kernel/irq.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/skas/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/irq_user.o arch/um/kernel/irq_user.c=0A=
  CC      arch/um/kernel/ksyms.o=0A=
  CC      arch/um/kernel/mem.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/skas/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/mem_user.o arch/um/kernel/mem_user.c=0A=
  CC      arch/um/kernel/physmem.o=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/skas/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/process.o arch/um/kernel/process.c=0A=
arch/um/kernel/process.c: In function `can_do_skas':=0A=
arch/um/kernel/process.c:261: error: storage size of `fi' isn't known=0A=
arch/um/kernel/process.c:268: error: `PTRACE_FAULTINFO' undeclared =
(first use in this function)=0A=
arch/um/kernel/process.c:268: error: (Each undeclared identifier is =
reported only once=0A=
arch/um/kernel/process.c:268: error: for each function it appears in.)=0A=
arch/um/kernel/process.c:261: warning: unused variable `fi'=0A=
make[1]: *** [arch/um/kernel/process.o] Error 1=0A=
make: *** [arch/um/kernel] Error 2=0A=

------=_NextPart_000_0067_01C42FD2.9194C420--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
