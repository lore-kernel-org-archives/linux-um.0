Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iV0dK-0002r3-M7
 for linux-um@lists.infradead.org; Wed, 13 Nov 2019 21:57:04 +0000
Date: Wed, 13 Nov 2019 22:56:22 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 03/23] y2038: vdso: change timeval to __kernel_old_timeval
In-Reply-To: <20191108210824.1534248-3-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1911132256110.2507@nanos.tec.linutronix.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108210824.1534248-3-arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Vincent Chen <deanbo422@gmail.com>, y2038@lists.linaro.org, Richard Weinberger <richard@nod.at>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Borislav Petkov <bp@alien8.de>, Greentime Hu <green.hu@gmail.com>, Andy Lutomirski <luto@kernel.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Fri, 8 Nov 2019, Arnd Bergmann wrote:

> The gettimeofday() function in vdso uses the traditional 'timeval'
> structure layout, which will be incompatible with future versions of
> glibc on 32-bit architectures that use a 64-bit time_t.
> 
> This interface is problematic for y2038, when time_t overflows on 32-bit
> architectures, but the plan so far is that a libc with 64-bit time_t
> will not call into the gettimeofday() vdso helper at all, and only
> have a method for entering clock_gettime().  This means we don't have
> to fix it here, though we probably want to add a new clock_gettime()
> entry point using a 64-bit version of 'struct timespec' at some point.
> 
> Changing the vdso code to use __kernel_old_timeval helps isolate
> this usage from the other ones that still need to be fixed properly,
> and it gets us closer to removing the 'timeval' definition from the
> kernel sources.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

