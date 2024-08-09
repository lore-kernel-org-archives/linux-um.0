Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E595C52D7C
	for <linux-um@archiver.kernel.org>; Fri,  9 Aug 2024 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BsXHTkTOhsy4wvo1JUx3YpUomWB4u9W9yoD32mhb1yU=; b=tzx63ao+VpoqSOgiQ6NVD7Qurb
	nwUnq0e0wKDalPY1ufif+lJfWBylwMfS1TGNnedZtYNzrhSvXG7gefZ549L1aia3ptD+IRZh2VDrr
	VIzkU0mHJEYs+9DU+Dcm0oLuYVR3VA1AZNNpNlvSTNmNc54ChRFEhtimaKnn/pkDJWBXJp9y/Ec2e
	lspD9HzDAyKJGDrU2qjghuJnerIgZ1k7PFVbgrIHNEfjg9mRwcKIWrhhk6CpFoZyPUc/+k6eODlKV
	4iYiHN5WAoxjnh7aQC9pbByvlv700xBlvQLHFVdoIQCYkp7TQxuR/wfFSMBsLlT8Inkae8kN0s8/N
	2drq4B0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scQb5-0000000BXaF-1ipy;
	Fri, 09 Aug 2024 14:28:03 +0000
Received: from [50.53.9.16] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scQb1-0000000BXX5-4BNo;
	Fri, 09 Aug 2024 14:28:00 +0000
Message-ID: <fabe0fbc-0868-43bf-8c20-4b1279619da7@infradead.org>
Date: Fri, 9 Aug 2024 07:27:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] user_mode_linux_howto_v2: add VDE vector support in
 doc
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: linux-um@lists.infradead.org, luca.bassi14@studio.unibo.it,
 davide.berardi@unimercatorum.it
References: <ZqjwuBOlysJl8kn_@cs.unibo.it>
 <0bcb8271-4528-4833-bfdf-1ce0a3a650e2@infradead.org>
 <ZrYVg8r5lhRheqoS@cs.unibo.it>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZrYVg8r5lhRheqoS@cs.unibo.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 8/9/24 6:11 AM, Renzo Davoli wrote:
> On Tue, Jul 30, 2024 at 07:18:04AM -0700, Randy Dunlap wrote:
>> Missing a close/right paren ')' somewhere.
>> I suppose that you meant the typo "automagically".
> 
> thank you Randy. I have fixed the typos in the emended patch here below.
> 
> Add a description of the VDE vector transport in user_mode_linux_howto_v2.rst.
> 
> Signed-off-by: Renzo Davoi <renzo@cs.unibo.it>

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  .../virt/uml/user_mode_linux_howto_v2.rst          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 27942446f406..32a90baf263b 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -217,6 +217,8 @@ remote UML and other VM instances.
>  +-----------+--------+------------------------------------+------------+
>  | fd        | vector | dependent on fd type               | varies     |
>  +-----------+--------+------------------------------------+------------+
> +| vde       | vector | dep. on VDE VPN: Virt.Net Locator  | varies     |
> ++-----------+--------+------------------------------------+------------+
>  | tuntap    | legacy | none                               | ~ 500Mbit  |
>  +-----------+--------+------------------------------------+------------+
>  | daemon    | legacy | none                               | ~ 450Mbit  |
> @@ -573,6 +575,41 @@ https://github.com/NetSys/bess/wiki/Built-In-Modules-and-Ports
>  
>  BESS transport does not require any special privileges.
>  
> +VDE vector transport
> +--------------------
> +
> +Virtual Distributed Ethernet (VDE) is a project whose main goal is to provide a
> +highly flexible support for virtual networking.
> +
> +http://wiki.virtualsquare.org/#/tutorials/vdebasics
> +
> +Common usages of VDE include fast prototyping and teaching.
> +
> +Examples:
> +
> +   ``vecX:transport=vde,vnl=tap://tap0``
> +
> +use tap0
> +
> +   ``vecX:transport=vde,vnl=slirp://``
> +
> +use slirp
> +
> +   ``vec0:transport=vde,vnl=vde:///tmp/switch``
> +
> +connect to a vde switch
> +
> +   ``vecX:transport=\"vde,vnl=cmd://ssh remote.host //tmp/sshlirp\"``
> +
> +connect to a remote slirp (instant VPN: convert ssh to VPN, it uses sshlirp)
> +https://github.com/virtualsquare/sshlirp
> +
> +   ``vec0:transport=vde,vnl=vxvde://234.0.0.1``
> +
> +connect to a local area cloud: all the UML nodes using the same
> +multicast address running on hosts in the same multicast domain (LAN)
> +will be automatically connected together to a virtual LAN.
> +
>  Configuring Legacy transports
>  =============================
>  

-- 
~Randy

