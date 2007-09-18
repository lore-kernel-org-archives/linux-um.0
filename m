Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IXkCG-00016C-El for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Sep 2007 14:01:28 -0700
Received: from is1.enterasys.com ([63.160.138.53])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IXkCC-00022V-Ez
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Sep 2007 14:01:28 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 18 Sep 2007 17:00:39 -0400
Message-ID: <5A9C383ECECEEE4F82BD5E7DCCD318E9C570C2@MABOSEVS1.ets.enterasys.com>
From: "Bradshaw, James" <jbradsha@enterasys.com>
Subject: [uml-devel] vmalloc and shared memory question
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1343436240=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1343436240==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7FA36.F7FC0A85"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7FA36.F7FC0A85
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I'm running into a problem with a 2.6.14.7 UML kernel and I wonder if
anyone can help. The issue appears to be that memory allocated by a call
to vmalloc lies outside the UML's virtual memory map, so that a
subsequent pointer dereference ends up causing a seg fault. The vmalloc
call is in cramfs_uncompress_init:

=20

int cramfs_uncompress_init(void)

{

        if (!initialized++) {

                stream.workspace =3D
vmalloc(zlib_inflate_workspacesize());=20

                if ( !stream.workspace ) {

                        initialized =3D 0;

                        return -ENOMEM;

                }

                stream.next_in =3D NULL;

                stream.avail_in =3D 0;

                zlib_inflateInit(&stream);

        }

        return 0;

}

=20

The value of stream.workspace after the call to vmalloc is 0xa800000;
the value returned by zlib_inflate_workspacesize() is 46912. I am
running a 2.6.9 host with the skas3-v8.2 patch applied. Looking at the
/proc/pid/maps shows the following:

=20

$ cat /proc/20723/maps

0072f000-00731000 r-xp 00000000 03:02 1680732    /lib/libutil-2.3.4.so

00731000-00733000 rwxp 00001000 03:02 1680732    /lib/libutil-2.3.4.so

008f2000-00907000 r-xp 00000000 03:02 1678838    /lib/ld-2.3.4.so

00907000-00908000 r-xp 00015000 03:02 1678838    /lib/ld-2.3.4.so

00908000-00909000 rwxp 00016000 03:02 1678838    /lib/ld-2.3.4.so

0090f000-00a33000 r-xp 00000000 03:02 1680726    /lib/tls/libc-2.3.4.so

00a33000-00a34000 r-xp 00124000 03:02 1680726    /lib/tls/libc-2.3.4.so

00a34000-00a37000 rwxp 00125000 03:02 1680726    /lib/tls/libc-2.3.4.so

00a37000-00a39000 rwxp 00a37000 00:00 0

08048000-0826d000 rwxp 00000000 00:5a 6373586
/net/ramones/export2/views/jbradsha/jbradsha_2.6.vws/.s/00051/8000009d46
bfc2aflinux

0826d000-082b6000 rwxp 0826d000 00:00 0

082b6000-0a048000 rwxs 0026e000 00:11 2645087    /dev/shm/vm_file-uPBwQg
(deleted)

b7ffd000-b8000000 rwxp b7ffd000 00:00 0

bfffd000-c0000000 rwxp bfffd000 00:00 0

ffffe000-fffff000 ---p 00000000 00:00 0

=20

I note that 0xa800000 is not in any of the mapped regions. Prior to the
vmalloc() call, the following log messages are seen:

=20

Checking that ptrace can change system call numbers...OK

Checking syscall emulation patch for ptrace...OK

Checking advanced syscall emulation patch for ptrace...OK

Checking for tmpfs mount on /dev/shm...OK

Checking PROT_EXEC mmap in /dev/shm/...OK

Checking for the skas3 patch in the host:

  - /proc/mm...found

  - PTRACE_FAULTINFO...found

  - PTRACE_LDT...found

UML running in SKAS3 mode

Checking that ptrace can change system call numbers...OK

Checking syscall emulation patch for ptrace...OK

Checking advanced syscall emulation patch for ptrace...OK

=20

=20

I have 1G of physical memory, and I start the UML with the "mem=3D768M"
argument. Pertinent shared memory information may be:

=20

 $ mount | grep shm

none on /dev/shm type tmpfs (rw,size=3D1G)

=20

$ df /dev/shm/

Filesystem           1K-blocks      Used Available Use% Mounted on

none                   1048576      1160   1047416   1% /dev/shm

=20

Continuing past the breakpoint results in a seg fault:

=20

Breakpoint 1, cramfs_uncompress_init () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/fs/cramfs/uncompre
ss.c:58

(gdb) cont

=20

Program received signal SIGSEGV, Segmentation fault.

zlib_inflateInit2_ (z=3D0x8281c80, w=3D15, version=3D0xa80005c <Address
0xa80005c out of bounds>, stream_size=3D48) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/lib/zlib_inflate/i
nflate.c:58

