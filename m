Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C66C7115C
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3a4sekYOIoKPTcsxrLRc+zk+wxz53oyg/zv9+AP4v48=; b=34QkKiQzd4noMykbwTskZhyJJ3
	WKIrKwvp7Dplp7cEJ3MAKS0vRu8XKB9BF1GFJP4NqkPGSgal2fsfEIuDYMHoSzgTdPtbEQ0GY6VfI
	8trY3jbU8j4thkE4TPlYO2lr9z3q3Vb9U6ILfeNU0pEqKiDk5JpN+0cyL6AD0N4m1hXLaze4r4sJ3
	SWpn6+7ro4sIscBDUwkZBYGwahvOmofcOwNl9O+Wi5J81VGpYxArAmnUKXwTURXPtZ5UsSFcA+KyO
	n32CxeLvPVlwB6gmh9gH3itRJ+EurA28Hf26A/6zofKwwBvtoG1yDgYLr41yITO1qX2Q3b0taIgIi
	Q5DaywZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUPDN-00000008cc2-2EG5;
	Wed, 25 Jun 2025 12:26:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNiB-00000008Mw2-13Ma;
	Wed, 25 Jun 2025 10:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3a4sekYOIoKPTcsxrLRc+zk+wxz53oyg/zv9+AP4v48=; b=LYjlFr9+OlzV0yd7E2oJT0quwo
	+h87A8tQzgAXSJMvqZ5C4Yl/usbYWq4U/F3cy0bC1Mvtsk8Up9NNrETInrui03XhpFcmu93+5PuGv
	j/351+gdg4nSMQk8nQ4roeGMAdrxZlNLQ7wuoRY14AJy10RF6fYp+jxkrOa8hWPz+xgUCkKdee+KY
	klTLaVVGkh3RmKoJ+LcqdhCGFw1Is0N5Po5hYwXrifl28iQgvzNQAr660bhptZzHfs37WuSS24qB9
	SrA48POKppaHuMB0LQK0Vrh966EBfcHZ51aOofeI9bKnUjyjflFdGhypf9OZO7Km4yTsPBqxIEBLY
	Ngb0Gy9A==;
Received: from pegase1.c-s.fr ([93.17.236.30])
	by desiato.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNi8-00000005njF-24PN;
	Wed, 25 Jun 2025 10:50:38 +0000
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bRys55D17z9vDH;
	Wed, 25 Jun 2025 12:35:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E-qPa8r-zWGB; Wed, 25 Jun 2025 12:35:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bRys54JGWz9vDF;
	Wed, 25 Jun 2025 12:35:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 87F7D8B7B7;
	Wed, 25 Jun 2025 12:35:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Tp4ps0JWzqlx; Wed, 25 Jun 2025 12:35:53 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 942C38B7A7;
	Wed, 25 Jun 2025 12:35:51 +0200 (CEST)
Message-ID: <db30beb6-a331-46b7-92a3-1ee7782e317a@csgroup.eu>
Date: Wed, 25 Jun 2025 12:35:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] kasan: unify static kasan_flag_enabled across modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
 akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com, geert@linux-m68k.org, rppt@kernel.org,
 tiwei.btw@antgroup.com, richard.weiyang@gmail.com, benjamin.berg@intel.com,
 kevin.brodsky@arm.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250625095224.118679-1-snovitoll@gmail.com>
 <20250625095224.118679-2-snovitoll@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250625095224.118679-2-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_115036_631294_64547EE6 
X-CRM114-Status: UNSURE (   6.15  )
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



Le 25/06/2025 à 11:52, Sabyrzhan Tasbolatov a écrit :
> Historically the fast-path static key `kasan_flag_enabled` existed
> only for `CONFIG_KASAN_HW_TAGS`. Generic and SW_TAGS either relied on
> `kasan_arch_is_ready()` or evaluated KASAN checks unconditionally.
> As a result every architecture had to toggle a private flag
> in its `kasan_init()`.
> 
> This patch turns the flag into a single global runtime predicate that
> is built for every `CONFIG_KASAN` mode and adds a helper that flips
> the key once KASAN is ready.

Shouldn't kasan_init_generic() also perform the following line to reduce 
even more code duplication between architectures ?

	init_task.kasan_depth = 0;

Christophe


