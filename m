Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B94C3DA49
	for <linux-um@archiver.kernel.org>; Tue, 30 Jul 2024 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iScYNy4aQkwzr4BMFr8wYZsESHES24+BBEyIKAwBfOE=; b=yTyh88eerECx+b9m3kF55fjI3m
	o4HsjNJKz3x3Wc1A3H4c48cb+sJKUzs7j5fEZxpYL2vxelazeBjNvKILCeID9drMKEO8ya1zKcsYm
	/9QrCgjTb6x3GYmZ6O3O+a2WXW/u7a9cLc5yzBsl+f+Z7A2j4HG/tAqjKlAZjDFwXhO1nRzQObps8
	5QhlwzeUaUsTNQipcbFcU4unECxwTq/7qcgN4npYUiIPovgOCT5e4sYR94J+KHFkF+3Wadfumj8k9
	dEMq7g7GLUiVf5HWjjcscVu6mGYvidOKM6oc4LcQRXTqIe4XifOVqMkWlst6DjeScm0upl2EWJ3Va
	CTgdrHvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnfz-0000000FQUT-0MJ7;
	Tue, 30 Jul 2024 14:18:07 +0000
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnfw-0000000FQTL-3t0q;
	Tue, 30 Jul 2024 14:18:04 +0000
Message-ID: <0bcb8271-4528-4833-bfdf-1ce0a3a650e2@infradead.org>
Date: Tue, 30 Jul 2024 07:18:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] user_mode_linux_howto_v2: add VDE vector support in
 doc
To: Renzo Davoli <renzo@cs.unibo.it>, linux-um@lists.infradead.org
Cc: luca.bassi14@studio.unibo.it, davide.berardi@unimercatorum.it
References: <ZqjwuBOlysJl8kn_@cs.unibo.it>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZqjwuBOlysJl8kn_@cs.unibo.it>
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



On 7/30/24 6:55 AM, Renzo Davoli wrote:
> Add a description of the VDE vector transport in user_mode_linux_howto_v2.rst.
> 
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
> ---
>  .../virt/uml/user_mode_linux_howto_v2.rst          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 27942446f406..584000b743f3 100644
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

                                                                   is to provide

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
> +connect to a local area cloud (all the UML nodes using the same
> +multicast address running on hosts in the same multicast domain (LAN)
> +will be automagically connected together to a virtual LAN.

Missing a close/right paren ')' somewhere.
I suppose that you meant the typo "automagically".

> +
>  Configuring Legacy transports
>  =============================
>  
> 

-- 
~Randy

