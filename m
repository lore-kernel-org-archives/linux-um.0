Return-Path: <linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Date: Thu, 19 May 2011 13:32:07 +1000
Message-ID: <1305775927.7481.31.camel@pasglop>
Mime-Version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org
Subject: Re: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-m32r@ml.linux-m32r.org, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, sparclinux@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 2011-05-06 at 22:57 -0700, Stephen Boyd wrote:
> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
> 
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.

Sorry for the delay...

For powerpc:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev

