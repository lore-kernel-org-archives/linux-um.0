Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from isilmar-4.linta.de ([136.243.71.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gRD7h-00036K-Go
 for linux-um@lists.infradead.org; Mon, 26 Nov 2018 09:24:11 +0000
Date: Mon, 26 Nov 2018 09:36:33 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] pcmcia: remove per-arch PCMCIA config entry
Message-ID: <20181126083633.GA10604@light.dominikbrodowski.net>
References: <1543220141-13744-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543220141-13744-1-git-send-email-yamada.masahiro@socionext.com>
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christoph Hellwig <hch@lst.de>

On Mon, Nov 26, 2018 at 05:15:41PM +0900, Masahiro Yamada wrote:
> Now that all architectures include drivers/pcmcia/Kconfig where
> the PCMCIA config is defined, the PCMCIA config entries in per-arch
> Kconfig files are redundant.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> I will queue this up to my kbuild tree
> along with Christoph's clean-up patch set.

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

