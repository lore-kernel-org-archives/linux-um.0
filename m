Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mark.kica@gmail.com>) id 1bKl3B-0004Sb-OC
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 11:31:29 +0000
Received: from mail-oi0-f66.google.com ([209.85.218.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bKl3A-0002wz-KB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 11:31:29 +0000
Received: by mail-oi0-f66.google.com with SMTP id x6so31780379oif.3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 06 Jul 2016 04:31:28 -0700 (PDT)
MIME-Version: 1.0
From: Mark Kica <mark.kica@gmail.com>
Date: Wed, 6 Jul 2016 13:31:22 +0200
Message-ID: <CAA7wQYzGEDkqGph5-ruMYmAmpBy9+pqELk5JbNze8y3AyQW0yg@mail.gmail.com>
Subject: [uml-devel] How to properly load debug symbols for module and set
	breakpoint
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4413583576614879970=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============4413583576614879970==
Content-Type: multipart/alternative; boundary=001a113d40beba8c8f0536f5e870

--001a113d40beba8c8f0536f5e870
Content-Type: text/plain; charset=UTF-8

I have build custom 64bit UML Linux kernel with TUN/TAP kernel module
(tun.ko) and then I have installed it on small root filesystem with busybox
. These module and kernel seems to work and I would like to make simple
changes in TUN module and measure it's performance .

So I have tried to follow guide from
http://user-mode-linux.sourceforge.net/hacking.html which explains how to
attach gdb to UML and set breakpoint for module init function .

(gdb) p modules
$1 = {next = 0x6385cf38, prev = 0x6385cf38}

(gdb) p *((struct module *)0x6385cf30)
$2 = {state = MODULE_STATE_LIVE, list = {next = 0x6036aee0, prev =
0x6036aee0}, name = "tun", '\000' <repeats 52 times>, mkobj = {kobj =
{name = 0x62e95b00 "tun", entry = {next = 0x62c30440, prev =
0x62c30148}, parent = 0x62c30450,
kset = 0x62c30440, ktype = 0x603694d0, sd = 0x62dd6fa0, kref =
{refcount = {counter = 3}}, state_initialized = 1, state_in_sysfs = 1,
state_add_uevent_sent = 1, state_remove_uevent_sent = 0,
uevent_suppress = 0},
mod = 0x6385cf30, drivers_dir = 0x0, mp = 0x0}, modinfo_attrs =
0x62ea0400, version = 0x0, srcversion = 0x0, holders_dir = 0x62da7400,
syms = 0x0, crcs = 0x0, num_syms = 0, kp = 0x0, num_kp = 0,
num_gpl_syms = 1,
gpl_syms = 0x6385c260, gpl_crcs = 0x0, gpl_future_syms = 0x0,
gpl_future_crcs = 0x0, num_gpl_future_syms = 0, num_exentries = 0,
extable = 0x0, init = 0x63860000, module_init = 0x0, module_core =
0x6385a000, init_size = 0,
core_size = 13990, init_text_size = 0, core_text_size = 8244,
init_ro_size = 127, core_ro_size = 11432, arch = {<No data fields>},
taints = 0, num_bugs = 0, bug_list = {next = 0x60376a40, prev =
0x60376a40}, bug_table = 0x0,
symtab = 0x6385d120, core_symtab = 0x6385d120, num_symtab = 37,
core_num_syms = 37, strtab = 0x6385d498 "", core_strtab = 0x6385d498
"", sect_attrs = 0x62c52000, notes_attrs = 0x62e98240, args =
0x62e95b20 " ", source_list = {
next = 0x6385d0e0, prev = 0x6385d0e0}, target_list = {next =
0x6385d0f0, prev = 0x6385d0f0}, waiter = 0x62ea10c0, exit =
0x6385a101, refptr = 0x62176ca0}

(gdb) add-symbol-file
/home/mark/playground/linux-2.6.39.3/drivers/net/tun.ko 0x6385a000
add symbol table from file
"/home/mark/playground/linux-2.6.39.3/drivers/net/tun.ko" at
.text_addr = 0x6385a000
(y or n)
Please answer y or n.
(y or n) y
Reading symbols from
/home/mark/playground/linux-2.6.39.3/drivers/net/tun.ko...done.

(gdb) p tun_init
$3 = {int (void)} 0x24 <tun_init>


(gdb) break tun_init
Cannot access memory at address 0x24



I don't understand why tun_init is located at 0x24 and not at 0x6385a000 ?
Can somebody point what I am doing wrong and how to load debug symbols and
set breakpoint ?

--001a113d40beba8c8f0536f5e870
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have build custom 64bit UML Linux kernel with TUN/TAP ke=
rnel module=20
(tun.ko) and then I have installed it on small root filesystem with=20
busybox .
These module and kernel seems to work and I would like to make simple=20
changes
in TUN module and measure it&#39;s performance .

<p>So I have tried to follow guide from <a href=3D"http://user-mode-linux.s=
ourceforge.net/hacking.html" rel=3D"nofollow" target=3D"_blank">http://user=
-mode-linux.sourceforge.net/hacking.html</a> which explains how to attach g=
db to UML and set breakpoint for
module init function .<br><br></p>

<pre><code>(gdb) p modules
$1 =3D {next =3D 0x6385cf38, prev =3D 0x6385cf38}

(gdb) p *((struct module *)0x6385cf30)
$2 =3D {state =3D MODULE_STATE_LIVE, list =3D {next =3D 0x6036aee0, prev =
=3D 0x6036aee0}, name =3D &quot;tun&quot;, &#39;\000&#39; &lt;repeats 52 ti=
mes&gt;, mkobj =3D {kobj =3D {name =3D 0x62e95b00 &quot;tun&quot;, entry =
=3D {next =3D 0x62c30440, prev =3D 0x62c30148}, parent =3D 0x62c30450,
kset =3D 0x62c30440, ktype =3D 0x603694d0, sd =3D 0x62dd6fa0, kref =3D {ref=
count =3D {counter =3D 3}}, state_initialized =3D 1, state_in_sysfs =3D 1, =
state_add_uevent_sent =3D 1, state_remove_uevent_sent =3D 0, uevent_suppres=
s =3D 0},
mod =3D 0x6385cf30, drivers_dir =3D 0x0, mp =3D 0x0}, modinfo_attrs =3D 0x6=
2ea0400, version =3D 0x0, srcversion =3D 0x0, holders_dir =3D 0x62da7400, s=
yms =3D 0x0, crcs =3D 0x0, num_syms =3D 0, kp =3D 0x0, num_kp =3D 0, num_gp=
l_syms =3D 1,
gpl_syms =3D 0x6385c260, gpl_crcs =3D 0x0, gpl_future_syms =3D 0x0, gpl_fut=
ure_crcs =3D 0x0, num_gpl_future_syms =3D 0, num_exentries =3D 0, extable =
=3D 0x0, init =3D 0x63860000, module_init =3D 0x0, module_core =3D 0x6385a0=
00, init_size =3D 0,
core_size =3D 13990, init_text_size =3D 0, core_text_size =3D 8244, init_ro=
_size =3D 127, core_ro_size =3D 11432, arch =3D {&lt;No data fields&gt;}, t=
aints =3D 0, num_bugs =3D 0, bug_list =3D {next =3D 0x60376a40, prev =3D 0x=
60376a40}, bug_table =3D 0x0,
symtab =3D 0x6385d120, core_symtab =3D 0x6385d120, num_symtab =3D 37, core_=
num_syms =3D 37, strtab =3D 0x6385d498 &quot;&quot;, core_strtab =3D 0x6385=
d498 &quot;&quot;, sect_attrs =3D 0x62c52000, notes_attrs =3D 0x62e98240, a=
rgs =3D 0x62e95b20 &quot; &quot;, source_list =3D {
next =3D 0x6385d0e0, prev =3D 0x6385d0e0}, target_list =3D {next =3D 0x6385=
d0f0, prev =3D 0x6385d0f0}, waiter =3D 0x62ea10c0, exit =3D 0x6385a101, ref=
ptr =3D 0x62176ca0}

(gdb) add-symbol-file /home/mark/playground/linux-2.6.39.3/drivers/net/tun.=
ko 0x6385a000
add symbol table from file &quot;/home/mark/playground/linux-2.6.39.3/drive=
rs/net/tun.ko&quot; at
.text_addr =3D 0x6385a000
(y or n)
Please answer y or n.
(y or n) y
Reading symbols from /home/mark/playground/linux-2.6.39.3/drivers/net/tun.k=
o...done.

(gdb) p tun_init
$3 =3D {int (void)} 0x24 &lt;tun_init&gt;


(gdb) break tun_init
Cannot access memory at address 0x24
</code></pre>

<p><br><br>
I don&#39;t understand why tun_init is located at 0x24 and not at 0x6385a00=
0 ?=20
Can somebody point what I am doing wrong and how to load debug symbols and =
set breakpoint ? </p></div>

--001a113d40beba8c8f0536f5e870--


--===============4413583576614879970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
--===============4413583576614879970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============4413583576614879970==--


