Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEF9C7EE30
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GillNPWED+I7+g+LPn4LlQ45F2dOjncNPtfp8jyTpgU=; b=e7Pco/8E70bJ5SoNhdQA8sgew0
	Aw86hFfwh8pX2LIafwfKxe5PjVGrNvHJjl86Lzy9Jk4zYsI/u4/yMlss9nCUepzv49fBM9Zmpz8Wa
	CSrvuUQx08BIVGPrNjHEPXzlovcg8TqHngYAh9eWj9SW7zVgK/5zN8NQ33/7tXFih5ug7Hh1GZcp/
	mdaWXyuHTUFpwKHmsxaMgzJz3oYDX5s99US4GKh5ZIqTRPz1TYo852BiLH/TUer5lknLOoh1AV79B
	R6ytwcOQCb2GdwkAUtedZbGpO818wiPE2BeuIHsJ18UiTaHSLknhYPrkyWMK8/7CyHgpMAGGx2o9C
	Z2IyDcmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUPHv-00000008dFy-2wI5;
	Wed, 25 Jun 2025 12:31:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNiK-00000008MxE-2SCO;
	Wed, 25 Jun 2025 10:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GillNPWED+I7+g+LPn4LlQ45F2dOjncNPtfp8jyTpgU=; b=Nz5NJjMhG3vavCuC3/TUtUkpTB
	ZVutTcxu5/Yn6kvbSxM273BO9/LLAr3pYFqMHQyAtF/BOCXCch/VP1MfEb/3RH9P3oR70Om6jqTrb
	QXphVXEUVeswWh014XKErb0bwN1SOj+k148QdXKbJn3VKY4o3xYPMW0QtDtr9t614DyDpM2v1pCmW
	MKIDBU3u4TO8qET64bDQMnOWhbv+5/q9GVCOhSgcgZtXhdhvSNM2bsRQ2C/VKAW8vzVaOfS8khbJC
	2VXce6WiMn5Ww7d2tW4ghmAYs+4RHumLdsRL/ROkoWo3ZSRAob6re9urW2kqqrUA/44t51yRvO8YY
	D85B8ghA==;
Received: from pegase1.c-s.fr ([93.17.236.30])
	by desiato.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNiI-00000005nkM-0i9V;
	Wed, 25 Jun 2025 10:50:47 +0000
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bRyfz3MTKz9vBt;
	Wed, 25 Jun 2025 12:27:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p2o-Y-FdKUAQ; Wed, 25 Jun 2025 12:27:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bRyfz2RdKz9vBC;
	Wed, 25 Jun 2025 12:27:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 435058B7B7;
	Wed, 25 Jun 2025 12:27:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id vvosXbHhLt2e; Wed, 25 Jun 2025 12:27:07 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BC418B7A7;
	Wed, 25 Jun 2025 12:27:04 +0200 (CEST)
Message-ID: <750b6617-7abf-4adc-b3e6-6194ff10c547@csgroup.eu>
Date: Wed, 25 Jun 2025 12:27:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 2/9] kasan: replace kasan_arch_is_ready with kasan_enabled
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
 <20250625095224.118679-3-snovitoll@gmail.com>
Content-Language: fr-FR
In-Reply-To: <20250625095224.118679-3-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_115046_309710_71208581 
X-CRM114-Status: UNSURE (   3.48  )
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
> Replace the existing kasan_arch_is_ready() calls with kasan_enabled().
> Drop checks where the caller is already under kasan_enabled() condition.

If I understand correctly, it means that KASAN won't work anymore 
between patch 2 and 9, because until the arch calls kasan_init_generic() 
kasan_enabled() will return false.

The transition should be smooth and your series should remain bisectable.

Or am I missing something ?

Christophe


