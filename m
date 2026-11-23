Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3D606A31E
	for <linux-um@archiver.kernel.org>; Mon, 23 Nov 2026 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l47YmaFU;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=GUqi7D/+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GeCTSuUL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:
	References:In-reply-to:Subject:Cc:To:From:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o9zLSXJuEnjCYOHrQ29UaL5++JY+uZSugjvH7QOgkgM=; b=l47YmaFUBrjeJYoPt9V8eu1H+P
	E8U1c+XcIOf4120Xs36rJ957dJOWXLCxCSaJ/rxuu45PhHL65SJqimFrmHtLvK/LdTdyvf2u6Pvn1
	OVOf36H0M56dnrjmRWVKvY1RV6V4rAeZhG3iNs5Fz/EnHdBSJ/PNT3wtffKf8vwUwzVJvb7sxfOrN
	Rvk5FJUfQHn+mbEEkp4QNeOecFbPyctZDP5jQqTKcPDuBsE3guvobfGcAyrOHxeXitiyPQ4e8GP8H
	5F8ocBba24ti1sLuzdoyzW9B6o50/FCh9OZgxrY/c8hHyHdb0bPSBk6cggSDT9w/UJZyLNPkqNaa1
	uej9AqQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVayJ-00000004siK-4ANj;
	Mon, 23 Nov 2026 20:49:07 +0000
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVayE-00000004shd-2J7u
	for linux-um@lists.infradead.org;
	Mon, 23 Nov 2026 20:49:04 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F6C5EC1FFD
	for <linux-um@lists.infradead.org>; Mon, 23 Nov 2026 15:49:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Nov 2026 15:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1795466941; x=1795553341; bh=o9zLSXJuEnjCYOHrQ29UaL5++JY+uZSugjv
	H7QOgkgM=; b=GUqi7D/+zOLrqWSCzm+MYwrgGUjLKLl+XyO3sqEMlbWx7SCD96N
	xOr7y+zBHvOJU64RURKgirlFowf3Nwr3aEDK51YyBQlTYsXZPHXQBIekNZKCnUv4
	KsJ7waiQTqtIfKfIciO2t0+seQCxjIoBE/jzWA+bLsUFuvppgIe1oUUDuduARfs0
	t3JPhbBc3ixP9z2lo3LiqRiZ6svS6iP3JqTZaE4IPjo6wwG/9Hk1S2y/EdvPD7i7
	VeW9Ha3EU2WYxmJ3DxwIb2mHDAm2WO5nWwgvgUT3UiPRd1agj+ERpo+8YO9P8RIa
	pHNuAA3m5BdklG2F+1juF+ysaWNVwkdTd2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795466941; x=
	1795553341; bh=o9zLSXJuEnjCYOHrQ29UaL5++JY+uZSugjvH7QOgkgM=; b=G
	eCTSuULw905Aod95KYVphrgcfjTxFP0oxax/QIzCt7Z08DmPbXq87xmjvsq87B1o
	T7FpSf/jOkxbzNfI9K9UvX8+L+n3jzN0UFd38r6Kqug7Mikbl1O/2EmrG2SO3FI1
	KHnotRnxKL/i6//1NMYSCNNAQD5Lw8zQIP5We+msQKoeN8HunYpxYa/NgEin0FBL
	OrwyXhfhr1+ovrOEMzpq4EqB2X4zDBEfT7EuPoC4GZVcDg7QuNgDviNaNXLJmX39
	10qq1kOBTAvLEMe0kGmTgufHnX1lPRueLiduAXke6LIBKcNxkA/MXcp84nvwDaqA
	INQFdl5CmGnTdw0oHc84w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795466941; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:nKNHBFQwr6ksG/KqKOR4R2/LADVwmltxlliTMt25a4yenxZ
	xzveqTEE27lRSVW20IGe9/99LpsPvPzMs8hLWATcT9cHA7vAXPI5Gkedixsszjyz
	fBPAQGgG0b5BR1EMZW7nMM6YUtYo/vtpu5P11OQ8Dovd9Bm9X20PgEBiGBsz3M0V
	KqMlWPrrWyCFk4cals7OuTzS1d14ZbAg9tRx3H2J0O9PX+IPGzoRZtLjaBR3HUO+
	HKdYetKWt0PkxQdnx90vxxhfxGTsjEnt9NvX8GYgSuXT23beqCOCcmjF9xJePv3O
	p9KhYo9g5djGyjlsMan0NcYs75dEvgs3DiEC3/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:iRsZPrvVIwPX/h3pXgxfTnT/eDywSz9BnLpkefyq+Ow=:TQjb9nmWbWE1VynL6JHeebg3yoN+S4zxdXHZHN+WKgw=;