=20

  44 int zlib_inflateInit2_(

  45         z_streamp z,

  46         int w,

  47         const char *version,

  48         int stream_size

  49 )

  50 {

  51   if (version =3D=3D NULL || version[0] !=3D ZLIB_VERSION[0] ||

  52       stream_size !=3D sizeof(z_stream) || z->workspace =3D=3D =
NULL)

  53       return Z_VERSION_ERROR;

  54=20

  55   /* initialize state */

  56   z->msg =3D NULL;

  57   z->state =3D &WS(z)->internal_state;

  58   z->state->blocks =3D NULL;

  59

=20

(gdb) p *z

$11 =3D {next_in =3D 0x0, avail_in =3D 0, total_in =3D 0, next_out =3D =
0x0,
avail_out =3D 0, total_out =3D 0, msg =3D 0x0, state =3D 0xa80005c, =
workspace =3D
0xa800000, data_type =3D 0, adler =3D 0, reserved =3D 0}

=20

The backtrace is:

=20

(gdb) bt

#0  zlib_inflateInit2_ (z=3D0x8281c80, w=3D15, version=3D0xa80005c =
<Address
0xa80005c out of bounds>, stream_size=3D48) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/lib/zlib_inflate/i
nflate.c:58

#1  0x0814c546 in zlib_inflateInit_ (z=3D0x8281c80, version=3D0x820e4a9
"1.1.3", stream_size=3D48) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/lib/zlib_inflate/i
nflate.c:110

#2  0x0810c95f in cramfs_uncompress_init () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/fs/cramfs/uncompre
ss.c:66

#3  0x08051d88 in init_cramfs_fs () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/fs/cramfs/inode.c:
577

#4  0x08049618 in do_initcalls () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/init/main.c:589

#5  0x080496d1 in do_basic_setup () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/init/main.c:631

#6  0x08058496 in init (unused=3D0x0) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/init/main.c:704

#7  0x0806c148 in run_kernel_thread (fn=3D0x8058460 <init>, arg=3D0x0,
jmp_ptr=3D0xa80005c) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/os-Linux/p
rocess.c:285

#8  0x0805e24c in new_thread_handler (sig=3D10) at
include2/asm/thread_info.h:49

#9  <signal handler called>

=20

The value of the argument "z" in frames #0 and #1 is the address of the
static variable "stream," of type z_stream, declared in uncompress.c.

=20

Naively, I would say that vmalloc is misbehaving by returning a value
outside the process virtual memory map (also strange is that the shared
memory file has been deleted-is that significant?), but I'm sure there's
more to it than that-or maybe my analysis is just wrong. Can anyone
help?

=20

Thanks in advance.

=20

James T. Bradshaw

Firmware Engineer

Enterasys Networks

50 Minuteman Rd.

Andover, MA 01810

USA

Tel. (978) 684-1544=20


------_=_NextPart_001_01C7FA36.F7FC0A85
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;m running into a problem with a 2.6.14.7 =
UML kernel
and I wonder if anyone can help. The issue appears to be that memory =
allocated
by a call to vmalloc lies outside the UML&#8217;s virtual memory map, so =
that a
subsequent pointer dereference ends up causing a seg fault. The vmalloc =
call is
in cramfs_uncompress_init:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>int cramfs_uncompress_init(void)<o:p></o:p></p>

