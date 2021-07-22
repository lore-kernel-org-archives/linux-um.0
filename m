Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <29adc1c164805e355b37d1d4668ebda9fb7fa872.camel@sipsolutions.net>
Subject: Re: [PATCH v3 9/9] asm-generic: reverse GENERIC_{STRNCPY_FROM,
 STRNLEN}_USER symbols
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 22 Jul 2021 15:57:56 +0200
In-Reply-To: <20210722124814.778059-10-arnd@kernel.org>
References: <20210722124814.778059-1-arnd@kernel.org>
 <20210722124814.778059-10-arnd@kernel.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Al Viro <viro@zeniv.linux.org.uk>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Brian Cain <bcain@codeaurora.org>, Chris Zankel <chris@zankel.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>, Linus Walleij <linus.walleij@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, uclinux-h8-devel@lists.sourceforge.jp

> 
> The remaining architectures at the moment are: ia64, mips, parisc,
> s390, um and xtensa. We should probably convert these as well, but

I'm not sure it makes sense to convert um, the implementation uses
strncpy(), and that should use the libc implementation, which is tuned
for the actual hardware that the binary is running on, so performance
wise that might be better.

OTOH, maybe this is all in the noise given the huge syscall overhead in
um, so maybe unifying it would make more sense.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

