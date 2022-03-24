Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXMvv-00GePx-L2
 for linux-um@lists.infradead.org; Thu, 24 Mar 2022 12:51:21 +0000
Subject: Re: [PATCH 1/2] um: xterm: make default terminal emulator configurable
References: <20220324131344.b7608507865f.I4f78dca5973127790f8dc5757ff5f021078b2c62@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <c0f1fa2b-b023-6426-cacc-912dd7095cc5@kot-begemot.co.uk>
Date: Thu, 24 Mar 2022 12:16:12 +0000
MIME-Version: 1.0
In-Reply-To: <20220324131344.b7608507865f.I4f78dca5973127790f8dc5757ff5f021078b2c62@changeid>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Ritesh Raj Sarraf <rrs@debian.org>, Johannes Berg <johannes.berg@intel.com>



On 24/03/2022 12:13, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Make the default terminal emulator configurable so e.g.
> Debian can set it to x-terminal-emulator instead of the
> current default of xterm.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/drivers/Kconfig  | 7 +++++++
>   arch/um/drivers/Makefile | 2 ++
>   arch/um/drivers/xterm.c  | 7 ++++---
>   3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index f145842c40b9..521ae0d46076 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -64,6 +64,13 @@ config XTERM_CHAN
>   	  its own xterm.
>   	  It is safe to say 'Y' here.
>   
> +config XTERM_CHAN_DEFAULT_EMULATOR
> +	string "xterm channel default terminal emulator"
> +	depends on XTERM_CHAN
> +	default "xterm"
> +	help
> +	  This option allows changing the default terminal emulator.
> +
>   config NOCONFIG_CHAN
>   	bool
>   	default !(XTERM_CHAN && TTY_CHAN && PTY_CHAN && PORT_CHAN && NULL_CHAN)
> diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
> index 803666e85414..e1dc4292bd22 100644
> --- a/arch/um/drivers/Makefile
> +++ b/arch/um/drivers/Makefile
> @@ -70,4 +70,6 @@ obj-$(CONFIG_UML_PCI_OVER_VIRTIO) += virt-pci.o
>   USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o vde_user.o vector_user.o
>   CFLAGS_null.o = -DDEV_NULL=$(DEV_NULL_PATH)
>   
> +CFLAGS_xterm.o += '-DCONFIG_XTERM_CHAN_DEFAULT_EMULATOR="$(CONFIG_XTERM_CHAN_DEFAULT_EMULATOR)"'
> +
>   include arch/um/scripts/Makefile.rules
> diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
> index 87ca4a47cd66..6918de5e2956 100644
> --- a/arch/um/drivers/xterm.c
> +++ b/arch/um/drivers/xterm.c
> @@ -42,7 +42,7 @@ static void *xterm_init(char *str, int device, const struct chan_opts *opts)
>   }
>   
>   /* Only changed by xterm_setup, which is a setup */
> -static char *terminal_emulator = "xterm";
> +static char *terminal_emulator = CONFIG_XTERM_CHAN_DEFAULT_EMULATOR;
>   static char *title_switch = "-T";
>   static char *exec_switch = "-e";
>   
> @@ -79,8 +79,9 @@ __uml_setup("xterm=", xterm_setup,
>   "    respectively.  The title switch must have the form '<switch> title',\n"
>   "    not '<switch>=title'.  Similarly, the exec switch must have the form\n"
>   "    '<switch> command arg1 arg2 ...'.\n"
> -"    The default values are 'xterm=xterm,-T,-e'.  Values for gnome-terminal\n"
> -"    are 'xterm=gnome-terminal,-t,-x'.\n\n"
> +"    The default values are 'xterm=" CONFIG_XTERM_CHAN_DEFAULT_EMULATOR
> +     ",-T,-e'.\n"
> +"    Values for gnome-terminal are 'xterm=gnome-terminal,-t,-x'.\n\n"
>   );
>   
>   static int xterm_open(int input, int output, int primary, void *d,
> 
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

