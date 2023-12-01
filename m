Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348CBC4167B
	for <linux-um@archiver.kernel.org>; Fri,  1 Dec 2023 18:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V4WhLPinjYoYiDFW6vZucnM9AP+LfPPFGYSVXza3nCk=; b=ysvdctGN13MdYlpWd6nfrxFSRg
	EZss2ayu9Tem7T3q6WtBdelrZSojZ0gNF4cFBcL6JPEnXOvfnThwkMwor1IkoZisQC+MkH9RJ/bwY
	AN0H9Hcw/IeECzHmvTiyqWaGL8oWNvZLs8mINRFKA6Q604Jqsbjo/CgQtw+9MRyB+tToQPzXqKQxy
	gNhEsOC288Q2mOO1GtBRj4oIz5KLCyduZDyaZF6V/heLOW+Evqtdz+oLdaRDhyGsR/w4oD/uSfdJp
	ro7rf+8FHC3vOZ+9nur9CPRJIBNerCIvpJg8+TVGL9DHXfbqL40e1P8qrDG7EMOY/jGY6bG60hsyi
	8baEu54Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r9884-00EQBT-0k;
	Fri, 01 Dec 2023 18:20:44 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r9881-00EQ9x-0A
	for linux-um@lists.infradead.org;
	Fri, 01 Dec 2023 18:20:42 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1r97ri-0075NL-Ik
	for linux-um@lists.infradead.org; Fri, 01 Dec 2023 18:03:50 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1r97rb-000fxa-2k
	for linux-um@lists.infradead.org;
	Fri, 01 Dec 2023 18:03:50 +0000
Message-ID: <7db861e3-60e4-0ed4-9b28-25a89069a9db@kot-begemot.co.uk>
Date: Fri, 1 Dec 2023 18:03:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: jitterentropy vs. simulation
Content-Language: en-US
To: linux-um@lists.infradead.org
References: <e4800de3138d3987d9f3c68310fcd9f3abc7a366.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <e4800de3138d3987d9f3c68310fcd9f3abc7a366.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_102041_090472_CBEEB80D 
X-CRM114-Status: GOOD (  21.42  )
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



On 01/12/2023 10:21, Johannes Berg wrote:
> Hi,
> 
> In ARCH=um, we have a mode where we simulate clocks completely, and even
> simulate that the CPU is infinitely fast. Thus, reading the clock will
> return completely predictable values regardless of the work happening.
> 
> This is clearly incompatible with jitterentropy, but now jitterentropy
> seems to be mandatory on pretty much every system that needs any crypto,
> so we can't just seem to turn it off (any more?)
> 
> Now given that the (simulated) clock doesn't have jitter, it's derivates
> are all constant/zero, and so jent_measure_jitter() - called via
> jent_entropy_collector_alloc() - will always detect a stuck measurement,
> and thus jent_gen_entropy() loops infinitely.
> 
> I wonder what you'd think about a patch like this?
> 
> --- a/crypto/jitterentropy.c
> +++ b/crypto/jitterentropy.c
> @@ -552,10 +552,13 @@ static int jent_measure_jitter(struct rand_data *ec, __u64 *ret_current_delta)
>    * Function fills rand_data->hash_state
>    *
>    * @ec [in] Reference to entropy collector
> + *
> + * Return: 0 if entropy reading failed (was stuck), 1 otherwise
>    */
> -static void jent_gen_entropy(struct rand_data *ec)
> +static int jent_gen_entropy(struct rand_data *ec)
>   {
>   	unsigned int k = 0, safety_factor = 0;
> +	unsigned int stuck_counter = 0;
>   
>   	if (fips_enabled)
>   		safety_factor = JENT_ENTROPY_SAFETY_FACTOR;
> @@ -565,8 +568,13 @@ static void jent_gen_entropy(struct rand_data *ec)
>   
>   	while (!jent_health_failure(ec)) {
>   		/* If a stuck measurement is received, repeat measurement */
> -		if (jent_measure_jitter(ec, NULL))
> +		if (jent_measure_jitter(ec, NULL)) {
> +			if (stuck_counter++ > 100)
> +				return 0;
>   			continue;
> +		}
> +
> +		stuck_counter = 0;
>   
>   		/*
>   		 * We multiply the loop value with ->osr to obtain the
> @@ -575,6 +583,8 @@ static void jent_gen_entropy(struct rand_data *ec)
>   		if (++k >= ((DATA_SIZE_BITS + safety_factor) * ec->osr))
>   			break;
>   	}
> +
> +	return 1;
>   }
>   
>   /*
> @@ -611,7 +621,8 @@ int jent_read_entropy(struct rand_data *ec, unsigned char *data,
>   	while (len > 0) {
>   		unsigned int tocopy, health_test_result;
>   
> -		jent_gen_entropy(ec);
> +		if (!jent_gen_entropy(ec))
> +			return -3;
>   
>   		health_test_result = jent_health_failure(ec);
>   		if (health_test_result > JENT_PERMANENT_FAILURE_SHIFT) {
> 
> 
> johannes
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

Looking at the stuck check it will be bogus in simulations.

You might as well ifdef that instead.

If a simulation is running insert the entropy regardless and do not compute the derivatives used in the check.

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

