Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eumdy-0006JG-Eo for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Jan 2006 00:08:14 -0800
Received: from nproxy.gmail.com ([64.233.182.206])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eumdx-0001JJ-65
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Jan 2006 00:08:14 -0800
Received: by nproxy.gmail.com with SMTP id p77so1295824nfc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 06 Jan 2006 00:08:11 -0800 (PST)
Message-ID: <39134b110601060008t28e1ff77q@mail.gmail.com>
From: wang lianwei <lianwei.wang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_32285_5682901.1136534890958"
Subject: [uml-devel] iomem mmaper problem
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
Date: Fri, 6 Jan 2006 16:08:10 +0800
To: user-mode-linux-devel@lists.sourceforge.net

------=_Part_32285_5682901.1136534890958
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,
    I test the uml kernel iomem functions, and found that if the iomem file
size is greater than 2M, the uml kernel will panic. the output is:


Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
Checking PROT_EXEC mmap in /tmp...OK
 tracing thread pid =3D 9425
Linux version 2.6.10 ( lianwei.wang@gmail.com) (gcc version 3.4.3 ) #202 Th=
u
Jan 5 15:02:27 CST 2006
Built 1 zonelists
Kernel command line:
ubd0=3D/users/lianwei/work/uml_linux//temp_COW,/users/lianwei/w
ork/uml_linux//rootfs_x86.um eth0=3Dtuntap,,, 192.168.0.100 iomem=3Dmmapper
iomem=3D
testmem video=3Dvfb: mem=3D128M root=3D98:0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 126336k available
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Kernel panic - not syncing: Segfault with no mm

EIP: 0073:[<a0037c61>] CPU: 0 Not tainted ESP: 007b:a022be54 EFLAGS:
00010292
    Not tainted
EAX: a0904148 EBX: a022bebc ECX: a022bde4 EDX: ffffffff
ESI: 00000001 EDI: 00000001 EBP: a022be7c DS: 007b ES: 007b
Call Trace:
 [<a004b6d5>] notifier_call_chain+0x25/0x40
 [<a003aa32>] panic+0x72/0x110
 [<a001d051>] segv+0x1d1/0x220
 [<a01984f7>] sigemptyset+0x17/0x30
 [<a001ad90>] change_signals+0x60/0x90
 [<a001d3a5>] segv_handler+0x115/0x260
 [<a0037c61>] __wake_up_common+0x11/0x70
 [<a0021977>] sig_handler_common_tt+0x97/0x140
 [<a001d531>] sig_handler+0x21/0x40
 [<a01981f8>] __restore+0x0/0x8
 [<a0037c61>] __wake_up_common+0x11/0x70
 [<a0037d06>] __wake_up+0x46/0x60
 [<a0053237>] __wake_up_bit+0x37/0x40
 [<a00a7b13>] proc_get_inode+0xe3/0x130
 [<a00a7ba5>] proc_fill_super+0x45/0xb0
 [<a0080272>] get_sb_single+0x62/0xc0
 [<a008032a>] do_kern_mount+0x5a/0xf0
 [<a00a7b60>] proc_fill_super+0x0/0xb0
 [<a0020ff0>] signal_tramp+0x0/0x110
 [<a00803e3>] kern_mount+0x23/0x25
 [<a0020ff0>] signal_tramp+0x0/0x110
 [<a000c8bd>] proc_root_init+0x2d/0x130
 [<a0002629>] start_kernel+0x159/0x1a0
 [<a0002180>] unknown_bootoption+0x0/0x220
 [<a001fcc8>] start_kernel_proc+0x48/0x80
 [<a00024d0>] start_kernel+0x0/0x1a0

did anyone have ever seen this problem?

my uml version is 2.6.10

thanks.

------=_Part_32285_5682901.1136534890958
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>hi,</div>
<div>&nbsp;&nbsp;&nbsp; I test the uml kernel iomem functions, and found th=
at if the iomem file size is greater than 2M, the uml kernel will panic. th=
e output is:</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Checking for the skas3 patch in the host...not found<br>Checking for /=
proc/mm...not found<br>Checking PROT_EXEC mmap in /tmp...OK<br>&nbsp;tracin=
g thread pid =3D 9425<br>Linux version 2.6.10 (<a onclick=3D"return top.js.=
OpenExtLink(window,event,this)" href=3D"mailto:lianwei.wang@gmail.com" targ=
et=3D"_blank">
 lianwei.wang@gmail.com</a>) (gcc version 3.4.3 ) #202 Thu Jan 5 15:02:27 C=
