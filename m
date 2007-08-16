Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Message-ID: <46C45996.6060802@shadowen.org>
Date: Thu, 16 Aug 2007 15:05:10 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
References: <20070815235825.GB17004@redhat.com>
	<1187224811.5906.55.camel@localhost> <46C3B428.4000003@intel.com>
In-Reply-To: <46C3B428.4000003@intel.com>
Subject: Re: [uml-devel] drivers/infiniband/mlx/mad.c misplaced ;
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "Kok, Auke" <auke-jan.h.kok@intel.com>
Cc: Joel Schopp <jschopp@austin.ibm.com>, Chas Williams <chas@cmf.nrl.navy.mil>, coreteam@netfilter.org, user-mode-linux-devel@lists.sourceforge.net, linux-s390@vger.kernel.org, mikep@linuxtr.net, netdev@vger.kernel.org, jdike@karaya.com, netfilter-devel@lists.netfilter.org, Linux Kernel <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rdunlap@xenotime.net>, Paul Mundt <lethal@linux-sh.org>, isdn4linux@listserv.isdn4linux.de, user-mode-linux-user@lists.sourceforge.net, linux390@de.ibm.com, Joe Perches <joe@perches.com>, Dave Jones <davej@redhat.com>, rolandd@cisco.com, swen@vnet.ibm.com

Kok, Auke wrote:
> Joe Perches wrote:
>> On Wed, 2007-08-15 at 19:58 -0400, Dave Jones wrote:
>>> Signed-off-by: Dave Jones <davej@redhat.com>
>>>
>>> diff --git a/drivers/infiniband/hw/mlx4/mad.c
>>> b/drivers/infiniband/hw/mlx4/mad.c
>>> index 3330917..0ed02b7 100644
>>> --- a/drivers/infiniband/hw/mlx4/mad.c
>>> +++ b/drivers/infiniband/hw/mlx4/mad.c
>>> @@ -109,7 +109,7 @@ int mlx4_MAD_IFC(struct mlx4_ib_dev *dev, int
>>> ignore_mkey, int ignore_bkey,
>>>                 in_modifier, op_modifier,
>>>                 MLX4_CMD_MAD_IFC, MLX4_CMD_TIME_CLASS_C);
>>>  
>>> -    if (!err);
>>> +    if (!err)
>>
>> There's more than a few of these (not inspected).
>>
>> $ egrep -r --include=*.c "\bif[[:space:]]*\([^\)]*\)[[:space:]]*\;" *
>> arch/sh/boards/se/7343/io.c:    if (0) ;
>> drivers/atm/iphase.c:     if (!desc1) ;
>> drivers/infiniband/hw/mlx4/mad.c:       if (!err);
>> drivers/isdn/capi/capiutil.c:   else if (c <= 0x0f);
>> drivers/net/tokenring/ibmtr.c:  else if (ti->shared_ram_paging ==
>> 0xf);  /* No paging in adapter */
>> drivers/s390/scsi/zfcp_erp.c:           if (status ==
>> ZFCP_ERP_SUCCEEDED) ;     /* no further action */
>> fs/hostfs/hostfs_user.c:        if(attrs->ia_valid & HOSTFS_ATTR_CTIME) ;
>> net/netfilter/xt_u32.c:         if (skb->len < 4 || pos > skb->len - 4);
>> sound/pci/au88x0/au88x0_synth.c:                                if
>> (eax == 0) ;
> 
> sounds like an excellent candidate check for checkpatch.pl !!!

Yep.  My scan of 2.6.23-rc3 with a checkpatch with this new test added,
found 6 which seemed wrong.

-apw

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
