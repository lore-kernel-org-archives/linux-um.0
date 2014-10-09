Return-Path: <linux@roeck-us.net>
Message-ID: <54368CC9.7020100@roeck-us.net>
Date: Thu, 09 Oct 2014 06:25:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>	<1412659726-29957-2-git-send-email-linux@roeck-us.net> <CAMuHMdVOBnZ=pyVeGSxbOT9MtRR2iNY4V-PUm0NU=UFQ2pxE_g@mail.gmail.com>
In-Reply-To: <CAMuHMdVOBnZ=pyVeGSxbOT9MtRR2iNY4V-PUm0NU=UFQ2pxE_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/44] kernel: Add support for poweroff handler call chain
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, driverdevel <devel@driverdev.osuosl.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, lguest@lists.ozlabs.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>, Cris <linux-cris-kernel@axis.com>, linux-efi@vger.kernel.org, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-m32r-ja@ml.linux-m32r.org, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-tegra@vger.kernel.org, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, openipmi-developer@lists.sourceforge.net, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, METAG ARCHITECTURE <linux-metag@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, Heiko Stuebner <heiko@sntech.de>, Romain Perier <romain.perier@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Alexander Graf <agraf@suse.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 10/09/2014 04:31 AM, Geert Uytterhoeven wrote:
> On Tue, Oct 7, 2014 at 7:28 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> +int register_poweroff_handler_simple(void (*handler)(void), int priority)
>> +{
>> +       char symname[KSYM_NAME_LEN];
>> +
>> +       if (poweroff_handler_data.handler) {
>> +               lookup_symbol_name((unsigned long)poweroff_handler_data.handler,
>> +                                  symname);
>> +               pr_warn("Poweroff function already registered (%s)", symname);
>> +               lookup_symbol_name((unsigned long)handler, symname);
>> +               pr_cont(", cannot register %s\n", symname);
>
> Doesn't %ps work to look up symbols?
>
> pr_warn("Poweroff function already registered (%ps), cannot register
> %ps\n", poweroff_handler_data.handler, handler);
>

Hi Geert,

That is great. One never stops learning. I'll use that.

Thanks!

Guenter


