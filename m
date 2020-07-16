Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvzuv-0002ta-7O
 for linux-um@lists.infradead.org; Thu, 16 Jul 2020 09:11:05 +0000
Message-ID: <159691324719ca79fbb8c206da527fc1f2bbc1ed.camel@sipsolutions.net>
Subject: Re: [PATCH v3 3/3] um: allow static linking for non-glibc
 implementations
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 16 Jul 2020 11:10:19 +0200
In-Reply-To: <20200715201159.54166-4-ignat@cloudflare.com>
References: <20200715201159.54166-1-ignat@cloudflare.com>
 <20200715201159.54166-4-ignat@cloudflare.com>
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
To: Ignat Korchagin <ignat@cloudflare.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, brendanhiggins@google.com, masahiroy@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com

On Wed, 2020-07-15 at 21:11 +0100, Ignat Korchagin wrote:
> It is possible to produce a statically linked UML binary with UML_NET_VECTOR,
> UML_NET_VDE and UML_NET_PCAP options enabled using alternative libc
> implementations, which do not rely on NSS, such as musl.
> 
> Allow static linking in this case.
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/um/Kconfig         | 5 +----
>  arch/um/drivers/Kconfig | 3 ---
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 9318dc6d1a0c..beb98b3b9f75 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -62,12 +62,9 @@ config NR_CPUS
>  
>  source "arch/$(HEADER_ARCH)/um/Kconfig"
>  
> -config FORBID_STATIC_LINK
> -	bool
> -
>  config STATIC_LINK
>  	bool "Force a static link"
> -	depends on !FORBID_STATIC_LINK
> +	depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || (!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP)

Come to think of it, in a way "FORBID_STATIC_LINK" was nicer because
there didn't need to be a single list of "what has dynamic dependencies"
like here the list of UML_NET_VECTOR, UML_NET_VDE, UML_NET_PCAP.

Maybe it could be

config MAY_HAVE_NON_STATIC_RUNTIME_DEPS
	bool

config STATIC_LINK
	...
	depends on !MAY_HAVE_NON_STATIC_RUNTIME_DEPS || CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS


and then UML_NET_VECTOR et al can

	select MAY_HAVE_NON_STATIC_RUNTIME_DEPS

so that the knowledge is still distributed to the corresponding options?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

