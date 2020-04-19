Return-Path: <openrisc-bounces@lists.librecores.org>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <510426be-c95f-adea-af6a-51e592f41ce0@web.de>
Date: Sun, 19 Apr 2020 08:24:59 +0200
MIME-Version: 1.0
Content-Language: en-GB
Subject: Re: [OpenRISC] [PATCH v3 00/50] Add log level to show_stack()
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>
To: Dmitry Safonov <dima@arista.com>, clang-built-linux@googlegroups.com, kgdb-bugreport@lists.sourceforge.net, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Petr Mladek <pmladek@suse.com>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Paul Mackerras <paulus@samba.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jonas Bonn <jonas@southpole.se>, Daniel Thompson <daniel.thompson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Brian Cain <bcain@codeaurora.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>, Jiri Slaby <jslaby@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Richard Weinberger <richard@nod.at>, Borislav Petkov <bp@alien8.de>, Greentime Hu <green.hu@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Ley Foon Tan <lftan@altera.com>, Guan Xuetao <gxt@pku.edu.cn>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, Paul Burton <paulburton@kernel.org>, Vineet Gupta <vgupta@synopsys.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Douglas Anderson <dianders@chromium.org>, =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Mark Salter <msalter@redhat.com>, Jason Wessel <jason.wessel@windriver.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-um.lists.infradead.org>

PiBDaGFuZ2VzIHRvIHYzOgo+IC0gQ29sbGVjdGVkIG1vcmUgYXJjaGl0ZWN0dWFsIEFja3MgYW5k
IFJldmlld2VkLWJ5CgoqIEkgc3VnZ2VzdCB0byBhdm9pZCBhIHR5cG8gaW4gdGhpcyBkZXNjcmlw
dGlvbi4KCiogUGxlYXNlIHNlcGFyYXRlIHRoZSB0YWcg4oCcUEFUQ0jigJ0gZnJvbSB0aGUgdmVy
c2lvbiBkZXNjcmlwdG9yIGluIHRoZSBzdWJqZWN0LgogIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50
YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0P2lkPTUwY2MwOWMxODk4NWVhY2Ji
ZDY2NmFjZmQ3YmUyMzkxMzk0NzMzZjUjbjcwOQoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk9wZW5SSVNDIG1haWxpbmcgbGlz
dApPcGVuUklTQ0BsaXN0cy5saWJyZWNvcmVzLm9yZwpodHRwczovL2xpc3RzLmxpYnJlY29yZXMu
b3JnL2xpc3RpbmZvL29wZW5yaXNjCg==