X-ME-Sender: <xms:u6YEa7TXivWPuJUmQwTofE3_mOq1Vd-dGbfdKdCpR8XRf4mdVhKkOA>
    <xme:u6YEa-FAq9luXdWY2R16GtwHX7z9lzSVvh-3xidwqcC_0YdC1p2FjR8MM26AohERW
    8Y2RTcrRVy8N0Cfpe0u2k3jK-WQI80vUAOYxgi3mQC340Hcf-54>
X-ME-Received: <xmr:u6YEa1fKzxLr8_1Q8wvmXU9XFcWRl1eA7ksz9FFvxFJ4ilMV2X37c48RFAVhVI5O2MjFjpePCFj_Mpy26V917zelIABh1kc>
X-ME-Proxy-Cause: dmFkZTECMQJK4fdkHy0fWLPUcFTfrq9t91uSnuEGiUSnuJVoCkINLH+FzKpB2tSIh00Nhk
    5BK9SRt/YA6/FrvyPQt1zAAzcR5cOsyqFz7nx9uu0f4KSe3wR0kPiRBN+OVBWFQfytz/nn
    yyGl8KiMZ8B/aculVSmccW/8zngN0Q/vdl6AlkON9HCNZS3RB6++ZKfrcMUpGub8gwOvLm
    AfxvFEkzIq6zthR7ARiUVw30kV7XdmJ780kxcA9EMVKyogzFKXYyTyYLNb86ZISYUb8d/z
    rFvorNZzKKTgs8fkSA6/DEx90/h/JJKzOE5MWqhdr2fZujknKzF4prwngvHkH/gzMXhOjI
    W2qJFidfdQhutil75qA7q28SL5utgHyPCYjGk3jbYPNIWOTW+lgKSOHM9PFUOVE4MR33Yb
    yQOG+YP7xrsB3fg8W8oObe16vE6p/BlLe0wvL9GnHvZqPldBX7whsOfLYvg8K3vS3y7Ztv
    vtLFOJ6eyHRKhRwQUJBelmJtRhZB0ya0x0/gCpihCgyIW69Pz9HM2foCdkHyEPxE8i33+l
    gb6gKLN69B9x5kOtGKlbuEucLQnIluC26ckmgsXzWq+85qJTrQQHreucLfGmT62E6CMJmN
    wfzX1snjy9o8lEEGvvcxDAvGTgc3an/ek3fbgvvdrM0gP8oQwfzLkuvh788w
X-ME-Proxy: <xmx:u6YEa9v4MlfSFvBYUW3AaaxOuVN6K8LRsbr3wpg2UnQhGQakfgongQ>
    <xmx:u6YEa7dUUoaxCTu3vhu-0mhfleuvvFLqCPMmBXEj7KynRAJsHDJseg>
    <xmx:u6YEaxpDSw_mNUDwFA2fQi7eSu1e-qmUbgp2qhZsZ4P45ocBhlqw1A>
    <xmx:u6YEa58xC17HGroqH_gvx4Lperpo4blG6Pv2gD5Od9dlgym1vNWEag>
    <xmx:vaYEa5q6WPtMSV6UnT0CuFMsOg-aNwZnOEi6QNWbCtNynKKtn7P9IXVR>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 15:48:54 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Harkes" <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
 "Jan Kara" <jack@suse.cz>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Hyunchul Lee" <hyc.lee@gmail.com>,
 "Carlos Maiolino" <cem@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org,
 linux-um@lists.infradead.org, ntfs@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] VFS/xfs/ntfs: drop parent lock across
 d_alloc_parallel() in d_add_ci()
