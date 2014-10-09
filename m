Return-Path: <Vineet.Gupta1@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Thu, 9 Oct 2014 10:35:34 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230753C5E5304@IN01WEMBXA.internal.synopsys.com>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-9-git-send-email-linux@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [PATCH 08/44] kernel: Move pm_power_off to common code
To: Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lguest@lists.ozlabs.org" <lguest@lists.ozlabs.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>, "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, "Ivan Kokshaysky  <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta" <Vineet.Gupta1@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, "Will Deacon  <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt" <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, "Geert Uytterhoeven  <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek" <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, "Koichi Yasutake  <yasutake.koichi@jp.panasonic.com>, Jonas Bonn" <jonas@southpole.se>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "Helge Deller  <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras" <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Boris Ostrovsky  <boris.ostrovsky@oracle.com>, David Vrabel" <david.vrabel@citrix.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tuesday 07 October 2014 11:01 AM, Guenter Roeck wrote:

diff --git a/arch/arc/kernel/reset.c b/arch/arc/kernel/reset.c
index 2768fa1..8a4fc47 100644
--- a/arch/arc/kernel/reset.c
+++ b/arch/arc/kernel/reset.c
@@ -26,9 +26,6 @@ void machine_restart(char *__unused)

 void machine_power_off(void)
 {
-       /* FIXME ::  power off ??? */
+       do_kernel_poweroff();
        machine_halt();
 }
-
-void (*pm_power_off) (void) =3D NULL;
-EXPORT_SYMBOL(pm_power_off);

Acked-by: Vineet Gupta <vgupta@synopsys.com><mailto:vgupta@synopsys.com>

Thx,
-Vineet

