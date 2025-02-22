Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03416C021B2
	for <linux-um@archiver.kernel.org>; Sat, 22 Feb 2025 04:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ak81sfwQs82rWCjc8icmSjWD6hQCZp6KEAR3SJKFhos=; b=UipG9WG8iIwF88ZNinMtyRmG27
	WOqsGSTwCHENLoOTROjKv6M6ZQuq3vKMn+DAuQTDruPJnlZWEdYiTAaQvYhQtYzhyWbjY800A4Nlh
	gUwd/pV5tBj3Ty0A6lnRsgAyMWc+lKSk/1uH4/jy7r3V3zvJxcS+3r8LaZfqPkqc/d46CAMSOgnOr
	SLPZtDRX6WNOA+gBIXz9UWP5fIMYvJLZf6DiUYLRK+PoLou0BVo7hi3zTT8FR6IiGlX/WDtBXjbMd
	Swu820FzmWD8He1HIXD10+3R1oLWV1Qe44pDQ5ilF14BSbA7IrHJao6JZOI3wO0Dry9RIRvp9c7mb
	RLQ+lWVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlhM1-00000007SCr-1dNP;
	Sat, 22 Feb 2025 04:43:05 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlhKe-00000007S2i-2mw0
	for linux-um@lists.infradead.org;
	Sat, 22 Feb 2025 04:41:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ak81sfwQs82rWCjc8icmSjWD6hQCZp6KEAR3SJKFhos=; b=V0RNI5qUK23YrR10htyClgF4V1
	qbXhwFxOWEZeIRkIxGTlZvEx1MsiaQslQ7SENgBpE1twBEHKwbdzwv9bjaN+PsLSh+XhhiarJVJ1E
	OfjrFVZ+ATFjsP7YmWYyl1Og8hyiW0eqoCE1QPKxYwYXA7kcq46Ch17j5HhZyyCtmYB2coproXOCC
	ZL4NLdAPFNF1606559N3t7cbLUempsnl4t6V9SEiJAn8lQOlrFkJt3zualaWxqLJM2Go9F+cC9P0a
	VU5rCX08UcXjnbuOdSlwkQrXJPPxrpgRDnrwxt3RJ+b0jhecTdIm1fHEzF9shodT3fNMRHV7Trc5E
	IkW2Vu7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlhKU-00000004ese-2hS3;
	Sat, 22 Feb 2025 04:41:30 +0000
Date: Sat, 22 Feb 2025 04:41:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: Re: [PATCH 5/6] nfs: change mkdir inode_operation to return
 alternate dentry if needed.
Message-ID: <20250222044130.GO1977892@ZenIV>
References: <20250220234630.983190-1-neilb@suse.de>
 <20250220234630.983190-6-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220234630.983190-6-neilb@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_204140_702495_C9F63819 
X-CRM114-Status: GOOD (  11.27  )
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

On Fri, Feb 21, 2025 at 10:36:34AM +1100, NeilBrown wrote:

>  nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
>  {
>  	struct posix_acl *default_acl, *acl;
> @@ -612,15 +612,18 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
>  		dentry = d_alias;
>  
>  	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
> +	if (status && d_alias)
> +		dput(d_alias);
>  
> -	dput(d_alias);
>  out_release_acls:
>  	posix_acl_release(acl);
>  	posix_acl_release(default_acl);
>  out:
>  	nfs3_free_createdata(data);
>  	dprintk("NFS reply mkdir: %d\n", status);
> -	return status;
> +	if (status)
> +		return ERR_PTR(status);
> +	return d_alias;

Ugh...  That's really hard to follow - you are leaving a dangling
reference in d_alias textually upstream of using that variable.
The only reason it's not a bug is that dput() is reachable only
with status && d_alias and that guarantees that we'll
actually go away on if (status) return ERR_PTR(status).

Worse, you can reach 'out:' with d_alias uninitialized.  Yes,
all such branches happen with status either still unmodified
since it's initialization (which is non-zero) or under
if (status), so again, that return d_alias; is unreachable.

So the code is correct, but it's really asking for trouble down
the road.

BTW, dput(NULL) is guaranteed to be a no-op...