In-reply-to: <20261120-veranda-tiger-seemeilen-397d57fb2258@brauner>
References: <20261117000115.1433875-1-neilb@ownmail.net>
  <20261117000115.1433875-2-neilb@ownmail.net>
  <20261120-veranda-tiger-seemeilen-397d57fb2258@brauner>
Date: Tue, 24 Nov 2026 07:48:49 +1100
Message-id: <179546692990.1728055.10797595669821351188@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_124903_017227_9052741A 
X-CRM114-Status: GOOD (  19.91  )
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
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 21 Nov 2026, Christian Brauner wrote:
> On Tue, Nov 17, 2026 at 10:54:58AM +1100, NeilBrown wrote:
> > We don't need to keep the parent lock held when d_add_ci() is run - the
> > VFS doesn't need it as dentry is exclusively held due to
> > DCACHE_PAR_LOOKUP and the filesystem has finished its work.
> 
> I'm not sure that holds? Only d_alloc_parallel() honours
> DCACHE_PAR_LOOKUP. lookup_one_qstr_excl() still uses d_alloc() and
> relies on the exclusive lock to guarantee that there are no in-lookup
> children at all. That stops being true here:
> 
> > +		if (lookup_flags & LOOKUP_SHARED)
> > +			inode_unlock_shared(d_inode(dentry->d_parent));
> > +		else
> > +			inode_unlock(d_inode(dentry->d_parent));
> > +		must_relock = true;
> >  		found = d_alloc_parallel(dentry->d_parent, name);
> 
> So if "Foo" exists on an ascii-ci xfs:
> 
> P1: stat("FOO")                      P2: unlink("Foo")
> lookup_slow()
> -> xfs_vn_ci_lookup()
>    -> d_add_ci(dentry, X, "Foo")
>       -> inode_unlock_shared(dir)
>       -> found = d_alloc_parallel()
>                                      start_dirop()
>                                      -> inode_lock_nested(dir)
>                                      -> lookup_one_qstr_excl("Foo")
>                                         -> d2 = d_alloc()
>                                         -> xfs_vn_ci_lookup()
>                                            -> d_splice_alias(X, d2)
>                                      vfs_unlink()
>                                      -> xfs_vn_unlink()
>                                         -> d_invalidate(d2)
>                                      inode_unlock(dir)
>       -> d_splice_alias(X, found)
> 
> IOW, "Foo" ends up as a hashed positive dentry for an unlinked inode
> that nothing revalidates.
> 
> open("Foo", O_CREAT) then opens the orphan instead of creating a new
> file and O_EXCL fails with EEXIST. Do a rename() instead of the unlink()
> and "Foo" keeps pointing to what is now "Bar". ntfs gets there the same
> way.
> 
> Before this patch lookup_slow() held the lock shared across all of
> that so start_dirop() couldn't get in between.
> 
> So afaict this needs "VFS: use d_alloc_parallel() in
> lookup_one_qstr_excl()" from your RFC to go in first. Unless I'm
> missing something obvious.
> 

Yes, I see that now - thanks.
And that means we don't need LOOKUP_SHARED at all.

The AFS patches also drop and retake the lock, so they need to be after
d_alloc_parallel() is used in lookup_one_qstr_excl(), and also after the
d_drop() changes.  So I think I should combine the AFS patch set with
this one.  I'll try that and check that it still makes sense.

Thanks,
NeilBrown