<p class=3DMsoNormal>{<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
(!initialized++) {<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
stream.workspace =3D vmalloc(zlib_inflate_workspacesize()); =
<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if ( !stream.workspace ) {<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
initialized =3D 0;<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
return -ENOMEM;<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
}<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
stream.next_in =3D NULL;<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
stream.avail_in =3D 0;<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;z=
lib_inflateInit(&amp;stream);<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
0;<o:p></o:p></p>

<p class=3DMsoNormal>}<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The value of stream.workspace after the call to =
vmalloc is
0xa800000; the value returned by zlib_inflate_workspacesize() is 46912. =
I am
running a 2.6.9 host with the skas3-v8.2 patch applied. Looking at the
/proc/pid/maps shows the following:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>$ cat /proc/20723/maps<o:p></o:p></p>

<p class=3DMsoNormal>0072f000-00731000 r-xp 00000000 03:02
1680732&nbsp;&nbsp;&nbsp; /lib/libutil-2.3.4.so<o:p></o:p></p>

<p class=3DMsoNormal>00731000-00733000 rwxp 00001000 03:02
1680732&nbsp;&nbsp;&nbsp; /lib/libutil-2.3.4.so<o:p></o:p></p>

<p class=3DMsoNormal>008f2000-00907000 r-xp 00000000 03:02
1678838&nbsp;&nbsp;&nbsp; /lib/ld-2.3.4.so<o:p></o:p></p>

<p class=3DMsoNormal>00907000-00908000 r-xp 00015000 03:02
1678838&nbsp;&nbsp;&nbsp; /lib/ld-2.3.4.so<o:p></o:p></p>

<p class=3DMsoNormal>00908000-00909000 rwxp 00016000 03:02
1678838&nbsp;&nbsp;&nbsp; /lib/ld-2.3.4.so<o:p></o:p></p>

<p class=3DMsoNormal>0090f000-00a33000 r-xp 00000000 03:02
1680726&nbsp;&nbsp;&nbsp; /lib/tls/libc-2.3.4.so<o:p></o:p></p>

<p class=3DMsoNormal>00a33000-00a34000 r-xp 00124000 03:02
1680726&nbsp;&nbsp;&nbsp; /lib/tls/libc-2.3.4.so<o:p></o:p></p>

<p class=3DMsoNormal>00a34000-00a37000 rwxp 00125000 03:02
1680726&nbsp;&nbsp;&nbsp; /lib/tls/libc-2.3.4.so<o:p></o:p></p>

<p class=3DMsoNormal>00a37000-00a39000 rwxp 00a37000 00:00 =
0<o:p></o:p></p>

<p class=3DMsoNormal>08048000-0826d000 rwxp 00000000 00:5a
6373586&nbsp;&nbsp;&nbsp;
/net/ramones/export2/views/jbradsha/jbradsha_2.6.vws/.s/00051/8000009d46b=
fc2aflinux<o:p></o:p></p>

<p class=3DMsoNormal>0826d000-082b6000 rwxp 0826d000 00:00 =
0<o:p></o:p></p>

<p class=3DMsoNormal>082b6000-0a048000 rwxs 0026e000 00:11
2645087&nbsp;&nbsp;&nbsp; /dev/shm/vm_file-uPBwQg =
(deleted)<o:p></o:p></p>

<p class=3DMsoNormal>b7ffd000-b8000000 rwxp b7ffd000 00:00 =
0<o:p></o:p></p>

<p class=3DMsoNormal>bfffd000-c0000000 rwxp bfffd000 00:00 =
0<o:p></o:p></p>

<p class=3DMsoNormal>ffffe000-fffff000 ---p 00000000 00:00 =
0<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I note that 0xa800000 is not in any of the mapped =
regions. Prior
to the vmalloc() call, the following log messages are =
seen:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Checking that ptrace can change system call =
numbers...OK<o:p></o:p></p>

<p class=3DMsoNormal>Checking syscall emulation patch for =
ptrace...OK<o:p></o:p></p>

<p class=3DMsoNormal>Checking advanced syscall emulation patch for =
ptrace...OK<o:p></o:p></p>

<p class=3DMsoNormal>Checking for tmpfs mount on =
/dev/shm...OK<o:p></o:p></p>

<p class=3DMsoNormal>Checking PROT_EXEC mmap in =
/dev/shm/...OK<o:p></o:p></p>

<p class=3DMsoNormal>Checking for the skas3 patch in the =
host:<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; - /proc/mm...found<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; - PTRACE_FAULTINFO...found<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; - PTRACE_LDT...found<o:p></o:p></p>

<p class=3DMsoNormal>UML running in SKAS3 mode<o:p></o:p></p>

<p class=3DMsoNormal>Checking that ptrace can change system call =
numbers...OK<o:p></o:p></p>

<p class=3DMsoNormal>Checking syscall emulation patch for =
ptrace...OK<o:p></o:p></p>

<p class=3DMsoNormal>Checking advanced syscall emulation patch for =
ptrace...OK<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have 1G of physical memory, and I start the UML =
with the &#8220;mem=3D768M&#8221;
argument. Pertinent shared memory information may be:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&nbsp;$ mount | grep shm<o:p></o:p></p>

<p class=3DMsoNormal>none on /dev/shm type tmpfs =
(rw,size=3D1G)<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>$ df /dev/shm/<o:p></o:p></p>

<p =
class=3DMsoNormal>Filesystem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
1K-blocks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Used Available Use% Mounted =
on<o:p></o:p></p>

<p =
class=3DMsoNormal>none&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1048576&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1160 =
&nbsp;&nbsp;1047416&nbsp;&nbsp; 1%
/dev/shm<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Continuing past the breakpoint results in a seg =
fault:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Breakpoint 1, cramfs_uncompress_init () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/fs/cramfs/uncompres=
s.c:58<o:p></o:p></p>

<p class=3DMsoNormal>(gdb) cont<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Program received signal SIGSEGV, Segmentation =
fault.<o:p></o:p></p>

<p class=3DMsoNormal>zlib_inflateInit2_ (z=3D0x8281c80, w=3D15, =
version=3D0xa80005c
&lt;Address 0xa80005c out of bounds&gt;, stream_size=3D48) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/lib/zlib_inflate/in=
flate.c:58<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&nbsp; 44 int zlib_inflateInit2_(<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; =
45&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
z_streamp z,<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; =
46&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
int w,<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; =
47&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
const char *version,<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; =
48&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
int stream_size<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 49 )<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 50 {<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 51&nbsp;&nbsp; if (version =3D=3D NULL || =
version[0] !=3D
ZLIB_VERSION[0] ||<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 52&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
stream_size !=3D
sizeof(z_stream) || z-&gt;workspace =3D=3D NULL)<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 53&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return
Z_VERSION_ERROR;<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 54 <o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 55&nbsp;&nbsp; /* initialize state =
*/<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 56&nbsp;&nbsp; z-&gt;msg =3D =
NULL;<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 57&nbsp;&nbsp; z-&gt;state =3D
&amp;WS(z)-&gt;internal_state;<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 58&nbsp;&nbsp; z-&gt;state-&gt;blocks =3D =
NULL;<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 59<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>(gdb) p *z<o:p></o:p></p>

<p class=3DMsoNormal>$11 =3D {next_in =3D 0x0, avail_in =3D 0, total_in =
=3D 0, next_out =3D
0x0, avail_out =3D 0, total_out =3D 0, msg =3D 0x0, state =3D 0xa80005c, =
workspace =3D
0xa800000, data_type =3D 0, adler =3D 0, reserved =3D 0}<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The backtrace is:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>(gdb) bt<o:p></o:p></p>

<p class=3DMsoNormal>#0&nbsp; zlib_inflateInit2_ (z=3D0x8281c80, w=3D15,
version=3D0xa80005c &lt;Address 0xa80005c out of bounds&gt;, =
stream_size=3D48) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/lib/zlib_inflate/in=
flate.c:58<o:p></o:p></p>

<p class=3DMsoNormal>#1&nbsp; 0x0814c546 in zlib_inflateInit_ =
(z=3D0x8281c80,
version=3D0x820e4a9 &quot;1.1.3&quot;, stream_size=3D48) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/lib/zlib_inflate/in=
flate.c:110<o:p></o:p></p>

<p class=3DMsoNormal>#2&nbsp; 0x0810c95f in cramfs_uncompress_init () at =
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/fs/cramfs/uncompres=
s.c:66<o:p></o:p></p>

<p class=3DMsoNormal>#3&nbsp; 0x08051d88 in init_cramfs_fs () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/fs/cramfs/inode.c:5=
77<o:p></o:p></p>

<p class=3DMsoNormal>#4&nbsp; 0x08049618 in do_initcalls () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/init/main.c:589<o:p=
></o:p></p>

<p class=3DMsoNormal>#5&nbsp; 0x080496d1 in do_basic_setup () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/init/main.c:631<o:p=
></o:p></p>

<p class=3DMsoNormal>#6&nbsp; 0x08058496 in init (unused=3D0x0) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/init/main.c:704<o:p=
></o:p></p>

<p class=3DMsoNormal>#7&nbsp; 0x0806c148 in run_kernel_thread =
(fn=3D0x8058460
&lt;init&gt;, arg=3D0x0, jmp_ptr=3D0xa80005c) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/os-Linux/pr=
ocess.c:285<o:p></o:p></p>

<p class=3DMsoNormal>#8&nbsp; 0x0805e24c in new_thread_handler =
(sig=3D10) at
include2/asm/thread_info.h:49<o:p></o:p></p>

<p class=3DMsoNormal>#9&nbsp; &lt;signal handler =
called&gt;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The value of the argument &#8220;z&#8221; in frames =
#0 and
#1 is the address of the static variable &#8220;stream,&#8221; of type
z_stream, declared in uncompress.c.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Naively, I would say that vmalloc is misbehaving by
returning a value outside the process virtual memory map (also strange =
is that
the shared memory file has been deleted&#8212;is that significant?), but =
I&#8217;m
sure there&#8217;s more to it than that&#8212;or maybe my analysis is =
just
wrong. Can anyone help?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks in advance.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>James
T. Bradshaw</span><span style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif"'><o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Firmware
Engineer</span><span style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif"'><o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Enterasys
Networks</span><span style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif"'><o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>50
Minuteman Rd.</span><span style=3D'font-size:12.0pt;font-family:"Times =
New Roman","serif"'><o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Andover,
MA 01810</span><span style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif"'><o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>USA</span><sp=
an
style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif"'><o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Tel.
(978) 684-1544</span><span style=3D'font-size:12.0pt;font-family:"Times =
New Roman","serif"'>&nbsp;</span><o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7FA36.F7FC0A85--



--===============1343436240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1343436240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1343436240==--


