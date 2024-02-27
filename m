Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825F0C54798
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g5/OtNFrU+q0HQTPqi/YEqGkmh+JvEMc5GWZqEAuWTI=; b=WWnocmoF9ET+GLfaUhzLXqfvxs
	0MgbjjYoWu2nG6MLfIC7Nd0d1pNCsW+6GRJZDfyI5npPU9Y1dnTKOmSyFXRTAxUPC8EsJOclYPvi6
	21oFYo9AuuEpcYghdq7+CtRYMYBjfmIabc1rpBkjlJavZFaAMwAf5ASqvgT3/SSfHG9LEQ/+HuFi/
	zc5vZ+ZN6RcrhrHNJixy6yVkRDOjUMG3uBwiOk15zfHbBEJeY8IC8DXVX9vm1u6HGVPSKnYwhobMn
	gw3nCkxpHaVxUUb4eMYCqSGa7B5mDvXabHSsdn9HFWKGdtXoOakMlU7jkFNc15fdRN6eAXWlRYrAQ
	9AYW78qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf1AM-00000006B8t-078O;
	Tue, 27 Feb 2024 17:22:54 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf1A1-00000006B1V-1UyK;
	Tue, 27 Feb 2024 17:22:48 +0000
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBX79s001966;
	Tue, 27 Feb 2024 17:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=g5/OtNFrU+q0HQTPqi/YEqGkmh+JvEMc5GWZqEAuWTI=; b=ZC
	Ty7ll71rN8DODt66sNrLm4IsEKMm6JRxG05CVnpfRXo6OegPCKDvFzQ4GxX0CMA7
	4HNUafYKe5AudJDKFjmcea1gMW0KGeT6PdWPywzN1AVEplxwVG0CooOWxTp/myOt
	2mjU2d+DqRe2gTvEHJH23s5DgpDKagmG76roSWmoOHbXcJ+Svi3c2aE5FNC5/HgH
	aFhE3aMXbor6h74LbXirvAOe7/ZsQPsAPM2netNnHAdy0bdZLdhLkcwKAt6Jqqo6
	SCMqsHjNKWyeU7bOtGu69TrxoBzgWC/IxrmU5iFyQKYepTgcuOKquSWi7keqMaIQ
	pneMgdpWLPJqaymHobug==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh64h22ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:22:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RHMMUH001769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:22:22 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 09:22:21 -0800
Message-ID: <9336c99d-ca56-4d01-b9b2-18539ef0b725@quicinc.com>
Date: Tue, 27 Feb 2024 09:22:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] arm64: Unconditionally call
 unflatten_device_tree()
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-um@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
        <kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
References: <20240217010557.2381548-1-sboyd@kernel.org>
 <20240217010557.2381548-6-sboyd@kernel.org>
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20240217010557.2381548-6-sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U-zGZIHscjx7uttOwzY-n83UKqVrV9ux
X-Proofpoint-GUID: U-zGZIHscjx7uttOwzY-n83UKqVrV9ux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_092233_739510_01D89C56 
X-CRM114-Status: GOOD (  18.98  )
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

On 2/16/2024 5:05 PM, Stephen Boyd wrote:

> Call this function unconditionally so that we can populate an empty DTB
> on platforms that don't boot with a firmware provided or builtin DTB.
> When ACPI is in use, unflatten_device_tree() ignores the
> 'initial_boot_params' pointer so the live DT on those systems won't be
> whatever that's pointing to. Similarly, when kexec copies the DT data
> the previous kernel to the new one on ACPI systems,
> of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
> one) and copy the 'initial_boot_params' data.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

This change looks good to me. I am working on a patch set that will benefit from this.
Reviewed-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>

Regards,
Oreoluwa

> ---
>  arch/arm64/kernel/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 42c690bb2d60..0d210720d47d 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -351,8 +351,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	/* Parse the ACPI tables for possible boot-time configuration */
>  	acpi_boot_table_init();
>  
> -	if (acpi_disabled)
> -		unflatten_device_tree();
> +	unflatten_device_tree();
>  
>  	bootmem_init();

