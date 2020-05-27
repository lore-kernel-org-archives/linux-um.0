Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Date: Wed, 27 May 2020 07:10:11 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] media: omap3isp: Shuffle cacheflush.h and include mm.h
Message-ID: <20200527051011.GB16317@lst.de>
References: <20200515143646.3857579-7-hch@lst.de>
 <20200527043426.3242439-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200527043426.3242439-1-natechancellor@gmail.com>
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
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, zippel@linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, hch@lst.de, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, linux-xtensa@linux-xtensa.org, arnd@arndb.de, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, linux-kernel@vger.kernel.org, jeyu@kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-um.lists.infradead.org>

On Tue, May 26, 2020 at 09:34:27PM -0700, Nathan Chancellor wrote:
> After mm.h was removed from the asm-generic version of cacheflush.h,
> s390 allyesconfig shows several warnings of the following nature:

Hmm, I'm pretty sure I sent the same fix a few days ago in response to
a build bot report.  But if that didn't get picked up I'm fine with
your version of it as well of course:

Acked-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

