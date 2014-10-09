Return-Path: <linux-sh-owner@vger.kernel.org>
Date: Thu, 9 Oct 2014 11:49:27 +0100
From: Lee Jones <lee.jones@linaro.org>
Message-ID: <20141009104927.GN20647@lee--X1>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-13-git-send-email-linux@roeck-us.net>
 <20141007080048.GB25331@lee--X1>
 <20141009103656.GF17836@e104818-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20141009103656.GF17836@e104818-lin.cambridge.arm.com>
Sender: linux-sh-owner@vger.kernel.org
Subject: Re: [PATCH 12/44] mfd: ab8500-sysctrl: Register with kernel poweroff
 handler
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Linus Walleij <linus.walleij@linaro.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "lguest@lists.ozlabs.org" <lguest@lists.ozlabs.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>, "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 09 Oct 2014, Catalin Marinas wrote:

> On Tue, Oct 07, 2014 at 09:00:48AM +0100, Lee Jones wrote:
> > On Mon, 06 Oct 2014, Guenter Roeck wrote:
> > > --- a/drivers/mfd/ab8500-sysctrl.c
> > > +++ b/drivers/mfd/ab8500-sysctrl.c
> > > @@ -6,6 +6,7 @@
> >=20
> > [...]
> >=20
> > > +static int ab8500_power_off(struct notifier_block *this, unsigne=
d long unused1,
> > > +			    void *unused2)
> > >  {
> > >  	sigset_t old;
> > >  	sigset_t all;
> > > @@ -34,11 +36,6 @@ static void ab8500_power_off(void)
> > >  	struct power_supply *psy;
> > >  	int ret;
> > > =20
> > > -	if (sysctrl_dev =3D=3D NULL) {
> > > -		pr_err("%s: sysctrl not initialized\n", __func__);
> > > -		return;
> > > -	}
> >=20
> > Can you explain the purpose of this change please?
>=20
> I guess it's because the sysctrl_dev is already initialised when
> registering the power_off handler, so there isn't a way to call the
> above function with a NULL sysctrl_dev. Probably even with the origin=
al
> code you didn't need this check (after some race fix in
> ab8500_sysctrl_remove but races is one of the things Guenter's patche=
s
> try to address).

Sounds reasonable, although I think this change should be part of
another patch.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
