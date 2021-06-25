Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwhxC-000bzs-5z
 for linux-um@lists.infradead.org; Fri, 25 Jun 2021 09:16:51 +0000
Subject: Re: [PATCH 1/4] um: make PCI emulation driver init/exit static
References: <20210625103436.900a9e962c32.Id45a0d2d0167dd9b6a067b42d791523896574064@changeid>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <3fe0853b-2e47-11ca-2668-b2de2f4970ce@cambridgegreys.com>
Date: Fri, 25 Jun 2021 10:16:46 +0100
MIME-Version: 1.0
In-Reply-To: <20210625103436.900a9e962c32.Id45a0d2d0167dd9b6a067b42d791523896574064@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>, kernel test robot <lkp@intel.com>



On 25/06/2021 09:34, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The functions aren't used elsewhere, so they can be static.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/drivers/virt-pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index 0b802834f40a..70c17de16662 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -810,7 +810,7 @@ void *pci_root_bus_fwnode(struct pci_bus *bus)
>   	return um_pci_fwnode;
>   }
>   
> -int um_pci_init(void)
> +static int um_pci_init(void)
>   {
>   	int err, i;
>   
> @@ -884,7 +884,7 @@ int um_pci_init(void)
>   }
>   module_init(um_pci_init);
>   
> -void um_pci_exit(void)
> +static void um_pci_exit(void)
>   {
>   	unregister_virtio_driver(&um_pci_virtio_driver);
>   	irq_domain_remove(um_pci_msi_domain);
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