ST 2006<br>Built 1 zonelists<br>Kernel command line: ubd0=3D/users/lianwei/=
work/uml_linux//temp_COW,/users/lianwei/w<br>ork/uml_linux//rootfs_x86.um e=
th0=3Dtuntap,,,=20
<a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"http://=
192.168.0.100/" target=3D"_blank">192.168.0.100</a> iomem=3Dmmapper iomem=
=3D<br>testmem video=3Dvfb: mem=3D128M root=3D98:0<br>PID hash table entrie=
s: 1024 (order: 10, 16384 bytes)
<br>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes) <br>Ino=
de-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>Memory: 12633=
6k available<br>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<br>Kernel panic - not syncing: Segfault with no mm<br>&nbsp;<br>EIP: 0073:=
[&lt;a0037c61&gt;] CPU: 0 Not tainted ESP: 007b:a022be54 EFLAGS: 00010292 <=
br>&nbsp;&nbsp;&nbsp; Not tainted<br>EAX: a0904148 EBX: a022bebc ECX: a022b=
de4 EDX: ffffffff
<br>ESI: 00000001 EDI: 00000001 EBP: a022be7c DS: 007b ES: 007b<br>Call Tra=
ce: <br>&nbsp;[&lt;a004b6d5&gt;] notifier_call_chain+0x25/0x40<br>&nbsp;[&l=
t;a003aa32&gt;] panic+0x72/0x110 <br>&nbsp;[&lt;a001d051&gt;] segv+0x1d1/0x=
220<br>&nbsp;[&lt;a01984f7&gt;] sigemptyset+0x17/0x30
<br>&nbsp;[&lt;a001ad90&gt;] change_signals+0x60/0x90<br>&nbsp;[&lt;a001d3a=
5&gt;] segv_handler+0x115/0x260<br>&nbsp;[&lt;a0037c61&gt;] __wake_up_commo=
n+0x11/0x70 <br>&nbsp;[&lt;a0021977&gt;] sig_handler_common_tt+0x97/0x140<b=
r>&nbsp;[&lt;a001d531&gt;] sig_handler+0x21/0x40
<br>&nbsp;[&lt;a01981f8&gt;] __restore+0x0/0x8<br>&nbsp;[&lt;a0037c61&gt;] =
__wake_up_common+0x11/0x70<br>&nbsp;[&lt;a0037d06&gt;] __wake_up+0x46/0x60<=
span></span> <br>&nbsp;[&lt;a0053237&gt;] __wake_up_bit+0x37/0x40<br>&nbsp;=
[&lt;a00a7b13&gt;] proc_get_inode+0xe3/0x130
<br>&nbsp;[&lt;a00a7ba5&gt;] proc_fill_super+0x45/0xb0<br>&nbsp;[&lt;a00802=
72&gt;] get_sb_single+0x62/0xc0<br>&nbsp;[&lt;a008032a&gt;] do_kern_mount+0=
x5a/0xf0 <br>&nbsp;[&lt;a00a7b60&gt;] proc_fill_super+0x0/0xb0<br>&nbsp;[&l=
t;a0020ff0&gt;] signal_tramp+0x0/0x110
<br>&nbsp;[&lt;a00803e3&gt;] kern_mount+0x23/0x25<br>&nbsp;[&lt;a0020ff0&gt=
;] signal_tramp+0x0/0x110<br>&nbsp;[&lt;a000c8bd&gt;] proc_root_init+0x2d/0=
x130 <br>&nbsp;[&lt;a0002629&gt;] start_kernel+0x159/0x1a0<br>&nbsp;[&lt;a0=
002180&gt;] unknown_bootoption+0x0/0x220
<br>&nbsp;[&lt;a001fcc8&gt;] start_kernel_proc+0x48/0x80<br>&nbsp;[&lt;a000=
24d0&gt;] start_kernel+0x0/0x1a0<br>&nbsp;</div>
<div>did anyone have ever seen this problem?</div>
<div>&nbsp;</div>
<div>my uml version is 2.6.10</div>
<div>&nbsp;</div>
<div>thanks.</div>

------=_Part_32285_5682901.1136534890958--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
