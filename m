Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXMvt-00GeP7-14
 for linux-um@lists.infradead.org; Thu, 24 Mar 2022 12:51:18 +0000
Subject: Re: [PATCH 2/2] um: daemon: make default socket configurable
References: <20220324131344.b7608507865f.I4f78dca5973127790f8dc5757ff5f021078b2c62@changeid>
 <20220324131344.3cd44e85efab.I8bb1282abea3119025f79507f01c0d951bb1bede@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <8450b576-ae05-1ed6-67f2-c5c6f9c83b4f@kot-begemot.co.uk>
Date: Thu, 24 Mar 2022 12:18:57 +0000
MIME-Version: 1.0
In-Reply-To: <20220324131344.3cd44e85efab.I8bb1282abea3119025f79507f01c0d951bb1bede@changeid>
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
> Even if daemon network is deprecated, some configurations may
> still use it (e.g. Debian), and not want to default to the
> /tmp/uml.ctl socket location. Allow configuring the default
> socket location.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/drivers/Kconfig       | 8 ++++++++
>   arch/um/drivers/daemon_kern.c | 2 +-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 521ae0d46076..914da774bd39 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -238,6 +238,14 @@ config UML_NET_DAEMON
>   
>   	  If unsure, say N.
>   
> +config UML_NET_DAEMON_DEFAULT_SOCK
> +	string "Default socket for daemon transport"
> +	default "/tmp/uml.ctl"
> +	depends on UML_NET_DAEMON
> +	help
> +	  This option allows setting the default socket for the daemon
> +	  transport, normally it defaults to /tmp/uml.ctl.
> +
>   config UML_NET_VECTOR
>   	bool "Vector I/O high performance network devices"
>   	depends on UML_NET
> diff --git a/arch/um/drivers/daemon_kern.c b/arch/um/drivers/daemon_kern.c
> index fd2402669c49..afde1e82c056 100644
> --- a/arch/um/drivers/daemon_kern.c
> +++ b/arch/um/drivers/daemon_kern.c
> @@ -65,7 +65,7 @@ static int daemon_setup(char *str, char **mac_out, void *data)
>   
>   	*init = ((struct daemon_init)
>   		{ .sock_type 		= "unix",
> -		  .ctl_sock 		= "/tmp/uml.ctl" });
> +		  .ctl_sock 		= CONFIG_UML_NET_DAEMON_DEFAULT_SOCK });
>   
>   	remain = split_if_spec(str, mac_out, &init->sock_type, &init->ctl_sock,
>   			       NULL);
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

