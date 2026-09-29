Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715E7CA5FAB
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 01:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WUJtE1tO6F+vL+F/po6RA6UlyIObXL7Q50q+l+HvqRI=; b=rnLuw8VBAQV9Hs/uP5kfVn0ubw
	A99RwWYbXY94zZzsK7u6CaP9TMB+BkET3/CVSK04FWPMWviDZwQj0Z2Sj7GEov17Y6Z6Ij36JBDMg
	ackZ+2zdcFo8eSebiWMtwrFxb1Le1gB2psKwV8grMC6zAj1PNDq771WHJCaPgcG+oyFZlGHelzWHX
	KYr3XoJJaT8Xy8nYim0FHLJCsUO0WiwrxIcmuryYW+n3gdwy1p1/Xq//sw0OxcfuF+EBkCFTvvKN3
	PHAU5+ciPXEDftr7SQDCGWJXYZeH6kXnYSsw4yn/xPGHU0JYWdTby+SywNPx7aePHIDVG6kmegM9D
	/i3jsImg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBMIc-000000020Um-0e6V;
	Tue, 29 Sep 2026 01:06:26 +0000
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBMIZ-000000020UN-20X1
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 01:06:24 +0000
Received: by mail-pj2-x0d.google.com with SMTP id d9443c01a7336-2df958a8272so14131825ad.3
        for <linux-um@lists.infradead.org>; Mon, 28 Sep 2026 18:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790643982; x=1791248782; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WUJtE1tO6F+vL+F/po6RA6UlyIObXL7Q50q+l+HvqRI=;
        b=RcFZKgMILgdyxB793PDJiT4bQB2QayGJGP0S5p3Sf0sGU8Z2yjAnhqV7OyptbV/P4r
         yWXLAYfIRm+gKecR6xNcMXYHaG0dMKI0QeWePceKCW3O8orGbLtX7/94MNwHm017ArJA
         czJbRN0AUyZzjrMyoc66EdA17eWMni6/eiJc66RajJbBPcJ2l9TaIGiVdx5W/mKoHGqr
         eJTePckmMsUlPns7he+6JGZcFMRQ4dYGIwbkL27DU6jsB6VlgykF+ydXqv2WVZdZKIYh
         zQXNLd4dsQtyWqECsk9v/ZsEPAi5xBIQkp8rL4Kd28kXw8UZvh38bFqARo6IFEL3iH1b
         pxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790643982; x=1791248782;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WUJtE1tO6F+vL+F/po6RA6UlyIObXL7Q50q+l+HvqRI=;
        b=hwA5crMutWmSLAB+FZ5+WEWPOg7SY5IU5dnVZX8ftIRlayAl4lL+I31pY9USoStTue
         9D5uxpLGAqNO0hG1RTbBi39CAytw5eAxztKYPUBLJutZo6QQfQB6MNXWgizUH6fMQTd2
         yl3NkUjKBZ6WBA/mBKkUwtWQiUeJtVAap6USyI9Bt7AJXOKqFUyqErR0MfIiGbgGEZqX
         72a+T6yLqiEnCM8UCzT3Qt9BbZJASbKzcTR88I3MKwa8pGVoJt0ELPHOD2lEDmHrNZQ3
         1YSA/RcnVvsOSECIwmaLRw3zrpSfjJWboijpJ5/cKTz/oJGnv80nXSpG4lYsXsC2ZkSt
         6RqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLrJZ0l5OpvK+CTa8oEMQWTZK2J9O3lfOL5C6WmvDw+vYfUq73nvQc+CK2hszVnPSyOvnLkNoMmA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJasgWWwB/iXZwL7q9weI5knf21sdPzo5le4yn09S3pW9mjNcjN
	T6INcoB7/iQB6r5XCO1VSjJIz2wcEb6UtKD+9KTKmfivVtxilTL6wlHa
