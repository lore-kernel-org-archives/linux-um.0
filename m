Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243D1C6FD1F
	for <linux-um@archiver.kernel.org>; Mon, 13 Mar 2023 00:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w6m9dCb/VB4gdZM/uNIhyvOCupPHyq+lTp+KmPHzD38=; b=bA/k9J1c8i9itM
	f7B8gqI02IBvTpwdmZsDsE+MzxdG50Z4SIg/FKpNbVOK1MPJkdpE8v96YarmmIfbjceJ4vFO9u7/4
	ATjnI/0jMZ8WSPScDszkEZ0nUcel2/86bVceQytybxkhyD24l7bo9vOh1Db/nB7Uwz7mHESYdFiYq
	iWq6wKTj/ncfRoTTsgiwn5QRhx+BPWbt0Vhi7pI4j4ECI21zYXHRJUYmHoiTlJYB9jqOKO7+xdnRl
	5ERGog0PPC0LXRCTWEiIMVWXBHogpmz1o3625J4N4S1CtMbp0JOICN2st3ugs4NfTo3ZEFaMuzxMI
	hgvTHo6Dm6snNe3bZCog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbViq-003reG-Kk; Mon, 13 Mar 2023 00:07:28 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbVim-003rd9-5J
	for linux-um@lists.infradead.org; Mon, 13 Mar 2023 00:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678666043; x=1710202043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r9VZpfYxoyk1rMUrZi/rwjzuzmC5Z2gPyDhCfbA35qk=;
  b=ZQ+nwUsARJs0Fckdk1ywvctGt1yw5M7dKNiAaGnWSB6Yynf8eP5m7RRz
   wsqRSJKbOL3cHDRXehkl9uaE0XoUhtH9DWxvhWavY2zKiPLs1zfYxPziP
   L60FST9FI6Ip/UpTj07MGyynRDPei4X4OHtkeU+o9PSS50ti4o8XOasDA
   vyvUviMxPILxI5fvKmCJikIi/Vc3+8N32NSQah9mrzNJAJ0aeXuaGYhPe
   tMyJenxaa0D/ZFAjeG2LzVdukca3g0c4N3UJxNGwU9NF1YQhizVj+nwsB
   NncsC7J4HasfKRrUR99pKoEtqiwTf76YvNL4cU5A20kZL/HVAqdXlFa8n
   A==;
X-IronPort-AV: E=Sophos;i="5.98,254,1673884800"; 
   d="scan'208";a="225238755"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2023 08:07:20 +0800
IronPort-SDR: /BcH3YDje9t6vVAUuqnqFgqkcDrhkKIIZS9rIm3mk5hpskKzz1XtnqIq9TPfIbCzKp5dBRtiKD
 fE4WkR2rZiHluNz+8CrgTeDLnzIYoYrHy3qyABX8EVEjIzYywHXWeNiqHm2vu29RV1x/21E59j
 ltJw9OLsXHKvIBuGYZAKwcQDJXOOikAqCHMaWVVLCJM2UmkfXM/UaGp0AwzW+Tc4LPzP0WVQiA
 XepT4vN7yGMghdE+9P6eHLyYBgBUtBrSup/IYcxU/oz7kDxtTU1aaShi2EsPuFpGloLda11Y9a
 ttA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 16:18:09 -0700
IronPort-SDR: 4o/vqztq2eSUdk6eE+VJEV5Pxj5uMTY3Cg0B59YUIUQKPdo7qt20ZnxBm2DRD7k6becNj9ipqm
 gOfVVl6r0Gf+/sE54XzDKG70QhpaBPqDC5uWLsKvNjdulfhbIirNkdiymAHUPzbbn8s9nsheg5
 e6M+esKhxJ0bjWFw2Izs4/sRj8usJFz1W4t+Fqw1YHmasRabnemn5ayMgLWY5srM10BhvvzPD7
 ryoF9HRbFqkcYYCKj/u1onqeozDa15Ixn7WWVzdNNOuQEwjuaoRxww0EXeOh4iXdHSWyLV02g7
 nPM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 17:07:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PZcRD3Cfxz1RwtC
	for <linux-um@lists.infradead.org>; Sun, 12 Mar 2023 17:07:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1678666039; x=1681258040; bh=r9VZpfYxoyk1rMUrZi/rwjzuzmC5Z2gPyDh
	CfbA35qk=; b=FGgbAWvs/JxXYPnGwZKSEjkEaMjOhp+Rgja6vDvhHMuOrEDrahZ
	dGDtzAFpO1Lqa1Hh3PQuxLsKQ8M6muTr0Dc2d0f8Z8VzDbj+neIL3MOVF2oUoSLo
	mEFyxpGSfqW5SVMxq8BSinuxnB/ldCyUvAeNVDwYQLAbd/xgrxH5ysMpqHLCT4vs
	w4mskBHSQx7PE2lGEhtkGLJjXw+5NKkt53w3igmuhqePV2CkozbSONVxj0erDsQ+
	PMN6d29gr8jRj2CIt4Z3r+Ua9ynndZd0o/UUcR1slzUi6ZZ00VMSncjRdKdzYYg7
	ZSiGkh/fiQRxhbDLlePdDSSSTsruprT3/Uw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MZUY5WqUfeF0 for <linux-um@lists.infradead.org>;
	Sun, 12 Mar 2023 17:07:19 -0700 (PDT)
Received: from [10.225.163.79] (unknown [10.225.163.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PZcRB3ZGRz1RvLy;
	Sun, 12 Mar 2023 17:07:18 -0700 (PDT)
Message-ID: <ea20a9bf-62ac-d307-4f3a-47b8d3e8a962@opensource.wdc.com>
Date: Mon, 13 Mar 2023 09:07:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] UML: pata_cs5536: fix build for X86_32 UML with
 TRACEPOINTS
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-ide@vger.kernel.org,
 linux-um@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230312235553.26298-1-rdunlap@infradead.org>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230312235553.26298-1-rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230312_170724_213630_45981A92 
X-CRM114-Status: GOOD (  16.08  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 3/13/23 08:55, Randy Dunlap wrote:
> Current build of pata_cs5536 for i386 UML fails with:
> 
> ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> 
> Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/x86/um/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -21,7 +21,7 @@ obj-y += checksum_32.o syscalls_32.o
>  obj-$(CONFIG_ELF_CORE) += elfcore.o
>  
>  subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
> -subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
> +subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o ../lib/msr.o
>  subarch-y += ../kernel/sys_ia32.o
>  
>  else

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
