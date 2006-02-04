Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F5CmP-00016S-0u for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Feb 2006 18:04:01 -0800
Received: from smtp07.web.de ([217.72.192.225])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F5CmK-00071R-TD
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Feb 2006 18:04:01 -0800
Message-ID: <000901c6292f$c1cd0b40$0200000a@aldipc>
From: "roland" <devzero@web.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0006_01C62938.1EA428A0"
Subject: [uml-devel] AoE with UML?   have a strange problem with AoE root
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
Date: Sat, 4 Feb 2006 03:07:23 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com, blaisorblade@yahoo.it

This is a multi-part message in MIME format.

------=_NextPart_000_0006_01C62938.1EA428A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello UML people,=20

unfortunately i wasn't into UML very much for the last months - but from =
time to time i take a look how the project is going. it`s nice to see =
that it's stell going on besides all of that virtualization "madness" =
out there in IT.=20

i find UML very useful and this time gave it a try for testing a driver =
- but =EC'm experience a rather strange problem and cannot explain =
what`s happening here - maybe someone can give me a hint how to dig into =
this.


i try to use AoE (Ata over Ethernet) inside UML.

for those who don`t know about AoE:

AoE is sort of iSCSI - but - without tcp/ip, just on ethernet layer=20
a good introduction is at http://linuxdevices.com/news/NS3189760067.html
(btw: you don`t need to buy coraid's etherblade - there are software =
versions for that "AoE server part" on the net)


I don`t know yet if i can use it inside UML without problems at all - =
but - anyway what i'm experiencing is strange.
i would have expected a different behaviour.

I compiled an 2.6.15 vanilla kernel, manually patched with aoe6-21 =
driver from coraid`s (AoE inventor) website.

compile goes fine and i can start the kernel, seeing the AoE driver =
initialize

# ./linux
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking PROT_EXEC mmap in /tmp...OK
Checking for the skas3 patch in the host:
  - /proc/mm...found
  - PTRACE_FAULTINFO...found
  - PTRACE_LDT...found
UML running in SKAS3 mode
Linux version 2.6.15 (root@vmhost) (gcc version 3.3.3 (SuSE Linux)) #4 =
Sat Feb 4 02:35:50 CET 2006
Built 1 zonelists
Kernel command line: root=3D98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 29824k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with =
errno 2)
Using 2.6 host AIO
NET: Registered protocol family 16
make_proc_exitcode : Failed to register /proc/exitcode
io scheduler noop registered
loop: loaded (max 8 devices)

aoe: aoe_init: AoE v21 initialised.        <- good - the AoE driver is =
initializing here

NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
Failed to open 'root_fs', errno =3D 2
Kernel panic - not syncing: VFS: Unable to mount root fs on =
unknown-block(98,0)

EIP: 0073:[<a00e20c1>] CPU: 0 Not tainted ESP: 007b:40001fb8 EFLAGS: =
00000212
    Not tainted
EAX: 00000000 EBX: 000023b1 ECX: 00000013 EDX: 000023b1
ESI: 000023ae EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
a0253b60:  [<a003e2ad>] notifier_call_chain+0x2d/0x50
a0253b7c:  [<a002e871>] panic+0x71/0x110
a0253b94:  [<a0001ab8>] mount_block_root+0xc8/0x140
a0253bd8:  [<a0001b8c>] mount_root+0x5c/0x70
a0253bec:  [<a0001bc2>] prepare_namespace+0x22/0xf0
a0253c00:  [<a000c1d0>] init+0x0/0x180
a0253c04:  [<a000c1d0>] init+0x0/0x180
a0253c0c:  [<a000c2ec>] init+0x11c/0x180
a0253c28:  [<a0023a48>] run_kernel_thread+0x78/0xa0
a0253c38:  [<a000c1d0>] init+0x0/0x180
a0253c48:  [<a0023a10>] run_kernel_thread+0x40/0xa0
a0253cac:  [<a002ad87>] schedule_tail+0x27/0x1d0
a0253cd8:  [<a000c1d0>] init+0x0/0x180
a0253ce4:  [<a001a1de>] new_thread_handler+0xce/0x130
a0253ce8:  [<a000c1d0>] init+0x0/0x180
a0253d20:  [<a00e1f28>] __restore+0x0/0x8
a0253d60:  [<a00e20c1>] __kill+0x11/0x20


