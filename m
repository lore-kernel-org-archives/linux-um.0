Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IYptl-0001zD-JC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Sep 2007 14:18:53 -0700
Received: from is1.enterasys.com ([63.160.138.53])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IYptj-0007b7-TW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Sep 2007 14:18:53 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 21 Sep 2007 17:18:11 -0400
Message-ID: <5A9C383ECECEEE4F82BD5E7DCCD318E9C570CC@MABOSEVS1.ets.enterasys.com>
From: "Bradshaw, James" <jbradsha@enterasys.com>
Subject: [uml-devel] sigwinch in 2.6.14.7 UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1802774809=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1802774809==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7FC94.EA3E1475"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7FC94.EA3E1475
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sigwinch appears to trigger a panic in 2.6.14.7. Here's the GDB
backtrace

=20

#0  0xffffe410 in ?? ()

#1  0x0806d53d in stop () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/os-Linux/t
t.c:67

#2  0x0805dd98 in panic_waitonerr (self=3D0x82394e8, unused1=3D0,
unused2=3D0x82716c0) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/um_
arch.c:523

#3  0x0808655a in notifier_call_chain (n=3D0xfffffdfc, val=3D0, =
v=3D0x82375c0)
at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/kernel/sys.c:179

#4  0x0807803c in panic (fmt=3D0x81f6bdc "BUG!") at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/kernel/panic.c:97

#5  0x08096201 in ack_none (irq=3D10) at hardirq.h:22

#6  0x080962e0 in __do_IRQ (irq=3D136541632, regs=3D0x8238fcc) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/kernel/irq/handle.
c:134

#7  0x0805948f in do_IRQ (irq=3D-516, regs=3D0xa34ff4) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/irq
.c:374

#8  0x0805d60e in winch (sig=3D28, regs=3D0x8238fcc) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/tra
p.c:246

#9  0x080709a6 in sig_handler_common_skas (sig=3D28, sc_ptr=3D0x805d600) =
at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/os-Linux/s
kas/trap.c:52

#10 0x0806cb27 in sig_handler (sig=3D28) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/os-Linux/s
ignal.c:61

#11 <signal handler called>

#12 0x0804f7c6 in __alloc_bootmem_core (bdata=3D0x823eec0, =
size=3D6291488,
align=3D32, goal=3D151089152, limit=3D136541632) at string.h:373

#13 0x0804fd95 in __alloc_bootmem_node_limit (pgdat=3D0x0, =
size=3D6291488,
align=3D32, goal=3D0, limit=3D0) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/mm/bootmem.c:418

#14 0x0805035b in alloc_node_mem_map (pgdat=3D0x823eec0) at =
bootmem.h:134

#15 0x080503af in free_area_init_node (nid=3D0, pgdat=3D0x823eec0,
zones_size=3D0x8237bd0, node_start_pfn=3D0, zholes_size=3D0x0) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/mm/page_alloc.c:20
07

#16 0x080503d7 in free_area_init (zones_size=3D0x8237bd0) at mem.h:19

#17 0x0805972f in paging_init () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/mem
.c:228

#18 0x0804d245 in setup_arch (cmdline_p=3D0x0) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/um_
arch.c:555

#19 0x08049481 in start_kernel () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/init/main.c:464

#20 0x0805e55a in start_kernel_proc (unused=3D0x0) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/ska
s/process_kern.c:173

#21 0x0806c148 in run_kernel_thread (fn=3D0x805e530 <start_kernel_proc>,
arg=3D0x0, jmp_ptr=3D0x8234000) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/os-Linux/p
rocess.c:285

#22 0x0805e24c in new_thread_handler (sig=3D10) at thread_info.h:49

#23 <signal handler called>

#24 0xffffe410 in ?? ()

(gdb)

=20

Control ends up in ack_bad_irq() in asm-um/hardirq.h:

=20

static inline void ack_bad_irq(unsigned int irq)

{

                printk(KERN_ERR "unexpected IRQ %02x\n", irq);

                BUG();

}

=20

Did the correct handler fail to get assigned, or should sigwinch have
been blocked?

=20

James T. Bradshaw

Firmware Engineer

Enterasys Networks

50 Minuteman Rd.

Andover, MA 01810

USA

Tel. (978) 684-1544=20


------_=_NextPart_001_01C7FC94.EA3E1475
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

<p class=3DMsoNormal>Sigwinch appears to trigger a panic in 2.6.14.7. =
Here&#8217;s
the GDB backtrace<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>#0&nbsp; 0xffffe410 in ?? ()<o:p></o:p></p>

<p class=3DMsoNormal>#1&nbsp; 0x0806d53d in stop () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/os-Linux/tt=
.c:67<o:p></o:p></p>

<p class=3DMsoNormal>#2&nbsp; 0x0805dd98 in panic_waitonerr =
(self=3D0x82394e8,
unused1=3D0, unused2=3D0x82716c0) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/um_a=
rch.c:523<o:p></o:p></p>

