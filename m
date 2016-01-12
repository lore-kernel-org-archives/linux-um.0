Return-Path: <linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 12 Jan 2016 15:10:49 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 13/41] x86: reuse asm-generic/barrier.h
In-Reply-To: <1452426622-4471-14-git-send-email-mst@redhat.com>
Message-ID: <alpine.DEB.2.11.1601121510380.3575@nanos>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
 <1452426622-4471-14-git-send-email-mst@redhat.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Borislav Petkov <bp@suse.de>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Andy Lutomirski <luto@kernel.org>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, 10 Jan 2016, Michael S. Tsirkin wrote:

> As on most architectures, on x86 read_barrier_depends and
> smp_read_barrier_depends are empty.  Drop the local definitions and pull
> the generic ones from asm-generic/barrier.h instead: they are identical.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

