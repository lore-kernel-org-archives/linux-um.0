Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3837606A326
	for <linux-um@archiver.kernel.org>; Mon,  9 Nov 2026 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HIR3Ag+c;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Ba0K3mcT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yuy3hh1L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=B7FDLZUKPjEFwipCZtZWEV8Ro0PRoRjxsi+GkVo52T8=; b=HIR3Ag+comKqYO
	waH+qW0yehM5Y+tqpG+jBKBJ1RUTcBCMlSFrd2I5vDnhdrL962PnFcksfOAodONYfidZxgKp6ho7e
	TWOQIv7MOdAvpWoN4XpiW0jgpJONdBzp29IWg5zQ8eJO/GdVsWfpIzn0+XBfV6aaMjQyLvKghrOoa
	uR6bIN+pbSPK+3mg1blYiJoA4e4AtL0RYuqhJ/fgycqAxxMVDzK69o1nqA2EgPKUZCLwF/CKMwTjk
	KjeHhbBZfQosnVwNRniaSnSaA47igGlTw4UZu3OToWvo4QLfrZafZO0xoylw4PQp/keoIGeTvc0kB
	+S1vRIejK/inCua/0jEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQMUo-00000000ObZ-3l7q;
	Mon, 09 Nov 2026 10:21:02 +0000
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQMUl-00000000OaW-0zGN
	for linux-um@lists.infradead.org;
	Mon, 09 Nov 2026 10:21:00 +0000
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id EB1151D0016C
	for <linux-um@lists.infradead.org>; Mon,  9 Nov 2026 05:20:57 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 09 Nov 2026 05:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794219646;
	 x=1794306046; bh=B7FDLZUKPjEFwipCZtZWEV8Ro0PRoRjxsi+GkVo52T8=; b=
	Ba0K3mcT/FVII/3zDEmy+BTeyTiXG+E1Nujf4mRzxJKn9i3HIHM/YrStr2PAfC79
	NZyKAXGNbe8tkesfNLltgh7fMLiXM+FI0xq7xsPOGiXiwzcpQKMdK8pqgV45ZgmT
	cLuPiYt+eAoJeTz2STO55Tf1k7hYVsr4aC9FClHrlq3SriLYiErTGEo/C2VQjUeP
	OMqt+JNpavN5VAPKA82KiyWq9phG3HxlO/YgllUVJw8KskGSVhubIjKW8VKOMeID
	/zcBKr7rjHT2L39IQeXgB+eg373/n4H+xATZom/bGk55z43eYnbloRAspzuO2DX2
	li4grVp3+FqkU+UrMLV1yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794219646; x=
	1794306046; bh=B7FDLZUKPjEFwipCZtZWEV8Ro0PRoRjxsi+GkVo52T8=; b=y
	uy3hh1LDUayIxIhNVlZg5UztAeIfCsjwZWNmvtZa/UqKyQ7NuxHhb3BiMm/dzMwU
	wb3Ki7Nf/Wu2nUTa65Yj2dlMoeYfzyQPZPgmT6LwYz6PhLUaqyb+HNTKC7fE0Rrk
	kM9g9JwcUnOeZ8wBjqw1JEeQq3uH6yz0S/DFk8a8/4+rl+iLSEykaRMR5iiFnGfF
	pDWJthP3myyE1+0DSapezLV98Mw2qX0QraK+y62L6nhpRJJGWkRqmMgGi+JIgEWl
	/Bzw4i6sq0YMEwEwSJ9fcEk9RE9KxpfHdNqy+L6Tk4+DrdeIqL+4Wyiy9+ni2X1v
	yvx0GLKsgHSRSNMgUKbrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794219646; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm2:rsa-sha256:i8Wzb9OMA/jq6DekNoXvSsWiYdxqEnQcbYfY8XASxlqgXtQ
	7i+F/hPmbT47A6NLlQUrZy1DUrR4u6uxwWZqheR1ECO/EhZNceo0GuwJlfCBcsu3
	0vykNuJOOa7HOVlf/FSIJXYGaSl4KDo7DngNrav2DBmKn+yUr67Qvfzzw16weV0c
	7/MgHPrqPTlK3N37QMN59iEF+MCKtzdQ83a6UdnXHXFFv+4RQjl5B9OxJ3kClg3D
	8Wb8orsZR3ZvBAEY1wlHztLNygttPvkEkby/3HVLT+oBcZi7hkEc7xI1eEPwTWLw
	vyoAfjVMsIDi8pMi6oTm8C2VpI3D5I+BlO4D6bw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qc0rimyHNOx5k3tCs4U58nIqz4hs7SmVJSrVS9r7tqM=:wr3MVIuXPS6AZf4iSg5v4QlWZBUA1YwfVrMohkXDGk0=;
X-ME-Sender: <xms:dZ7xalvV-oSQXzSmGwqUOUvIP-PomSv9exf87XcvhnVMe5vlsPZJIg>
    <xme:dZ7xapRt72_AEsvVNd2yyCeliWckvwPpK6LKw2WsR8-6phC6NKwNYKuHyAlqC1mtO
    BwXkzndm-9yiB7l1j-2ThjGeYionrz5d8AWsG1FNhwa_Wwy5hE2FNK8_Q>
