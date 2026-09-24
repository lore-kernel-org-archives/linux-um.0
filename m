Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC43C98318
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Otb6zuyEBZINlapWeW9EeZO0ay5u9oRpGgKAiyNCSw=; b=w6zqRHpk/sEJUSK7Jzvj/cLhFn
	ANatIa3Y/jCH2cru7bVH8wk29iAKVqGSKpyofML804uzeaCEXsRZwY72KS7a6ot8MAzZQ0s6QqgpO
	JE39diGPTFzMxiNq8dDhg+6YpDxXtcCRqZIym+TVLeVhkOOfCVt1ttkZNlmQwH40phouKIf1dnf9Z
	em3o9gXvGjm0z530kMTPk/L0YLsIxoo4wQxkxljEAKU+GyqQDTMWZ05896RUhMTZdlNwqePhAsIy3
	5313MMTEv67YUzXCeKKpOF2JrXTjC9nKhveD79n1OZc6tCRoe59Ols7atbIErzDOxCjmQ+aQGevjI
	wUUMNXtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9m2w-0000000BYjR-0DaE;
	Thu, 24 Sep 2026 16:11:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9m2t-0000000BYis-2kgY
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 16:11:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9Otb6zuyEBZINlapWeW9EeZO0ay5u9oRpGgKAiyNCSw=;
	t=1790266299; x=1791475899; b=YFrEdJ0UU6Nxx999OgDKMB/ywH2T1FSplnG9un23RIY4k2d
	cpou6H2eGqbBYUAvAYdGylNagmTQGOOhRZVSN5jB/cfnCok1Kmlr4StJgk6ogcczaW8ZYwz2C1a1s
	u159mKgBPebiIsJ1t1ja7aaxjZErADwNy2JZcPkqLGQiWTUDbW266udEJij/DyImEbSHCZ7DthQkS
	2ZhevruJXUHDmaJKtuzlMual46bu/0ekQ3ZlsG+S4FfWmGZk3N9GaM/CZwDrwEyUdmCQvRv1aZhp4
	ghsyXPuXpJb4C4sa10oWkm7OEpRM08oeKRCwnUA3QzqsP82AMYa7M2wkiuoivQ4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9m2m-000000099JI-1OEh;
	Thu, 24 Sep 2026 18:11:32 +0200
Message-ID: <5da91b32a633e82d89a4c504c06d12e51507df3a.camel@sipsolutions.net>
Subject: Re: [PATCH] um: ubd: perform the flush the block layer asks for
From: Johannes Berg <johannes@sipsolutions.net>
To: Mykyta Bozhenko <caudadragonis@gmail.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 18:11:31 +0200
In-Reply-To: <20260912223932.2941631-1-caudadragonis@gmail.com>
References: <20260912223932.2941631-1-caudadragonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_091139_995338_23C0154D 
X-CRM114-Status: GOOD (  20.81  )
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

On Sat, 2026-09-12 at 18:39 -0400, Mykyta Bozhenko wrote:
> ubd sets BLK_FEAT_WRITE_CACHE, so the block layer sends it REQ_OP_FLUSH
> requests and, as Documentation/block/writeback_cache_control.rst puts it,
> the driver "needs to handle them". do_io() does implement that: for
> REQ_OP_FLUSH it calls os_sync_file() on the backing file and maps the
> result back into the request.
>=20
> That branch has been unreachable since commit fc6b6a872dcd ("um: ubd:
> Submit all data segments atomically"), which replaced the single
> per-request do_io() call with a loop over the request's data
> descriptors:
>=20
> 	-			do_io((*io_req_buffer)[count]);
> 	+			for (i =3D 0; !req->error && i < req->desc_cnt; i++)
> 	+				do_io(req, &(req->io_desc[i]));
>=20
> A flush carries no data and ubd_submit_request() sets desc_cnt to 0 for
> it, so the loop body never runs. The request is handed back to the block
> layer with error 0, i.e. the flush is reported as completed without the
> backing file ever being synced. Guest fsync(), fdatasync() and journal
> commits return success while the data is only in the host's page cache,
> and because no ordering is enforced either, a host crash can leave the
> image in a state the guest never allowed. The error path is dead too:
> a failing host fdatasync() cannot be reported.
>=20
> Measured on a UML guest with ext4 on ubda, doing 20 writes of 4 KiB each
> followed by fdatasync(), then one fsync() and one directory fsync():
>=20
>   before: the guest sees 22 successful flushes, /sys/block/ubda/stat
>           reports 16 completed flush requests, and the UML process issues
>           no fdatasync() on the image at all
>   after:  the same workload results in 43 fdatasync() calls on the image
>=20
> os_pwrite_file() is entered 131 times either way, and e2fsck on the
> resulting image is clean in both cases.
>=20
> Honouring the flush costs what the flush costs. With the image on host
> ext4, 400 iterations of write() plus fdatasync() in the guest take 467 ms
> before and 2007 ms after (medians of five runs). uretprobes on
> os_sync_file() attribute 1.597 s of that difference to time spent inside
> the host's fdatasync(), the remaining data path being unchanged
> (os_pwrite_file(): 19246 calls in both). A 64 MiB sequential write
> followed by a single fsync() goes from 278 ms to 362 ms, due to the
> periodic journal commits. With the image on tmpfs there is no measurable
> difference.
>=20
> Users who prefer the previous speed to durability can disable the cache
> per device:
>=20
>   echo "write through" > /sys/block/ubda/queue/write_cache
>=20
> That is also cheaper than the unfixed driver, 326 ms for the same 400
> iterations, because the block layer then completes empty flush requests
> without entering the driver at all.

Yeah, you really need to not let LLMs write commit messages ...

johannes

