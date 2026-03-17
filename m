Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9863F3382B
	for <linux-um@archiver.kernel.org>; Tue, 17 Mar 2026 09:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XMAS/3KJsstwA3paQv6TW+kjF9gkITW3NZUnc7bZnuU=; b=2Oh3y9ElrWaYOMEQut2FlMbsGx
	wRMIWMsS65UY9WQBmzNmqcUwSMcef+fJF4dBoHinvwCjOkEqDq1K6IoNWd+TsXGli6FH3U5bc7vLr
	vCscrLHZ4kEcrBkzfAFdEIOB7siuQdmvm40o1li6ee4/vH6Z96i7fVJhAfnvxV6Zc+OZXNcSxMYY9
	MkWOHIVzdtZwIs09xNhqBvJVzUnwGuc1KAIbuOlGpPY9vOpV/HsxEnQWzRxYSp4b3lta7swRSlOyd
	IM13jvq0M/KDHLdriGdt1JPxttPE2+MaaRUp5HW/BA1f5YUnSWmElYTrtHy7RaWkXsCOlvyKi3mvC
	NAORJTeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2QsF-00000005uFq-1AFQ;
	Tue, 17 Mar 2026 09:38:03 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2QsC-00000005uDT-27NJ
	for linux-um@lists.infradead.org;
	Tue, 17 Mar 2026 09:38:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3F85BD96;
	Tue, 17 Mar 2026 09:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773740275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMAS/3KJsstwA3paQv6TW+kjF9gkITW3NZUnc7bZnuU=;
	b=A+0DMHAbfbhM8MnlBUqVL+W87T4tqLjqUGgvxNRqk88xckeEeRm82e+ypnsFgad4/XiqOe
	eFQnLDIV+dM8cXwaoMX9AvcuSz0XaJOKBqB0bzHsm6RA5PfmHqn2hYLlC9HiNT/X/xWX3q
	BqIvjViI9CtSct4EF5Es0QJY/LKW1HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773740275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMAS/3KJsstwA3paQv6TW+kjF9gkITW3NZUnc7bZnuU=;
	b=xmUefSO9ArclnNvP01TmJwVa9hwB1H9Ezy/G04E5yEHJeukkDoWlTMUncfdfe52pgfQsy2
	oR1nH2U5mzv18+CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773740274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMAS/3KJsstwA3paQv6TW+kjF9gkITW3NZUnc7bZnuU=;
	b=HfXH0TzA0f1d2CSbAyldJl2xl9aWzYbpw10loZV1kNcn1txaCSCXzrSvfKHAIHGI00VNao
	b//U5Itged1fc1C/uxZj0ysYyWI8ysEt0UM5ZsojSOhxVbgzKeS+lof0B9W59LS9IUq6E2
	yDhoArHhElh4lGLUjlD4eJXEl3bpa6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773740274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMAS/3KJsstwA3paQv6TW+kjF9gkITW3NZUnc7bZnuU=;
	b=JOi5WNGRhJfP08gEJXjzmktG0GqpaBSxSS7XTpG6foqsalkoejj3JitKc4S0PHtQ5wznJC
	I5D56EajKt5gebCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D7054273B;
	Tue, 17 Mar 2026 09:37:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cg+ZHvIguWnvMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Mar 2026 09:37:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 43970A0AB1; Tue, 17 Mar 2026 10:37:54 +0100 (CET)
Date: Tue, 17 Mar 2026 10:37:54 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Tyler Hicks <code@tyhicks.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, coda@cs.cmu.edu, linux-mm@kvack.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, gfs2@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-efi@vger.kernel.org
Subject: Re: [PATCH 33/53] ext4: use on-stack dentries in
 ext4_fc_replay_link_internal()
Message-ID: <pb664u5mzlaqthyhwfsio66wgv2hwuqazzbrtzunnja76khowi@v7l5o4xkzci2>
References: <20260312214330.3885211-1-neilb@ownmail.net>
 <20260312214330.3885211-34-neilb@ownmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312214330.3885211-34-neilb@ownmail.net>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org,vger.kernel.org,kvack.org,lists.infradead.org,lists.linux.dev];
	R_RATELIMIT(0.00)[to_ip_from(RLyaw51ggmke6bkcxeyajg5whq)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_023800_746979_2C7DCB59 
X-CRM114-Status: GOOD (  28.14  )
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

On Fri 13-03-26 08:12:20, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> ext4_fc_replay_link_internal() uses two dentries to simply code-reuse
> when replaying a "link" operation.  It does not need to interact with
> the dcache and removes the dentries shortly after adding them.
> 
> They are passed to __ext4_link() which only performs read accesses on
> these dentries and only uses the name and parent of dentry_inode (plus
> checking a flag is unset) and only uses the inode of the parent.
> 
> So instead of allocating dentries and adding them to the dcache, allocat
> two dentries on the stack, set up the required fields, and pass these to
> __ext4_link().
> 
> This substantially simplifies the code and removes on of the few uses of
> d_alloc() - preparing for its removal.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 40 ++++++++--------------------------------
>  1 file changed, 8 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 2a5daf1d9667..e3593bb90a62 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1446,8 +1446,6 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
>  				struct inode *inode)
>  {
>  	struct inode *dir = NULL;
> -	struct dentry *dentry_dir = NULL, *dentry_inode = NULL;
> -	struct qstr qstr_dname = QSTR_INIT(darg->dname, darg->dname_len);
>  	int ret = 0;
>  
>  	dir = ext4_iget(sb, darg->parent_ino, EXT4_IGET_NORMAL);
> @@ -1457,28 +1455,14 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
>  		goto out;
>  	}
>  
> -	dentry_dir = d_obtain_alias(dir);
> -	if (IS_ERR(dentry_dir)) {
> -		ext4_debug("Failed to obtain dentry");
> -		dentry_dir = NULL;
> -		goto out;
> -	}
> +	{
> +		struct dentry dentry_dir = { .d_inode = dir };
> +		const struct dentry dentry_inode = {
> +			.d_parent = &dentry_dir,
> +			.d_name = QSTR_LEN(darg->dname, darg->dname_len),
> +		};
>  
> -	dentry_inode = d_alloc(dentry_dir, &qstr_dname);
> -	if (!dentry_inode) {
> -		ext4_debug("Inode dentry not created.");
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	ihold(inode);
> -	inc_nlink(inode);
> -	ret = __ext4_link(dir, inode, dentry_inode);
> -	if (ret) {
> -		drop_nlink(inode);
> -		iput(inode);
> -	} else {
> -		d_instantiate(dentry_inode, inode);
> +		ret = __ext4_link(dir, inode, &dentry_inode);
>  	}
>  	/*
>  	 * It's possible that link already existed since data blocks
> @@ -1493,16 +1477,8 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
>  
>  	ret = 0;
>  out:
> -	if (dentry_dir) {
> -		d_drop(dentry_dir);
> -		dput(dentry_dir);
> -	} else if (dir) {
> +	if (dir)
>  		iput(dir);
> -	}
> -	if (dentry_inode) {
> -		d_drop(dentry_inode);
> -		dput(dentry_inode);
> -	}
>  
>  	return ret;
>  }
> -- 
> 2.50.0.107.gf914562f5916.dirty
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

