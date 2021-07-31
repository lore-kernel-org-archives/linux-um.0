Return-Path: <Vineet.Gupta1@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT in Kconfig
Date: Sat, 31 Jul 2021 23:12:38 +0000
Message-ID: <1036d104-44c1-b162-2262-973226628be2@synopsys.com>
References: <20210731052233.4703-1-masahiroy@kernel.org>
 <20210731052233.4703-2-masahiroy@kernel.org>
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D343C53D18DD6D43ADCBB013B53C2A98@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Masahiro Yamada <masahiroy@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Walleij <linus.walleij@linaro.org>, Ley Foon Tan <ley.foon.tan@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Nick Hu <nickhu@andestech.com>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, YiFei Zhu <yifeifz2@illinois.edu>, Greentime Hu <green.hu@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Michal Simek <monstr@monstr.eu>, Helge Deller <deller@gmx.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Guo Ren <guoren@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Richard Weinberger <richard@nod.at>, Christian Borntraeger <borntraeger@de.ibm.com>, Rich Felker <dalias@libc.org>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Max Filippov <jcmvbkbc@gmail.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, Andrey Konovalov <andreyknvl@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Cain <bcain@codeaurora.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Stafford Horne <shorne@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>, Chris Zankel <chris@zankel.net>, Vasily Gorbik <gor@linux.ibm.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Jonas Bonn <jonas@southpole.se>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Colin Ian King <colin.king@canonical.com>, "David S. Miller" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>
List-ID: <linux-um.lists.infradead.org>

T24gNy8zMC8yMSAxMDoyMiBQTSwgTWFzYWhpcm8gWWFtYWRhIHdyb3RlOg0KPiBNYWtlIGFyY2hp
dGVjdHVyZXMgc2VsZWN0IFRSQUNFX0lSUUZMQUdTX1NVUFBPUlQgaW5zdGVhZCBvZg0KPiBoYXZp
bmcgbWFueSBkZWZpbmVzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXNhaGlybyBZYW1hZGEgPG1h
c2FoaXJveUBrZXJuZWwub3JnPg0KPiAtLS0NCj4NCj4gICBhcmNoL2FyYy9LY29uZmlnICAgICAg
ICAgICAgICB8IDQgKy0tLQ0KPiBbc25pcC4uXQ0KDQoNCkFja2VkLWJ5OiBWaW5lZXQgR3VwdGEg
PHZndXB0YUBzeW5vcHN5cy5jb20+wqDCoCAjYXJjaC9hcmMNCg0K

