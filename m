Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94688C9833F
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02NkiLZ5Yl+geke3aOQBTOObyOxc3CSY0KX9P536iK4=; b=wDOGoE4QYgK1Q/P+b0aoeYvBqQ
	25Sp8k7KvetAkmyRm56MIxDCf/RHXopHXSnpRqRwmI52CA0zKrhYbLwjbGV6QEMN0aewJGloh88DS
	uRB+qTYzQbrksIqhpf/xknNxA30G026V1b4mEiNhWsoT28VZGaNiiDc6pjbQuEuPvVJUQFge6xIsi
	1ESIAEnXP4xzc0DegbHR9yDON5mpoamCZdMvHpEkKLWuFaQMiI0Imtq2ZDRUtlOQR9XF4n1yfmddh
	4FhRZd0k8+6oExccCYxlJKlQBjBhQhsaqstB8TAnnyMWX135LmVEwzbL36eggCYSP3BqCb7N+0iVG
	pzYnQKlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBAYq-00000000ZF3-2w6A;
	Mon, 28 Sep 2026 12:34:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBAYp-00000000ZEh-2Qvf
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 12:34:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 89B9E600CB;
	Mon, 28 Sep 2026 12:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A6C1F000FF;
	Mon, 28 Sep 2026 12:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790598862;
	bh=02NkiLZ5Yl+geke3aOQBTOObyOxc3CSY0KX9P536iK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dSxO6JyX9ewpqfSZ/qGL9qzm8jbvHsqhuYPo3dHyEMWQIhnJRvY4ShNwHpBRw8pSz
	 QjOrySNheii0BYuwVrEomHYqkBDbKkeaoIWCP8ah0gX3atVajPT2xkVEVcZY7Y0Thw
	 ydxzxmzbW7ZW8Sb/il6objzy+0mVgWCFdyhKlPlrKRMN1roMU/dVLpOfd7dtszs4LG
	 PDxgQ8MiHla7CtLkxhFA0LdMtP/2amF0J+4RQfh/pR6vyqfug4SAYn51aE/5hzI81h
	 X2hlYP7jETKF2ZNFVOQzpwKatli1h6ubPjMncCvFsBI+CN9UZRN3I5B3oxCvAwRHMU
	 hWoPWx07CR9lg==
Date: Mon, 28 Sep 2026 13:34:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-mm@kvack.org, liam@infradead.org, rbm@suse.com,
	akpm@linux-foundation.org, luto@amacapital.net,
	brendan.jackman@linux.dev, david@kernel.org, liuhangbin@gmail.com,
	corbet@lwn.net, kees@kernel.org, ljs@kernel.org, mhocko@suse.com,
	rppt@kernel.org, shuah@kernel.org, surenb@google.com,
	vbabka@kernel.org, wad@chromium.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org,
	geert@linux-m68k.org, daniel@thingy.jp
Subject: Re: [PATCH v3 3/3] selftests/nommu: add nommu mmap and mremap
 behavior tests
Message-ID: <1b2fb12b-a342-4ec5-ad24-14fc761e1e61@sirena.org.uk>
References: <20260926010819.604346-1-thehajime@gmail.com>
 <20260926010819.604346-4-thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FUgMlfZGbL2nwwkW"
Content-Disposition: inline
In-Reply-To: <20260926010819.604346-4-thehajime@gmail.com>
X-Cookie: All is fear in love and war.
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


--FUgMlfZGbL2nwwkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 26, 2026 at 10:08:19AM +0900, Hajime Tazaki wrote:
> Introduce a kselftest utility to validate memory mapping capabilities
> under nommu kernels, aligned with
> Documentation/admin-guide/mm/nommu-mmap.rst.

> +static int run_mapping_matrix_test(struct test_case_t *tcase)
> +{
> +	int fd;
> +	void *ptr;
> +	char path_buf[PATH_MAX];
> +	const char *path = tcase->pathname;
> +	int rc = KSFT_PASS;
> +	int expected_error;
> +
> +	ksft_print_msg("[RUN] Testing: %s\n", tcase->name);

> +		if (fd < 0) {
> +			ksft_test_result_skip("Failed to setup temp node: %s\n",
> +					      tcase->pathname);

Your test reports should use a consistant string when reporting the
result for a given test, that way tooling can tie results together
between different runs.  Report the diagnostic information with a
separate print.

> +	if (result == KSFT_PASS)
> +		ksft_finished();
> +
> +	ksft_exit_fail();
> +}

Just unconditionally call ksft_finshed(), it will check the counts of
reported tests and exit with an appropriate error code - you don't need
to manually collate the results in your test code.

--FUgMlfZGbL2nwwkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq6XsYACgkQJNaLcl1U
h9DH+gf/XjlR+SgNi0hEPMZzdbbYcwqMMLD2xh8C2BKF4e664nTRvVFTUQ4QNNVC
wWPQ+F7q4l0/ZvxPMtcHzH9cNRXNYfVC00Twjn4/rKB06CdAlnug1n1Segzf4nSe
IW0YuguI4jeea+cNPiiG1pXEdH0xhEzS9KQZSByPqg/J10wYT5mki6T952vWEh5s
6uf0QrxiIl8j7gE7buHHahG02LdSNZB9URNdEL7GaPsIN8R3IPLcWE+nvazafr0H
f8k6hg7IRx+gOZ8r60kURDhpP6i8oE6zd/YIp3hqnGLvUEHG7Yl0XY7krzjWpAgI
ylmZrCLJWgbyW+oCgK7db4EHIr7tPg==
=LEi+
-----END PGP SIGNATURE-----

--FUgMlfZGbL2nwwkW--