<p class=3DMsoNormal>#3&nbsp; 0x0808655a in notifier_call_chain =
(n=3D0xfffffdfc,
val=3D0, v=3D0x82375c0) at =
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/kernel/sys.c:179<o:=
p></o:p></p>

<p class=3DMsoNormal>#4&nbsp; 0x0807803c in panic (fmt=3D0x81f6bdc
&quot;BUG!&quot;) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/kernel/panic.c:97<o=
:p></o:p></p>

<p class=3DMsoNormal>#5&nbsp; 0x08096201 in ack_none (irq=3D10) at =
hardirq.h:22<o:p></o:p></p>

<p class=3DMsoNormal>#6&nbsp; 0x080962e0 in __do_IRQ (irq=3D136541632,
regs=3D0x8238fcc) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/kernel/irq/handle.c=
:134<o:p></o:p></p>

<p class=3DMsoNormal>#7&nbsp; 0x0805948f in do_IRQ (irq=3D-516, =
regs=3D0xa34ff4) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/irq.=
c:374<o:p></o:p></p>

<p class=3DMsoNormal>#8&nbsp; 0x0805d60e in winch (sig=3D28, =
regs=3D0x8238fcc) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/trap=
.c:246<o:p></o:p></p>

<p class=3DMsoNormal>#9&nbsp; 0x080709a6 in sig_handler_common_skas =
(sig=3D28,
sc_ptr=3D0x805d600) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/os-Linux/sk=
as/trap.c:52<o:p></o:p></p>

<p class=3DMsoNormal>#10 0x0806cb27 in sig_handler (sig=3D28) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/os-Linux/si=
gnal.c:61<o:p></o:p></p>

<p class=3DMsoNormal>#11 &lt;signal handler called&gt;<o:p></o:p></p>

<p class=3DMsoNormal>#12 0x0804f7c6 in __alloc_bootmem_core =
(bdata=3D0x823eec0,
size=3D6291488, align=3D32, goal=3D151089152, limit=3D136541632) at =
string.h:373<o:p></o:p></p>

<p class=3DMsoNormal>#13 0x0804fd95 in __alloc_bootmem_node_limit =
(pgdat=3D0x0,
size=3D6291488, align=3D32, goal=3D0, limit=3D0) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/mm/bootmem.c:418<o:=
p></o:p></p>

<p class=3DMsoNormal>#14 0x0805035b in alloc_node_mem_map =
(pgdat=3D0x823eec0) at
bootmem.h:134<o:p></o:p></p>

<p class=3DMsoNormal>#15 0x080503af in free_area_init_node (nid=3D0,
pgdat=3D0x823eec0, zones_size=3D0x8237bd0, node_start_pfn=3D0, =
zholes_size=3D0x0) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/mm/page_alloc.c:200=
7<o:p></o:p></p>

<p class=3DMsoNormal>#16 0x080503d7 in free_area_init =
(zones_size=3D0x8237bd0) at
mem.h:19<o:p></o:p></p>

<p class=3DMsoNormal>#17 0x0805972f in paging_init () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/mem.=
c:228<o:p></o:p></p>

<p class=3DMsoNormal>#18 0x0804d245 in setup_arch (cmdline_p=3D0x0) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/um_a=
rch.c:555<o:p></o:p></p>

<p class=3DMsoNormal>#19 0x08049481 in start_kernel () at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/init/main.c:464<o:p=
></o:p></p>

<p class=3DMsoNormal>#20 0x0805e55a in start_kernel_proc (unused=3D0x0) =
at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/kernel/skas=
/process_kern.c:173<o:p></o:p></p>

<p class=3DMsoNormal>#21 0x0806c148 in run_kernel_thread (fn=3D0x805e530
&lt;start_kernel_proc&gt;, arg=3D0x0, jmp_ptr=3D0x8234000) at
/ccase/wrlinux/build/mxs_cm_t0/build/linux-2.6.14-cgl/arch/um/os-Linux/pr=
ocess.c:285<o:p></o:p></p>

<p class=3DMsoNormal>#22 0x0805e24c in new_thread_handler (sig=3D10) at
thread_info.h:49<o:p></o:p></p>

<p class=3DMsoNormal>#23 &lt;signal handler called&gt;<o:p></o:p></p>

<p class=3DMsoNormal>#24 0xffffe410 in ?? ()<o:p></o:p></p>

<p class=3DMsoNormal>(gdb)<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Control ends up in ack_bad_irq() in =
asm-um/hardirq.h:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>static inline void ack_bad_irq(unsigned int =
irq)<o:p></o:p></p>

<p class=3DMsoNormal>{<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR
&quot;unexpected IRQ %02x\n&quot;, irq);<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<o:p></o:p></p>

<p class=3DMsoNormal>}<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Did the correct handler fail to get assigned, or =
should
sigwinch have been blocked?<o:p></o:p></p>

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

------_=_NextPart_001_01C7FC94.EA3E1475--



--===============1802774809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1802774809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1802774809==--


