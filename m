Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0071CA5FDD
	for <linux-um@archiver.kernel.org>; Fri,  2 Oct 2026 06:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bvzqwuTjdPy91zWm37KIYjrvoEq9pY5JTP911vnp5Bg=; b=h0pJ6C85YHUYc6iAbQvzKWb9is
	BjFAaePVwpqZWx70H3ihf+8xzpEIGoQRu5L4LraljCqgS+Uei16ZNmYBKsQY6TEali2YLw/o0LI9i
	Az7J1gW0Zq7C3hu9yqbuHFTLdNhnDpkrGJDvNhv3r4pegBgaDMEoaJkVKWNrkGfrkJoN0JJstk7HX
	w9M6yyX6Gc/dBhVAzoJTgfO5aJoZ/1mZfYFa/wnmPBh58EgoQRvENgvkfBZehqxfSYcktRY6QWivj
	qrjGz408EAXyUFAWONKDlWSL4E+QVCCvGpYrEd6K6aPaQe2A0CEOQ+YePRWz5hq7ZzjFFZ7zqv0wB
	0ZOEAXJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCWKv-0000000AgIL-3RD5;
	Fri, 02 Oct 2026 06:01:37 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCWKs-0000000AgI0-46QB
	for linux-um@lists.infradead.org;
	Fri, 02 Oct 2026 06:01:36 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3a02551822eso742989a91.1
        for <linux-um@lists.infradead.org>; Thu, 01 Oct 2026 23:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790920893; x=1791525693; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bvzqwuTjdPy91zWm37KIYjrvoEq9pY5JTP911vnp5Bg=;
        b=s+onpqB9HIGyZpHHIiPZjZDoxh680QcxzT72u6E1cjKe3svfN4PbOJBDRQoM3G1ePM
         QEEFFNQqJwmvWfwPEF4F6OhLyOXzq/ZzyOawgAZ1OszHjBpoPiW9HHers2OW6jx4Xqb9
         80+CqcEj4ByVtIO1Z2B2dcFdqUrmljPmS6vTL7HT7xKaJyGtmi1kqFcqD2VO31FhFMFV
         VEH0EsuOefvZTzuma5wSxyQx89Vf3Gfh2y8uuo2CwZM6nxv0+5C1zu1jYniAaPlPyilT
         SdJx3n/niFkWJFddt5ZPSYxESvmaMJVWx97k8d8fFJ/e4KhWmI0q71fcvTpmGEe/L+xZ
         NYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790920893; x=1791525693;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvzqwuTjdPy91zWm37KIYjrvoEq9pY5JTP911vnp5Bg=;
        b=hpit0yGTS22Gyq+EVwplvIRxW1hdzZiOdnZk8FL2Cf2LhV5WCiQoTFjVFK8Jga25iL
         lEj2Qj5d+Ad5okJKxmQYy/LOBDR7k/GLtWXB2PfjNZBgNWgP707nbnrQzg72YtCw7JoJ
         RDCxwyj5ndW83YBO4qO3jd7N4+MOjDaRoumOkGdPEaa2qPN5011cvf1uav3cE6rt2+/q
         90/K6qOZkfaVsvTTRT+DZPETEsxausZPJpws+SxTZOUbAqkWiH2wHCLVTislQM097YLG
         hrM4Ejf2O3QdNG3ATKEb62oNkKcUZlLDb6no1hAwxRyPja8YTfdjycTTgYIAU3/0crJh
         yo2A==
X-Forwarded-Encrypted: i=1; AKwUvBzi080r59bWXD28hWQ5j91ceATgh5kk8bUd+07bTVyyKTjlgIY9ZValLvKQXLRfP+LWOAvwbwgmkA==@lists.infradead.org
X-Gm-Message-State: AFq9FYL3GeTYoq0woTLj0dru/ziPZcTDR0AqE6ezqBmfBuRKAl/XRKLa
	Pa5IqwkEcAcsjVZMotrheFOry0C6/CGTc8GMa8qbOrk1VRxn7bhFDeum
X-Gm-Gg: AYBFou1jCGLeNlebpmwPEH2zVOGkSue1q5qdLL+GWCLCI76nSyV2NCJ2qCFijG8tgAB
	1xNPmV7tEToDHrjygVs85s9p8CwbhaI8I4r6RIy4HmXLQLtbjGCNblPjlA4+/m229PWvNgo+qLG
	g8Zlq3imqJciiDBSOCxslMYgNY9+QNzGTAeHyZAHNpIpbQ1bil49gek6BppycRX8EDHJBjR9yzW
	S39h9qLJoNZplJOtV2Ba5BX8qm7JBCUlUGTZB+Eaw7Mt4cb4qXasXFS9FPVQRELaCoC3VF7teAj
	g7qQo6rmg2jMtgA/aJbFvqddPPfrwMu10sswv7WI8s7ZJ4q1YeR1g4vxWuqA6pdO5AbsJ8ogyGc
	LnEa2jU89umkfB+s49hE9dyU9qI5YgwNfpffsAdzvdERHu/ldey1ahCkN/qrOo9Ub9Dx060A/6i
	G0STTwbviTI91JblFP6JXKhK00+X26GyGGXak2N0e3UCAgTCYufL/7jF0V0fEi
X-Received: by 2002:a17:90b:2644:b0:3a0:f2e1:8af9 with SMTP id 98e67ed59e1d1-3a4f3d124f2mr3588321a91.52.1790920893294;
        Thu, 01 Oct 2026 23:01:33 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f721a6afsm519169a12.0.2026.10.01.23.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 23:01:32 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:01:30 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-um@lists.infradead.org, codalist@coda.cs.cmu.edu,
	coda@cs.cmu.edu, linux-mm@kvack.org, ntfs@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/7] VFS/xfs/ntfs: drop parent lock across
 d_alloc_parallel() in d_add_ci()
Message-ID: <ar9IuknaJqrGoF-j@hyunchul-PC02>
References: <20260929034158.1455429-1-neilb@ownmail.net>
 <20260929034158.1455429-2-neilb@ownmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929034158.1455429-2-neilb@ownmail.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_230135_044955_F8F9F252 
X-CRM114-Status: GOOD (  13.34  )
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

On Tue, Sep 29, 2026 at 01:36:01PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> A proposed change will invert the lock ordering between
> d_alloc_parallel() and inode_lock() on the parent.
> When that happens it will not be safe to call d_alloc_parallel() while
> holding the parent lock - even shared.
> 
> We don't need to keep the parent lock held when d_add_ci() is run - the
> VFS doesn't need it as dentry is exclusively held due to
> DCACHE_PAR_LOOKUP and the filesystem has finished its work.
> 
> So drop and reclaim the lock (shared or exclusive as determined by
> LOOKUP_SHARED) to avoid future deadlock.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

For the NTFS part,

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

-- 
Thanks,
Hyunchul

