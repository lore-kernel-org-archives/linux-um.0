Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A24CE7AB7
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 19:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gGpbIso2eII8dLRAyoGZPaCL00Tuf+mlfrGHCdjOY28=; b=Xb9/NEZSKZNaIV
	PPOwlU/tND1T6an+KsA/+mPY8Ld0VJNUgJWwNs0yzr38sqlPo80//XhFXWK4JbaX7exw8cJHsFGYK
	Rj7PgOXeMDQ7J9pKCCOIXDJO00K2C1nnTfnX0lc7h/Q6zzlhWO6SxWESPj3Y2IHOEkyL+FDfPs7jU
	9xqIxRqOd0YMFJsb/Z89ZECBDXhJc7ZjCbdhwEXkHVdi5XtwBaodVJZtCSm9waO0xmWYQ3VG1LhuE
	UxaOZKFbTm+xUPGa9x5Gy4nFW1elA4I/UTfMlLciVWd8Zaz7v3S53Dt7NLm/L7s1TeJ6UtNn621KP
	qYGNz3AsjRHJhaqQ//Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjm1u-009j94-20;
	Fri, 22 Sep 2023 19:41:34 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjm1m-009j8Q-2S
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 19:41:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FZbxE6pFsjN+ufxO9f2Z/eYihsdo7/KlMgaLlbbowdQ=;
	t=1695411686; x=1696621286; b=gEEMGtO5sJI01h0CGWdAoLlqahFE9rBDcWHJD9swWlNEiHk
	zU3o7w1ZfuTFrNYfUCvj9aVk6h7ysC//IHJ5ofBjztktOJvmg8pFwC7By/PcyjKVeWCmuvQAPmD+0
	SFM9sXOISW27LPgDWc45k4pKpy3zRt6vmnnwZA4idMBTrb3ZXsOMs42cIggWlizoaGYP7L6BTMp6W
	bL3aif8QrZZ19ueHqGnziISVNdHFdZXi6wOO3DvhWCnjbM7m5vbGeSeCoiwjxxtcDj42d+SZ79lbz
	L4lUpWop1F6ScKd5tda6+yelHytaefwVrIlH5leu1T5XiXsNULXggJi0t6LgFeiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjm1k-00Fi4C-1z;
	Fri, 22 Sep 2023 21:41:24 +0200
Message-ID: <ce18cec1dbacb366f2cf74ebc941c9fbc4b1e116.camel@sipsolutions.net>
Subject: Re: [PATCH] um: clean up mm creation
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Date: Fri, 22 Sep 2023 21:41:23 +0200
In-Reply-To: <88e0568b-6860-9042-7f8b-ab53edb4242e@cambridgegreys.com>
References: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
	 <88e0568b-6860-9042-7f8b-ab53edb4242e@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_124126_799810_9179E31E 
X-CRM114-Status: UNSURE (   6.78  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 2023-09-22 at 14:41 +0100, Anton Ivanov wrote:
> 
> It is nearly twice slower than the current approach on a find /usr -type f -exec cat {} > /dev/null \;
> 

Btw, I cannot reproduce that at all - seems about the same in my tests?

Is there anything special in your setup?

Or maybe it's because I'm using hostfs? But not sure why that would
matter.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
