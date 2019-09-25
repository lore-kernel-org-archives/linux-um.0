Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
 <CAOMZO5A_U4aYC4XZXK1r9JaLg-eRdXy8m6z4GatQp62rK4HZ6A@mail.gmail.com> <CAHCN7xJdzEppn8-74SvzACsA25bUHGdV7v=CfS08xzSi59Z2uw@mail.gmail.com>
In-Reply-To: <CAHCN7xJdzEppn8-74SvzACsA25bUHGdV7v=CfS08xzSi59Z2uw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Sep 2019 12:17:28 -0300
Message-ID: <CAOMZO5D2uzR6Sz1QnX3G-Ce_juxU-0PO_vBZX+nR1mpQB8s8-w@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Refine memblock API
Content-Type: text/plain; charset="UTF-8"
To: Adam Ford <aford173@gmail.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Petr Mladek <pmladek@suse.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, sparclinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, kasan-dev <kasan-dev@googlegroups.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, devicetree <devicetree@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org, The etnaviv authors <etnaviv@lists.freedesktop.org>, linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, arm-soc <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>, linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>, linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org, Chris Healy <cphealy@gmail.com>
List-ID: <linux-um.lists.infradead.org>

On Wed, Sep 25, 2019 at 9:17 AM Adam Ford <aford173@gmail.com> wrote:

> I tried cma=256M and noticed the cma dump at the beginning didn't
> change.  Do we need to setup a reserved-memory node like
> imx6ul-ccimx6ulsom.dtsi did?

I don't think so.

Were you able to identify what was the exact commit that caused such regression?