X-ME-Proxy-Cause: dmFkZTE3M/GjcqLLBjOd6SrtP7LhzOBqkSFZGrsunTI7Nr4aBtog0c0uRaHsnHtezI2yR+
    oOTmscngsYiNA1qhXTIDAit/cteDch/09EtRKcJQjUD/YXDjtwei86mdgOE5zP0Qo0fGnO
    k0BR2T4p2Z91svxZz17knKGf6uimPFB2ndGSKO0PzMoI7ZkB39kjR6800Pz1N4QqplVhYZ
    afTao0MAQ2rl8+7IeAw8TXfwojhwXDfScEqLTdbGuOJlDfNw1e7XgHr1UHkNXDZlejuQKo
    ngAXrRITy3QN9cOuCaXm65zRYI9uMY5ToCREj9tbcKvZSI05y5kepDsPsrTdMCVdfKniBG
    L9OqIuirGNN19C1R7r46fB4XKfmmiD73GqtXhsbC9SdUNO8R2lwYbfgvt4Yh4EPqtm4Mb8
    S4uOm8anaDec75cf3f/L2S4kBhm7f3YBKLb6po7RQdUbu9ftwxpT7w5ZxPkaRlUxfOX7/r
    TOT/yG388KRG78oOmm3tNST+S8rEq7gBXLeIfml139I0arinyTZ11JLeHCMn0mKeI7aOeq
    mj6NGn0UpEIYb/VBM4jX+x7nNBhMzUkSjAAsVRNsbwsI0RGhkGN3A+8zLMh3+g0+wpnX+c
    LhtPkTUkaqERYvdN3W4bwzi2IutI2ch1EeI1PpDMbxNodbloGUhs1vYHTvYw
X-ME-Proxy: <xmx:eZ7xattpJnN8jYbMjMG9DJERGCmxGqb7enS83Rv4nzWtFMRCiHvWcQ>
    <xmx:eZ7xaqtwVNhxFRJtfu9qXkRYWflB5KfOfpdlLYipy6u8U-CX3B14XQ>
    <xmx:eZ7xakWOIiOHKnnGVx3RZjt48CU-ihQENKbNQGmXCwzYDGcGZMJ8Ow>
    <xmx:eZ7xajWiUFfnOsfHwc3FvuMKHiEp8QlsEQZchYFSNI64sSmP0xrtyQ>
    <xmx:fp7xamBiY5fAsMHOUeu24oZZRgf290z3cHie107vzrIDkBvksCfDyMiz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id D1DE632A0097; Mon,  9 Nov 2026 05:20:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqNyIDC2Pk_N
Date: Mon, 09 Nov 2026 11:20:17 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Uros Bizjak" <ubizjak@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>
Cc: "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Alexander Usyskin" <alexander.usyskin@intel.com>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Message-Id: <dc861a6f-bcb2-4a84-84ef-b3d72905c824@app.fastmail.com>
In-Reply-To: <56e7300b-cd1c-4fb4-b269-2243394c6df0@gmail.com>
References: <20261105163440.2381661-1-arnd@kernel.org>
 <20261105163440.2381661-4-arnd@kernel.org>
 <56e7300b-cd1c-4fb4-b269-2243394c6df0@gmail.com>
Subject: Re: [PATCH 3/7] x86: make CX8 usage unconditional
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_022059_319698_7A789734 
X-CRM114-Status: UNSURE (   9.23  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


>> -	asm_inline qual (						\
>> -		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
>> -			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
>> -		: ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
>> -				"+a" (old__.low), "+d" (old__.high))	\
>> +	asm_inline qual ("cmpxchg8b " __percpu_arg([var])		\
>
> This can be plain "asm" instead of "asm_inline"; there is only one asm 
> instruction in the asm template.
>
>> +		: [var] "+m" (__my_cpu_var(_var)),			\
>> +				"+a" (old__.low), "+d" (old__.high)	\
>>   		: "b" (new__.low), "c" (new__.high),			\
>>   		  "S" (&(_var))						\
>
> The line above was needed to force address of _var in %esi. This is not 
> needed anymore.
>>   		: "memory");						\
>> @@ -359,10 +357,8 @@ do {									\
>>   	old__.var = *_oval;						\
>>   	new__.var = _nval;						\
>>   									\
>> -	asm_inline qual (						\
>> -		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
>> -			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
>> -		: ALT_OUTPUT_SP("=@ccz" (success),			\
>> +	asm_inline qual ("cmpxchg8b " __percpu_arg([var])		\
>
> Also here, use "asm" and remove "S" constraint. Please see [1].
>
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?h=WIP.x86/cpu&id=8cfdd354dae90a3db46c351d15c801dfbf76fc5a
>

Hi Uros,

Thanks for the suggestions, I changed it all as you suggested now.

      Arnd

