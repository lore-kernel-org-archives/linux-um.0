Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EC7C7EE43
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eWLaHCIGT7ARUQ4Xw1rT2yDKBHz22XvPCZpm60kBro0=; b=ARrbk6iTgALwhX
	ZcKfldcdQNvSbodLMWVySweTHpMORNm1euUjt9RRQNJHA1riTUSNQh8SRDOQoF38rWMPK3Sz04JQK
	qzppnd5l0r8yyaCnMY8MGcuQo9ImMbva2TZGfESqvMP+FE9yHT3G32DLuzC7YJig3IQLgWbvEdtWE
	diQEMIZPHKUwRNDqw6JU6n1d5CvkT9JgepXrcUtMieSuDPYigbneOrxxQVaB+fXsjHRU1eiklBwI3
	SAUDlVhZOQqvdLSkc43NKPJgHqPYlciAE1L7vnmh7QfUZ/2RWANBG4GsTi8qhXY+pn/H8ZsEdNybE
	gd6CRqN+C7g/NHSW+pcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8eAH-003MPR-0A;
	Mon, 12 Jun 2023 09:48:45 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8eAE-003MNa-04
	for linux-um@lists.infradead.org;
	Mon, 12 Jun 2023 09:48:43 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30fc6b513afso217783f8f.1
        for <linux-um@lists.infradead.org>; Mon, 12 Jun 2023 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686563319; x=1689155319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlNSyW01k9RQ6r3TAUIxxl3gEy3tIBaKB2a3SyuONic=;
        b=xxOQI6NNANXTOWzWS32SlBLOHCGyjc8GT/MPA9syGH0nXWWJ9aMkSIyACTIqtJwwz7
         aYWnV86EdevV+5dsjqn/qWqqczxClLrLQQkvtDcNgXhqZGaAeGj/d3yarqk68XqjrEmb
         Vo/6ODEO9VnUPhXuJJhSWUIAW5cDYN4C85WUsQ6TrLtbhacAo23MyP+vXkEf2jTd8Gzy
         wFDB79XoTZeiYS0mYd7BIygw/punojTzRtBal0junmkVOpebP+ZN6XoUMx/gYLFJQhJ/
         PW7nmS7FcxFY3huNztvPY2T5+uvK+tVCpZxRsOLksYhr7rItDRC4yBSMBji1/Z9DKL7X
         TEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563319; x=1689155319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlNSyW01k9RQ6r3TAUIxxl3gEy3tIBaKB2a3SyuONic=;
        b=TY+3TzhR7/ZC2AC6bkJ70UVXvQb9DXcjPWb1SGpWDbLUARqWzJYNTmDHmi/yEgLVEF
         iDNCh3PbStEq9lyF87gnfQ4+ARiIMbvTHll3HpFWd138ewH0ggV1UmbTB1eQOqnvvNzT
         DsPQlS1G8kzbBYWjeKaXsfW24OkPMbcN/HFJU8iBryeoT11+npm2Kpo7/sl6vzFeBDVS
         W3ZvcW8IPwKsLJHt6iQvyYQAKwrMy66RZMAujj9bvbvmDQn1acqHKqFUGJiEMhTC2DOd
         V0giWW/V7nhybk9lSVIVvDHufCGeZyjsYudAP+5OmNLTMXrJI1fcXZ2LJgyjLCnP/K/O
         xsIw==
X-Gm-Message-State: AC+VfDwu8G9qOr6RkO6DZDDRrvQ2VmOOyY3DdnFIBBCl8SBLnWIWv0Cp
	DzSRVVvhIeiK5V1YDsVBzxlmwgJTZ9jDEzkzlczkJA==
X-Google-Smtp-Source: ACHHUZ6J0MuzEgB+zY5N5cGweR8g3pcXTay98BeXBUo3Yy7hzVoM691gG3iZCVtdC3Kll3oHg6ecTg==
X-Received: by 2002:a5d:6e0c:0:b0:30e:45a5:9476 with SMTP id h12-20020a5d6e0c000000b0030e45a59476mr4219195wrz.1.1686563318849;
        Mon, 12 Jun 2023 02:48:38 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.153])
        by smtp.gmail.com with ESMTPSA id t12-20020adfe10c000000b00307acec258esm11905152wrz.3.2023.06.12.02.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:48:38 -0700 (PDT)
Message-ID: <ea22bff7-ecd2-018e-77a1-1d2edaa21355@linaro.org>
Date: Mon, 12 Jun 2023 10:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Build regressions/improvements in v6.4-rc6
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
Cc: linux-um@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-mips@vger.kernel.org
References: <CAHk-=wgmbjQu3bVSa5JJhEymeQhkr7N3cjg-CoNLVituUnfW8w@mail.gmail.com>
 <20230612090911.1579029-1-geert@linux-m68k.org>
 <9c7f3e17-c1-1a3a-7e87-9b1ea25d9d7@linux-m68k.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <9c7f3e17-c1-1a3a-7e87-9b1ea25d9d7@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_024842_062194_852B0C06 
X-CRM114-Status: UNSURE (   6.65  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

CgpPbiA2LzEyLzIzIDEwOjI4LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6Cj4+IEpGWUksIHdo
ZW4gY29tcGFyaW5nIHY2LjQtcmM2WzFdIHRvIHY2LjQtcmM1WzNdLCB0aGUgc3VtbWFyaWVzIGFy
ZToKPj4gwqAtIGJ1aWxkIGVycm9yczogKzUvLTYKPiAKPiDCoCArIC9raXNza2Ivc3JjL2RyaXZl
cnMvc3BpL3NwaS1zdG0zMi1xc3BpLmM6IGVycm9yOiDigJhvcOKAmSBpcyB1c2VkCj4gdW5pbml0
aWFsaXplZCBbLVdlcnJvcj11bmluaXRpYWxpemVkXTrCoCA9PiA1MjM6MjcsIDU2NDoyNwoKU2Vl
bXMgdGhhdCB0aGUgcmVwb3J0IGlzIG5vdCBjb3JyZWN0IGZvciB0aGlzIHBhcnRpY3VsYXIgY2Fz
ZSBhcyBvcCBpcwpmaWxsZWQgZWl0aGVyIGJ5IG1lbWNweSBvciBtZW1zZXQgYmVmb3JlIHVzZS4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVt
IG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