the panic is ok because  i didn`t supply anny params.


now comes the weird:

there is a new patch out which let's you use AoE for your root-device - =
just like NFS-root (which works inside UML).

The patch adds/changes just some lines in the AoE driver code and =
integrates into Kbuild.=20

If I set AoE-root(...)  to "yes" in .config compile goes fine again - =
but - the rather strange thing is, that i can`t even see the AoE driver =
initialize at all anymore.

The uml kernel get's stuck in the early beginning at boot time - look =
here:

# ./linux
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking PROT_EXEC mmap in /tmp...OK
Checking for the skas3 patch in the host:
  - /proc/mm...found
  - PTRACE_FAULTINFO...found
  - PTRACE_LDT...found
UML running in SKAS3 mode
---- hangs here forever. err - why that early ? -----


With a non UML kernel AoE and AoE root is working for me.

does anybody have a clue what is happening here ?

for those who want to take a closer look:

AoE driver is at:
http://www.coraid.com/support/linux/

AoE-root patch is at:
http://www.coraid.com/support/linux/contrib/

regards
roland

------=_NextPart_000_0006_01C62938.1EA428A0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2627" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello UML people, </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>unfortunately i wasn't into UML very =
much for the=20
last months - but from time to time i take a look how the project is =
going. it`s=20
nice to see that it's stell going on besides all of that virtualization=20
"madness" out there in&nbsp;IT.&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>i find UML very useful and this time =
gave it a try=20
for testing a driver - but </FONT><FONT face=3DArial size=3D2>=EC'm =
experience a=20
rather strange problem and cannot explain what`s happening here - maybe =
someone=20
can give me a hint how to dig into this.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>i try to use AoE (Ata over Ethernet) =
inside=20
UML.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>for those who don`t know about =
AoE:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>AoE is sort of iSCSI - but - without =
tcp/ip, just=20
on&nbsp;ethernet layer </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>a good introduction is at <A=20
href=3D"http://linuxdevices.com/news/NS3189760067.html">http://linuxdevic=
es.com/news/NS3189760067.html</A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>(btw: you don`t need to buy coraid's =
etherblade -=20
there are software versions for that "AoE server part" on the =
net)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I don`t know yet if i can use it inside =
UML without=20
problems at all - but - anyway what i'm experiencing is =
strange.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>i would have expected a different=20
behaviour.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I compiled an 2.6.15 vanilla kernel, =
manually=20
patched with aoe6-21 driver from coraid`s (AoE inventor) =
website.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>compile goes fine and i can start the =
kernel,=20
seeing the AoE driver initialize</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2># ./linux<BR>Checking that ptrace can =
change system=20
call numbers...OK<BR>Checking syscall emulation patch for=20
ptrace...missing<BR>Checking PROT_EXEC mmap in /tmp...OK<BR>Checking for =
the=20
skas3 patch in the host:<BR>&nbsp; - /proc/mm...found<BR>&nbsp; -=20
PTRACE_FAULTINFO...found<BR>&nbsp; - PTRACE_LDT...found<BR>UML running =
in SKAS3=20
mode<BR>Linux version 2.6.15 (<A =
href=3D"mailto:root@vmhost">root@vmhost</A>) (gcc=20
version 3.3.3 (SuSE Linux)) #4 Sat Feb 4 02:35:50 CET 2006<BR>Built 1=20
zonelists<BR>Kernel command line: root=3D98:0<BR>PID hash table entries: =
256=20
(order: 8, 4096 bytes)<BR>Dentry cache hash table entries: 8192 (order: =
3, 32768=20
bytes)<BR>Inode-cache hash table entries: 4096 (order: 2, 16384=20
bytes)<BR>Memory: 29824k available<BR>Mount-cache hash table entries:=20
512<BR>Checking for host processor cmov support...Yes<BR>Checking for =
host=20
processor xmm support...No<BR>Checking that host ptys support output=20
SIGIO...Yes<BR>Checking that host ptys support SIGIO on close...No, =
enabling=20
workaround<BR>Checking for /dev/anon on the host...Not available (open =
failed=20
with errno 2)<BR>Using 2.6 host AIO<BR>NET: Registered protocol family=20
16<BR>make_proc_exitcode : Failed to register /proc/exitcode<BR>io =
scheduler=20
noop registered<BR>loop: loaded (max 8 devices)</FONT></DIV><FONT =
face=3DArial=20
size=3D2>
<DIV><BR>aoe: aoe_init: AoE v21 initialised.&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &lt;- good - the AoE driver is initializing =
here<BR></DIV>
<DIV>NET: Registered protocol family 17<BR>Initialized stdio console=20
driver<BR>Console initialized on /dev/tty0<BR>Failed to open 'root_fs', =
errno =3D=20
2<BR>Kernel panic - not syncing: VFS: Unable to mount root fs on=20
unknown-block(98,0)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>EIP: 0073:[&lt;a00e20c1&gt;] CPU: 0 Not =
tainted=20
ESP: 007b:40001fb8 EFLAGS: 00000212<BR>&nbsp;&nbsp;&nbsp; Not =
tainted<BR>EAX:=20
00000000 EBX: 000023b1 ECX: 00000013 EDX: 000023b1<BR>ESI: 000023ae EDI: =

