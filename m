Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2F7C2BA18
	for <linux-um@archiver.kernel.org>; Tue, 18 Jun 2024 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yz2POXzlje0Rk92k3Asl8aSkFWAo/SOEkU2cZBWovB0=; b=XIRiYoP9ivxlrHIuBJNIhd1//A
	wY7PPIXlJGnIHRn15oWdk40Km9A+p6rAOujQjzK2fmBCE5xYxalup2FhJ4dEWCgYGxcRFgUfRgGo+
	TAE5+k6aeqL/fim0OEH7i1urez6OxlD1Re9AYZNceQtw+eFn9GuNupPY+nT11dSjZrXwwm0psqgv1
	R+pBfnX3BCPwhD5nYgpqt4+jZM1wtuRXlbysXEufLxY0YIplhBDFEDuV3Wt+3a7YbGMDrjKkNOdcM
	Rsfvj4P0BPUkrovrHiV50BUVrL00NAaWMAXKQtJmyLoEe+uO1R//43B9xcnQ2vl+Yv48LkgtLQalR
	H5OMqS2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJYXE-0000000F1AH-2nFY;
	Tue, 18 Jun 2024 13:06:04 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJYXB-0000000F18Z-3YBr
	for linux-um@lists.infradead.org;
	Tue, 18 Jun 2024 13:06:03 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-52b7ffd9f6eso5388134e87.3
        for <linux-um@lists.infradead.org>; Tue, 18 Jun 2024 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718715958; x=1719320758; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yz2POXzlje0Rk92k3Asl8aSkFWAo/SOEkU2cZBWovB0=;
        b=A7q5CSzWsUcAsFPLMa0NzHjii6bzMb37rRkfOCDzL3cDXEhmqQxMhgLuRKI+DNfUUF
         X9YHCIRFeBO1zVFjdpH7ZMMdFEVIXxACj9SfZpHJrQ/4WI77aVXHhlyjt+/IwGoxd6wK
         yTgkRjaOslFKKnbVc7wwEtkho2w4jdqKkhQ8ZMvU8u/iZshBdkqc/cQn4XXYtLblJaO0
         8GVlcDZ0KPipUKaYfmq411s0J/uRGSVM72kLFgZ6gYajdYfaRxqc0H0/5XAaBV39rxoy
         xpntcNXlsh0G7cb5f8a3VEDJP+e9PDTL92SaCW4gC2HFVWzbow4r0fQydKX+ywW/PAak
         2/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718715958; x=1719320758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz2POXzlje0Rk92k3Asl8aSkFWAo/SOEkU2cZBWovB0=;
        b=v5Qe7MDE9TNIQcbozwDH8pl3kBo0de843TyQ3sJuiOP1XiF//toVkC+FTUCIRtVT/B
         GJmCy15olF6JTQM+X83/5UwAU5L5j3RtnUTqiLIcidNygGdRLUNXfVl+l020yEer8wOs
         61o+IXVKFwW8dxAMA/6Qjz+buDiPFsTsQ1lFv9HeSSjO4ST2jvZWEkrmdyZxc5WYAeGY
         3iz+UjSA6qtVJZ5tzhI1/NLEWCIbICUT2E7WP4RPlCj+tCrq1nZx6ZZBdOKj8CZvshq7
         EBRQfyRdwJ7cEBjFo8IvkoLh1IYvO/sinOweC9pdPnUm1+iNchujjtF9mNghYOCGZBXz
         Hzyw==
X-Forwarded-Encrypted: i=1; AJvYcCXPLn6bzL0H0H57kYUkCsbfTQqIdewUu7dCsVimtHLC9cGdpyfJuQnf+n9jJHVwSAF8NR/Bi8oacK++tZznCAafES8TzjQkAdI0utAk
X-Gm-Message-State: AOJu0YzWvmgCI3owdDiBVjpCzK+Zm2mqEPdlN8REoQxvKMFGKGC+91kD
	0jijSdpn9yNrmGIKAJcsbUaM1lygKfo6kU8keJ6kDUKgC6Is3CTu2y5aoQ==
X-Google-Smtp-Source: AGHT+IFkWxc6pexL44K2yH98VVFydVomvNRifmX98LXDDM7htKW6C5Gq43bAc/V0TD+tZp6EJj5ywA==
X-Received: by 2002:a05:6512:558:b0:52c:8318:dc14 with SMTP id 2adb3069b0e04-52ca6e66feemr7610912e87.25.1718715957839;
        Tue, 18 Jun 2024 06:05:57 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cc067b35asm390974e87.103.2024.06.18.06.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:05:57 -0700 (PDT)
Message-ID: <15685ef6-92a5-41df-9148-1a67ceaec47b@gmail.com>
Date: Tue, 18 Jun 2024 16:05:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] Introduce irq_domain_instanciate()
To: Thomas Gleixner <tglx@linutronix.de>,
 Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-um@lists.infradead.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
 <87msnju0x3.ffs@tglx>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <87msnju0x3.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_060601_918854_8A25B203 
X-CRM114-Status: UNSURE (   9.13  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 6/17/24 16:57, Thomas Gleixner wrote:
> 
> The result can be found at:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> 
> Matti, can you please build your extensions on top of that?

Will do, but it takes me a while as I'm on a vacation. I'll try to cook 
it up when the next rainy day hits us ;) Thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


