Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2F9EB64DD
	for <linux-um@archiver.kernel.org>; Sun, 25 Jun 2023 21:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bc5ibtKhbNRjB5THF43/pYWEt2HpuGRbC9SNTSTweUY=; b=ktAjt7taqR3KN9
	958HKC7VGbFbNwOvJU7qb6Afhq3jGc3F/K2Op04LKHc3Uzs5zq5Rcv4WqjJtXpj1Zv4OYIEJ9bY7J
	A0JK46dwwoWARe5WTL2kVdZG0MsbYjxUOEfWXlNvhxlA+t6N9TSJ7CwMrWzB0Cokzldyg3mlCc/WI
	HSW33NeuDA7MutTc+2PAyvmZWSwkxcYVx05WW+D/SCs/FhDO9jePtG6vJUr46yXO22TbEVzYzkKVH
	kQPmJ0sUES2uPnhuGQL0BDfwW8b3qmHrFmy6iYBL1fkzmTa2uFhLlU+GNhJP3W3Q6r6xrwXpChDav
	y+xxfKMBVNkUHH+MF9Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXF3-008kM8-0i;
	Sun, 25 Jun 2023 21:25:53 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXF0-008kL5-1y
	for linux-um@lists.infradead.org;
	Sun, 25 Jun 2023 21:25:51 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fa7512e599so33755605e9.2
        for <linux-um@lists.infradead.org>; Sun, 25 Jun 2023 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687728349; x=1690320349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdnZaaLPu+ki2Fnpi7gIMqnleR/1nTSrgsUBiU7raqs=;
        b=AuZzlwnDYmnmOftfy2wrafOBFbb56vCejuD34y8KcPpleFcFuezxpyFWOSjhuZxkPS
         zeSfG2w0XrIPV1KdHWQokPQ1jXghjl2vrhRRAbTkOmBPev2Y+nWRI/biFzHZ3hCMQ7tM
         p/FzxBnXFDBpB8MHCj2WU/UolKd4/Vvmjvp6o4dVorfVmDfRaxfNR+qA9bNx0Pj9YdH1
         aTtZEM3RJSnIyZi4R338cGts/EylYRAl+/bJngdYtZ+oY5xIw7Y0hDIrOVdqWfMpTeqN
         /SK8Y+WrVYilXjqF3JrwO8FslIckA2qun1P1rq5RIx075Bn9K14LU4ka2oAd4GBp7mSP
         lYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687728349; x=1690320349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdnZaaLPu+ki2Fnpi7gIMqnleR/1nTSrgsUBiU7raqs=;
        b=GknSv67g87cJgrwlM7k26PGdUEhaFI1S5iA/K7eYgL5euLXlb6UhqaRVcNxq9pGGo0
         Ig4+3n5wyLSqLycTOIWWAl8p2P/YNCMxzd6PqY21HpJAHNaDgrFi2cU4ejQnfhsNaR1K
         rnReWdKDIhihSNMYSw43M9fUowp2WMHi4iWgO8WQdyo5IhkZ4857XsQjWlQOU7pBEVYk
         6KBecpzCRamaNyZI5wWTXOCb7OGyC53oWednMqwi3aTTNSmVDG3wN6nD1uZsCVtjluuR
         GimD9Z5oaAKAm6LswPkrATsbmBvvnPVy3d4mj0vUVjIWwL9HvX7Ri09k2J2x9iMIUMBU
         jK5A==
X-Gm-Message-State: AC+VfDwmwcrks5egtdPTKUZBA9KVr6EOU0/P5AR+NqfFkVMvo1R31CHF
	QBxEu9/q8oulHKbzPUAK80CZXw==
X-Google-Smtp-Source: ACHHUZ55uWsoV2hbUGeBFvfsxWLvpqQwxIsiqcLZylUM/E4cjFWcT0Stb/ufsPS5kTWtMBzw9AQ43Q==
X-Received: by 2002:a1c:4b16:0:b0:3fa:8475:bce1 with SMTP id y22-20020a1c4b16000000b003fa8475bce1mr3968019wma.4.1687728349062;
        Sun, 25 Jun 2023 14:25:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
        by smtp.gmail.com with ESMTPSA id c13-20020a7bc00d000000b003f735ba7736sm5718246wmb.46.2023.06.25.14.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 14:25:48 -0700 (PDT)
Message-ID: <db27d890-9c2c-8ec8-0d88-62b9172893ae@linaro.org>
Date: Sun, 25 Jun 2023 23:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [patch 07/17] mips/cpu: Switch to arch_cpu_finalize_init()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Richard Henderson <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.312438573@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613224545.312438573@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_142550_657698_3E21594F 
X-CRM114-Status: UNSURE (   9.75  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gMTQvNi8yMyAwMTozOSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+IGNoZWNrX2J1Z3MoKSBp
cyBhYm91dCB0byBiZSBwaGFzZWQgb3V0LiBTd2l0Y2ggb3ZlciB0byB0aGUgbmV3Cj4gYXJjaF9j
cHVfZmluYWxpemVfaW5pdCgpIGltcGxlbWVudGF0aW9uLgo+IAo+IE5vIGZ1bmN0aW9uYWwgY2hh
bmdlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4
LmRlPgo+IENjOiBUaG9tYXMgQm9nZW5kb2VyZmVyIDx0c2JvZ2VuZEBhbHBoYS5mcmFua2VuLmRl
Pgo+IENjOiBsaW51eC1taXBzQHZnZXIua2VybmVsLm9yZwo+IC0tLQo+ICAgYXJjaC9taXBzL0tj
b25maWcgICAgICAgICAgICB8ICAgIDEgKwo+ICAgYXJjaC9taXBzL2luY2x1ZGUvYXNtL2J1Z3Mu
aCB8ICAgMTcgLS0tLS0tLS0tLS0tLS0tLS0KPiAgIGFyY2gvbWlwcy9rZXJuZWwvc2V0dXAuYyAg
ICAgfCAgIDEzICsrKysrKysrKysrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgMTcgZGVsZXRpb25zKC0pCgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEBsaW5hcm8ub3JnPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K
