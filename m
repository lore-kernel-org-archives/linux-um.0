Return-Path: <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH v3] uml: make CONFIG_STATIC_LINK actually static
References: <20200124221401.210449-1-brendanhiggins@google.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <3a533475-1009-b6b0-2e1e-4fa9a1ddf175@cambridgegreys.com>
Date: Mon, 10 Feb 2020 14:56:15 +0000
MIME-Version: 1.0
In-Reply-To: <20200124221401.210449-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com, richard@nod.at, geert@linux-m68k.org, james_mcmechan@hotmail.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com
List-ID: <linux-um.lists.infradead.org>



On 24/01/2020 22:14, Brendan Higgins wrote:
> Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
> be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
> UML_NET_PCAP; this is because glibc tries to load NSS which does not
> support being statically linked. So make CONFIG_STATIC_LINK depend on
> !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
> 
> Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   arch/um/Kconfig         | 8 +++++++-
>   arch/um/drivers/Kconfig | 3 +++
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 0917f8443c285..28d62151fb2ed 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -62,9 +62,12 @@ config NR_CPUS
>   
>   source "arch/$(HEADER_ARCH)/um/Kconfig"
>   
> +config FORBID_STATIC_LINK
> +	bool
> +
>   config STATIC_LINK
>   	bool "Force a static link"
> -	default n
> +	depends on !FORBID_STATIC_LINK
>   	help
>   	  This option gives you the ability to force a static link of UML.
>   	  Normally, UML is linked as a shared binary.  This is inconvenient for
> @@ -73,6 +76,9 @@ config STATIC_LINK
>   	  Additionally, this option enables using higher memory spaces (up to
>   	  2.75G) for UML.
>   
> +	  NOTE: This option is incompatible with some networking features which
> +	  depend on features that require being dynamically loaded (like NSS).
> +
>   config LD_SCRIPT_STATIC
>   	bool
>   	default y
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 72d4170557820..9160ead56e33c 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -234,6 +234,7 @@ config UML_NET_DAEMON
>   config UML_NET_VECTOR
>   	bool "Vector I/O high performance network devices"
>   	depends on UML_NET
> +	select FORBID_STATIC_LINK
>   	help
>   	This User-Mode Linux network driver uses multi-message send
>   	and receive functions. The host running the UML guest must have
> @@ -245,6 +246,7 @@ config UML_NET_VECTOR
>   config UML_NET_VDE
>   	bool "VDE transport (obsolete)"
>   	depends on UML_NET
> +	select FORBID_STATIC_LINK
>   	help
>   	This User-Mode Linux network transport allows one or more running
>   	UMLs on a single host to communicate with each other and also
> @@ -292,6 +294,7 @@ config UML_NET_MCAST
>   config UML_NET_PCAP
>   	bool "pcap transport (obsolete)"
>   	depends on UML_NET
> +	select FORBID_STATIC_LINK
>   	help
>   	The pcap transport makes a pcap packet stream on the host look
>   	like an ethernet device inside UML.  This is useful for making
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

