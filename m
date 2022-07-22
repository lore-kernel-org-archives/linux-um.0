Return-Path: <helgaas@kernel.org>
Date: Fri, 22 Jul 2022 17:31:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v5 4/4] asm-generic: Add new pci.h and use it
Message-ID: <20220722223146.GA1947394@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtsaA2Zjqa/XZZou@antec>
To: Stafford Horne <shorne@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, Pierre Morel <pmorel@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Sat, Jul 23, 2022 at 06:43:31AM +0900, Stafford Horne wrote:

> I will respin a v6 as we didn't get a reply on this.  Bjorn are you
> planning to apply the series before the upcoming merge window?

I see your v6, and I can apply it.  I only got patches 1, 2, 4
(without the csky patch).  Do you want that to go a separate route?  I
don't care either way, but not sure it improves things to split it
across trees.

Bjorn