X-Gm-Gg: AYBFou0rVUOIRKPs/BJyxJ7W7KuUcVeIrK7CRZPLMzfcFNpOvrap4vtd8UMvI2c9kZX
	RjdgM/7Nh0FXhlcnG232QeA9TxngqGaU3VomTIDt57qDZVpillMH83znJP+tY2X29liawgLsKa6
	LbNQoGjRgCGorf1BqLE6HdtgfDod70Uc06RhvoywAvO10JvLPxv/yrycMv8L8pk2NgF1G+FDsVw
	z2hG3dt1HRxkiG+QcuWLzwnTnbAQY0zhp3MVM02STXI0TzX7G51HD/OnnKFuGmQKli5ZJdKMbDt
	nB0dQEvtTjGsECl7wJbk8ur/e0kLXeaiar3F/QXbbUFAI2Zh7YXk6+LXcDrw1GljHS+tW9PiMsP
	T4AqwMQrVZ3V72X4qYVlyEY5woXbAYMC9SjvJwXBgj0EdiF4VcRZNjqfopQfnhCql+N2EIhQAwN
	1Mp6rRUM7Uydwv4TjQ8Ux5ETf4OVUm+ghaRwWuc26wDJnG3LAvYeW65ez0ML1bbwKEXBS+hVbCX
	3U3/Bc1aC7Loj4RwAeDx1PVQlLEwpty1IGDl19B8+zX2fKeBVsZTq5qtfq5VXO3VoBIOr54wPsi
	zT9UqiRJNl0x4jm9hv92jx0DtOqDiwJKotI7qPvxzpbS75JVXKeKAzrZlUCxXxinENV72C61kUR
	p
X-Received: by 2002:a17:902:ef44:b0:2df:9f1d:4552 with SMTP id d9443c01a7336-2df9f1d624emr74517675ad.52.1790643982418;
        Mon, 28 Sep 2026 18:06:22 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fbbd2asm48234105ad.12.2026.09.28.18.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:06:21 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:06:17 +0900
Message-ID: <m2wls43lyu.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: broonie@kernel.org
Cc: linux-mm@kvack.org,
	liam@infradead.org,
	rbm@suse.com,
	akpm@linux-foundation.org,
	luto@amacapital.net,
	brendan.jackman@linux.dev,
	david@kernel.org,
	liuhangbin@gmail.com,
	corbet@lwn.net,
	kees@kernel.org,
	ljs@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	wad@chromium.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org,
	geert@linux-m68k.org,
	daniel@thingy.jp
Subject: Re: [PATCH v3 3/3] selftests/nommu: add nommu mmap and mremap behavior tests
In-Reply-To: <1b2fb12b-a342-4ec5-ad24-14fc761e1e61@sirena.org.uk>
References: <20260926010819.604346-1-thehajime@gmail.com>
	<20260926010819.604346-4-thehajime@gmail.com>
	<1b2fb12b-a342-4ec5-ad24-14fc761e1e61@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_180623_525979_68A2A1B3 
X-CRM114-Status: GOOD (  14.69  )
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


On Mon, 28 Sep 2026 21:34:15 +0900,
Mark Brown wrote:

> > +	ksft_print_msg("[RUN] Testing: %s\n", tcase->name);
> 
> > +		if (fd < 0) {
> > +			ksft_test_result_skip("Failed to setup temp node: %s\n",
> > +					      tcase->pathname);
> 
> Your test reports should use a consistant string when reporting the
> result for a given test, that way tooling can tie results together
> between different runs.  Report the diagnostic information with a
> separate print.
> 
> > +	if (result == KSFT_PASS)
> > +		ksft_finished();
> > +
> > +	ksft_exit_fail();
> > +}
> 
> Just unconditionally call ksft_finshed(), it will check the counts of
> reported tests and exit with an appropriate error code - you don't need
> to manually collate the results in your test code.

thanks for the comments, and I understand all of them.   I will revise
those in next spin.

-- Hajime


