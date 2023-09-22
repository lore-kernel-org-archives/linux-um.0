Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AD3CD4854
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=COqMYq0KowlgTftjgOz79qxJNN2drkAG+xQmjcbCE5w=; b=DJQ8SW7BNgSwTR
	aLTzNRjcR8/YYq2XEBrpU9fKK/fPLm74g0mlZTywephYQJv1LzifNsEVqxnlGjQMuh+b3qYtYiVD1
	+ESonGtCl5qfYw23k4jmQRD1YwLeoxeZX50MRr77Qrgzrn2OFQJ68gqNeNTeuVPpO+nQEi1eMHx7j
	N6PY9XwojHEvgl0ApNWKcwq6v+ivjz9uIMBtdlebKUk+WQhCYVjPIpmI/J3bDBwzadRk+xz2hWcqx
	cJXAS/llIVU8Q+xOSdPOxmlBCr2kLUNHQSfPAYhwdz8gAKJwHc+Vt32kJVm+zCOR9m3SNJXn6qjMV
	qjUPIXZPA/2yVfn5EV2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjlrR-009iTs-1X;
	Fri, 22 Sep 2023 19:30:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjlrN-009iTU-2z
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 19:30:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kVX6gtPXNYDJrGyW3mncNGrPxv0nYeKgiJaD9DH9SJE=;
	t=1695411039; x=1696620639; b=Ut8+ufTpRIhl+Me20z4YX6Am3EKTyLfIkpBWH5OKmks5yn5
	iQIV2c6/cdU5PbAJQ1LMlqXSWAY2DWP0CvwejwyHyW3z79LrG7ar/YFGuhZwYdR8TaoPCtrylIck8
	2rGwGSx2cgoFkiEYl6bz9zuY+/DqwL75OyeDKJ01AY7XAm9wrsOmHhvtttdrhd2SkC/FIYDRnyAT8
	D7r/WW4RhIxcoVjB1tjDzm6FTfjbUdVTcAKo2XX+zC51iGaJvGJ3tTQ8p9z2pTY3rRuheDCW6hS81
	ezDdHDPwfxbb3awjt2RyurwMmxwzCE6OGZXYe6E+G/fYspMO63ndBzxdEPvso8AQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjlrI-00FhOY-2X;
	Fri, 22 Sep 2023 21:30:37 +0200
Message-ID: <c035e1648328db216fa5f34b4b9ac8a5f0bc82a1.camel@sipsolutions.net>
Subject: Re: [PATCH] um: clean up mm creation
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Date: Fri, 22 Sep 2023 21:30:35 +0200
In-Reply-To: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
References: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_123041_984155_53CA50E7 
X-CRM114-Status: UNSURE (   8.47  )
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

On Fri, 2023-09-22 at 13:16 +0200, Johannes Berg wrote:
> Note that this fixes what seems like an issue - we look
> at current->mm when we copy, but that doesn't seem right
> in the case of clone() without copying the MM. This is
> probably saved by the forced flush later right now.
> 

After finding flush_thread(), that's clearly not true ;-)

But that basically leaves the only thing slower here the
start_userspace() itself, i.e. basically userspace_tramp()?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
