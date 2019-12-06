Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1id8IW-0004W5-Ck
 for linux-um@lists.infradead.org; Fri, 06 Dec 2019 07:45:10 +0000
Subject: Re: [RFC v1 0/2] um: drop broken features to fix allyesconfig
References: <20191206020153.228283-1-brendanhiggins@google.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <dd086a74-402c-5b9a-5a12-15a791f8749f@cambridgegreys.com>
Date: Fri, 6 Dec 2019 07:45:03 +0000
MIME-Version: 1.0
In-Reply-To: <20191206020153.228283-1-brendanhiggins@google.com>
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
To: Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com, richard@nod.at
Cc: johannes.berg@intel.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com

On 06/12/2019 02:01, Brendan Higgins wrote:
> # TL;DR
> 
> This patchset drops two broken features in an attempt to get
> allyesconfig closer to working for ARCH=um.
> 
> # What am I trying to do?
> 
> This patchset is part of my attempt to get `make ARCH=um allyesconfig`
> to produce a config that will build *and* boot to init, so that I can
> use it as a mechanism to run tests[1].
> 
> # How far away are we from an allyesconfig UML kernel?
> 
> I have identified 33 Kconfigs that are selected by allyesconfig, but
> will either not build on UML, or prevent it from booting. They are:
> 
> CONFIG_STATIC_LINK=y
> CONFIG_UML_NET_PCAP=y
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_IP_VS=y
> CONFIG_BRIDGE_EBT_BROUTE=y
> CONFIG_BRIDGE_EBT_T_FILTER=y
> CONFIG_BRIDGE_EBT_T_NAT=y
> CONFIG_MTD_NAND_CADENCE=y
> CONFIG_MTD_NAND_NANDSIM=y
> CONFIG_BLK_DEV_NULL_BLK=y
> CONFIG_BLK_DEV_RAM=y
> CONFIG_SCSI_DEBUG=y
> CONFIG_NET_VENDOR_XILINX=y
> CONFIG_NULL_TTY=y
> CONFIG_PTP_1588_CLOCK=y
> CONFIG_PINCTRL_EQUILIBRIUM=y
> CONFIG_DMABUF_SELFTESTS=y
> CONFIG_COMEDI=y
> CONFIG_XIL_AXIS_FIFO=y
> CONFIG_EXFAT_FS=y
> CONFIG_STM_DUMMY=y
> CONFIG_FSI_MASTER_ASPEED=y
> CONFIG_JFS_FS=y
> CONFIG_UBIFS_FS=y
> CONFIG_CRAMFS=y
> CONFIG_CRYPTO_DEV_SAFEXCEL=y
> CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
> CONFIG_KCOV=y
> CONFIG_LKDTM=y
> CONFIG_REED_SOLOMON_TEST=y
> CONFIG_TEST_RHASHTABLE=y
> CONFIG_TEST_MEMINIT=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> 
> This patchset attempts to deal with CONFIG_STATIC_LINK=y and
> CONFIG_UML_NET_PCAP=y by just removing them since they are broken and
> appear to have been broken for some time. (I am aware of the taboo of
> dropping configs, but given the amount of time they have been broken, I
> figured that I might be able to get away with it in this case, which is
> easier than trying to actually fix them.)
> 
> I also have a patch out to fix CONFIG_EXFAT_FS=y[2].
> 
> After this I plan on going after
> 
> CONFIG_PINCTRL_EQUILIBRIUM=y
> CONFIG_MTD_NAND_CADENCE=y
> CONFIG_FSI_MASTER_ASPEED=y
> CONFIG_CRYPTO_DEV_SAFEXCEL=y
> CONFIG_XIL_AXIS_FIFO=y
> CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
> CONFIG_XILINX_AXI_EMAC=y
> 
> the problem with these is that they depend on
> devm_platform_ioremap_resource without explicitly depending on
> CONFIG_HAS_IOMEM=y.
> 
> Also note that I don't think that CONFIG_NULL_TTY=y is actually broken
> on UML; however, console seems to get assigned to the null TTY by
> default when it is enabled, so I added it to the list for the sake of
> completeness.
> 
> The other broken configs require more investigation (I would welcome
> help, if anyone is interested ;-) ).
> 
> # Why won't allyesconfig break again after this series of fixes?
> 
> As I mentioned above, I am using UML for testing the kernel, and I am
> currently working on getting my tests to run on KernelCI. As part of our
> testing procedure for KernelCI, we are planning on building a UML kernel
> using allyesconfig and running our tests on it. Thus, we will find out
> very quickly once someone breaks allyesconfig again once we get this all
> working.
> 
> Brendan Higgins (2):
>    um: drivers: remove support for UML_NET_PCAP
>    uml: remove support for CONFIG_STATIC_LINK
> 
>   arch/um/Kconfig              |  23 +----
>   arch/um/Makefile             |   3 +-
>   arch/um/drivers/Kconfig      |  16 ----
>   arch/um/drivers/Makefile     |  17 +---
>   arch/um/drivers/pcap_kern.c  | 113 ----------------------
>   arch/um/drivers/pcap_user.c  | 137 ---------------------------
>   arch/um/drivers/pcap_user.h  |  21 -----
>   arch/um/kernel/dyn.lds.S     | 170 ----------------------------------
>   arch/um/kernel/uml.lds.S     | 115 -----------------------
>   arch/um/kernel/vmlinux.lds.S | 175 ++++++++++++++++++++++++++++++++++-
>   10 files changed, 174 insertions(+), 616 deletions(-)
>   delete mode 100644 arch/um/drivers/pcap_kern.c
>   delete mode 100644 arch/um/drivers/pcap_user.c
>   delete mode 100644 arch/um/drivers/pcap_user.h
>   delete mode 100644 arch/um/kernel/dyn.lds.S
>   delete mode 100644 arch/um/kernel/uml.lds.S
> 
> Looking forward to hearing people's thoughts!
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=205223
> [2] https://patchwork.kernel.org/patch/11273771/
> 

Patch for pcap: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=938962#79


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