00000000 EBP: 00000000 DS: 007b ES: 007b<BR>a0253b60:&nbsp; =
[&lt;a003e2ad&gt;]=20
notifier_call_chain+0x2d/0x50<BR>a0253b7c:&nbsp; [&lt;a002e871&gt;]=20
panic+0x71/0x110<BR>a0253b94:&nbsp; [&lt;a0001ab8&gt;]=20
mount_block_root+0xc8/0x140<BR>a0253bd8:&nbsp; [&lt;a0001b8c&gt;]=20
mount_root+0x5c/0x70<BR>a0253bec:&nbsp; [&lt;a0001bc2&gt;]=20
prepare_namespace+0x22/0xf0<BR>a0253c00:&nbsp; [&lt;a000c1d0&gt;]=20
init+0x0/0x180<BR>a0253c04:&nbsp; [&lt;a000c1d0&gt;]=20
init+0x0/0x180<BR>a0253c0c:&nbsp; [&lt;a000c2ec&gt;]=20
init+0x11c/0x180<BR>a0253c28:&nbsp; [&lt;a0023a48&gt;]=20
run_kernel_thread+0x78/0xa0<BR>a0253c38:&nbsp; [&lt;a000c1d0&gt;]=20
init+0x0/0x180<BR>a0253c48:&nbsp; [&lt;a0023a10&gt;]=20
run_kernel_thread+0x40/0xa0<BR>a0253cac:&nbsp; [&lt;a002ad87&gt;]=20
schedule_tail+0x27/0x1d0<BR>a0253cd8:&nbsp; [&lt;a000c1d0&gt;]=20
init+0x0/0x180<BR>a0253ce4:&nbsp; [&lt;a001a1de&gt;]=20
new_thread_handler+0xce/0x130<BR>a0253ce8:&nbsp; [&lt;a000c1d0&gt;]=20
init+0x0/0x180<BR>a0253d20:&nbsp; [&lt;a00e1f28&gt;]=20
__restore+0x0/0x8<BR>a0253d60:&nbsp; [&lt;a00e20c1&gt;]=20
__kill+0x11/0x20</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>the panic is ok because&nbsp; i didn`t =
supply anny=20
params.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>now comes the weird:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>there is a new patch out which let's =
you use AoE=20
for your root-device - just like NFS-root (which works inside =
UML).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The patch adds/changes just some lines =
in the AoE=20
driver code and integrates into Kbuild. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If I set AoE-root(...) &nbsp;to "yes" =
in .config=20
</FONT><FONT face=3DArial size=3D2>compile goes fine again - but - the =
rather=20
strange thing is, that i can`t even see the AoE driver initialize at all =

anymore.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The uml kernel get's stuck in the early =
beginning=20
at boot time - look here:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2># ./linux<BR>Checking that ptrace can =
change system=20
call numbers...OK<BR>Checking syscall emulation patch for=20
ptrace...missing<BR>Checking PROT_EXEC mmap in /tmp...OK<BR>Checking for =
the=20
skas3 patch in the host:<BR>&nbsp; - /proc/mm...found<BR>&nbsp; -=20
PTRACE_FAULTINFO...found<BR>&nbsp; - PTRACE_LDT...found<BR>UML running =
in SKAS3=20
mode<BR>---- hangs here forever. err -&nbsp;why that early ? =
-----</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>With a non UML kernel AoE and AoE root =
is working=20
for me.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>does anybody have a clue what is =
happening here=20
?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>for those who want to take a closer=20
look:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>AoE driver is at:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://www.coraid.com/support/linux/">http://www.coraid.com/suppo=
rt/linux/</A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>AoE-root patch is at:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://www.coraid.com/support/linux/contrib/">http://www.coraid.c=
om/support/linux/contrib/</A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>roland</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0006_01C62938.1EA428A0--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
