Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKfM2-0006TI-RR
 for linux-um@lists.infradead.org; Wed, 16 Oct 2019 09:12:28 +0000
Subject: Re: [PATCH] um: Fix pcap and vde driver builds
References: <20191016075343.28564-1-anton.ivanov@cambridgegreys.com>
 <20191016075343.28564-2-anton.ivanov@cambridgegreys.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <2645291b-0bc4-86e9-bba1-4866a00d6650@cambridgegreys.com>
Date: Wed, 16 Oct 2019 10:12:20 +0100
MIME-Version: 1.0
In-Reply-To: <20191016075343.28564-2-anton.ivanov@cambridgegreys.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, 938962@bugs.debian.org

On 16/10/2019 08:53, Anton Ivanov wrote:
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>   arch/um/drivers/Makefile | 8 ++++++++
>   scripts/link-vmlinux.sh  | 2 +-
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
> index 693319839f69..34355057ec85 100644
> --- a/arch/um/drivers/Makefile
> +++ b/arch/um/drivers/Makefile
> @@ -24,6 +24,14 @@ LDFLAGS_vde.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
>   
>   targets := pcap_kern.o pcap_user.o vde_kern.o vde_user.o
>   
> +ifeq ($(CONFIG_UML_NET_PCAP),y)
> +	export UML_EXTRA_LIBS += -lpcap
> +endif
> +ifeq ($(CONFIG_UML_NET_VDE),y)
> +	export UML_EXTRA_LIBS += -lvde -lvdeplug
> +endif
> +
> +
>   $(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
>   	$(LD) -r -dp -o $@ $^ $(ld_flags)
>   
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 915775eb2921..d3e6a6cdfc13 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -86,7 +86,7 @@ vmlinux_link()
>   		${CC} ${CFLAGS_vmlinux} -o ${2}			\
>   			-Wl,-T,${lds}				\
>   			${objects}				\
> -			-lutil -lrt -lpthread
> +			-lutil -lrt -lpthread ${UML_EXTRA_LIBS}
>   		rm -f linux
>   	fi
>   }


This will not work as advertised unfortunately - I have to write out the 
libs list somewhere and load it again in the link script instead of 
passing it as an environment variable.

A fixed patch will follow shortly.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

