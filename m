Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuvXq-00036b-Jv for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 07:29:26 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AuvGF-0006co-Cw for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 07:11:15 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200402221604.19495.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Fwd: [uml-user] Host 2.6.2/3 + CFQ + BlaisorBlade patches
	== host panic
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
Date: Sun, 22 Feb 2004 16:04:19 +0100
Content-Transfer-Encoding: quoted-printable
To: Ingo Molnar <mingo@elte.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi Ingo, could you please take a look at this report? With CONFIG_SMP enabl=
ed=20
and the skas patch applied (last version, which includes all your changes) =

the kernel is BUGging during switch_mm.

I've looked at include/asm-i386/mmu_context.h and I saw this code:

#ifdef CONFIG_SMP
        else {
                cpu_tlbstate[cpu].state =3D TLBSTATE_OK;
                BUG_ON(cpu_tlbstate[cpu].active_mm !=3D next); /*!!!!This i=
s the=20
bug you hit*/
...

The kernel is complaining because prev =3D=3D next but prev !=3D=20
cpu_tlbstate[cpu].active_mm. switch_mm is called in schedule.c (looking at =

the EIP value below, which is inside schedule()) and its params are actuall=
y=20
prev->active_mm and next->mm. So it BUGged because prev->active_mm was fals=
e,=20
or because prev was not running when it was scheduled away (or was running =

onto another CPU). However I cannot understand anything more

Maybe prev->active_mm had just been changed by ptrace but=20
cpu_tlbstate[cpu].active_mm had not been updated? I.e. the "child" task in =

ptrace had not been re-scheduled in - was it maybe running somewhere else?

----------  Forwarded message  ----------

Subject: [uml-user] Host 2.6.2/3 + CFQ + BlaisorBlade patches =3D=3D host p=
anic
Date: 22:04, venerd=EC 20 febbraio 2004
From: "Christopher S. Aker" <caker@theshore.net>
To: <user-mode-linux-user@lists.sourceforge.net>
Cc: "BlaisorBlade" <blaisorblade_spam@yahoo.it>

Hello,

I've been testing 2.6 and SKAS and receive the following BUG on both 2.6.2
 and 2.6.3.  Patches applied are (in order):

*
http://www.user-mode-linux.org/~blaisorblade/patches/2.6.2-v1/uml-patch-2.6=
.2
-0.bz2 *
 http://www.user-mode-linux.org/~blaisorblade/patches/2.6.2-v1/00-Combo-v1.=
bz
2 *
http://www.user-mode-linux.org/~blaisorblade/patches/2.6.2-v1-host-skas2/00=
-2
.6.2-v1-host-SKAS2.patch.bz2 * the CFQ patch from the -mm tree
* patch-2.6.3 (only on the 2.6.3 kernel, obviously)

kernel BUG at include/asm/mmu_context.h:53!
invalid operand: 0000 [#1]
CPU:    2
EIP:    0060:[<c011dff1>]    Not tainted
EFLAGS: 00010083
EIP is at schedule+0x53e/0x6c5
eax: 00000100   ebx: f57e0d00   ecx: 00000002   edx: f57e0d00
esi: f640c6b0   edi: c3da1c80   ebp: f7f97f78   esp: f7f97f24
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=3Df7f96000 task=3Df7f9ece0)
Stack: f640c6b0 3ee9c9d5 00000185 f7f97f30 e3cd6000 00000200 00000001
 c0451b88 f640c6b0 3ee9c9d5 00000185 f640c6b0 c3da1c80 0001ab57 3ee9cded
 00000185 f7f9ece0 f7f9eeac f7f96000 f7f96000 c010882e f7f96000 c010ac89
 f7f96000 Call Trace:
 [<c010882e>] default_idle+0x0/0x2d
 [<c010ac89>] need_resched+0x27/0x32
 [<c010882e>] default_idle+0x0/0x2d
 [<c0108858>] default_idle+0x2a/0x2d
 [<c01088cc>] cpu_idle+0x37/0x40
 [<c012314e>] printk+0x188/0x1d0
 [<c045c51d>] print_cpu_info+0x86/0xd2

Code: 0f 0b 35 00 34 3a 3a c0 eb c5 89 5e 6c f0 ff 43 18 b8 00 e0

Does this look like it could be caused by the SKAS patches, or would you
 suspect the CFQ patch?  The box seems to run fine, but once I fire up a few
 UMLs and start banging around, the host will BUG.

Thanks,
-Chris

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
