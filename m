Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5288CC282CD
	for <linux-um@archiver.kernel.org>; Mon,  3 Mar 2025 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qjaplGXAgQys6n43UvZfkCCurGUYwKZfvrBKCJx8kSQ=; b=XH7/Q5nIHSy0mBlGUc9my1ggur
	+31UBGbqf7IC/oUnCBw++3OJAXr+e6tx5a4iABbqBlBeQ+N7tX3jQqPpqzATkc2xouSLrl5ZelxUC
	/JIGmPyLEhpfRk+jZtX9aM6BpSIUBFhqc1lR2TAySfWaFyn6ZLoXF09ODn5RY0t3Y/myg/qh16I28
	aB9+FBKFbRnuPg+H1jTUvCrnbB7Rnja7xxXJll59AwyKtoitpwhXAqKO4jtnpcTOYPDf1joCfTC8i
	sQb7rYMEXooy9ltYKTHdlwsgOgrzWr2BBwQKpa/9iy8qKwzywRLx6ir65GvfFVnZhtElJucy+o28M
	dXk4PDig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp79m-00000001B32-02CI;
	Mon, 03 Mar 2025 14:52:34 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp73k-00000001A7q-32e7
	for linux-um@lists.infradead.org;
	Mon, 03 Mar 2025 14:46:21 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-474f15a2087so3294841cf.1
        for <linux-um@lists.infradead.org>; Mon, 03 Mar 2025 06:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1741013179; x=1741617979; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qjaplGXAgQys6n43UvZfkCCurGUYwKZfvrBKCJx8kSQ=;
        b=p//pxm85Z5Bd+UKrmrCyUo2cNS0ZpDC85i4cxtqlWtaDfeE3TTtB4hTU0nYYI8WEj1
         tw3MaRBXX15xozz1GTnVCQBdbF/3f6RFTw9LAiVAmoaz3XMrTFqWTcVm4wvsCwcAcYmq
         hB7yZlx+WH9fAHHVYeb2eGmnryqXxi7SjVKjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741013179; x=1741617979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjaplGXAgQys6n43UvZfkCCurGUYwKZfvrBKCJx8kSQ=;
        b=eJIT7e++oVbxZlP+98gRzuwolaHt9lUzaowVoZVHHs2cB6GvWwNlXr3wyiMgnw11L4
         DrIWnlkzG4t/TcQPbKJPFFvtkEvx41tm1GgOQ3F90h2Q/RYQ/VOZHRwypN2HYQZWI8rp
         6AokSZqyoNVH9pWMhsxWbqZ1a+BDFSh9m0OCzWvzkQZ4Qk109WKJ0MT9/l810tf8waQ0
         TFMXyWhUdY9bqAxEOAA8+SUFlKD3Nna9slt8P32S8o7JXkUj4VVgWCXJdpGIX0si4UKD
         4pQS3y7kjdhMzYI4U3c8zhiLKbGZFuafmLKxtwx1mY3kkRMLpGchRcDQkB1AmVVnS8Ri
         TxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxeNDS3Yv5igz0vrSVysCnWvclbf54Y8bMuUuOoAlz5+RoVY+Zysc5c2h4sqcjG8QPCrcmhJr+2g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWyrdraxxC5wP5Ep5QaEGG7JwaXI8i2CFVOdJlrwU3t7/9iO97
	BjiniyTeDGUxzgkN9E60W5Ucg/vmkz8Nx4UVyEzMJmDyQ26me8F1X7e976PKniznbC9tLeudL74
	SMAbD62Ia/R0L+8P9l+jVWBG/EX+UPx+7v1tktg==
X-Gm-Gg: ASbGncuGaWyZTqehGP6/qaazwgos/vSYaHifRi9Y75lFqK1H3k5eJA2hKHKJxqaKal+
	nKYV9hTksNFroXwuOaAx48rjd8aMFyU8cp4uAYSp//wCxak63xtft+gRmRkN88XG0ktwaq54d1b
	U7uv+BvK/R11K2pnCKRusNxK0LjFY=
X-Google-Smtp-Source: AGHT+IEc70lGyxC8HHKIoOrpie2Jx8XsivN2M9IFYtspzolVa0r9jSj5J487Smay6+rDx9jahhDHL5KyYqxP+yy2+fA=
X-Received: by 2002:ac8:5806:0:b0:474:f484:1b4b with SMTP id
 d75a77b69052e-474f4841d3emr20114471cf.23.1741013178811; Mon, 03 Mar 2025
 06:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20250227013949.536172-1-neilb@suse.de> <20250227013949.536172-5-neilb@suse.de>
In-Reply-To: <20250227013949.536172-5-neilb@suse.de>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 3 Mar 2025 15:46:06 +0100
X-Gm-Features: AQ5f1JoUFcZgsP72xjJitgL04_WZu20xfL4s-mJeajhIk4Eeu4PYIyUzi4H_ijM
Message-ID: <CAJfpegtu1xs-FifNfc2VpQuhBjbniTqUcE+H=uNpdYW=cOSGkw@mail.gmail.com>
Subject: Re: [PATCH 4/6] fuse: return correct dentry for ->mkdir
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_064620_767016_83C2A2F0 
X-CRM114-Status: GOOD (  11.70  )
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

On Thu, 27 Feb 2025 at 02:40, NeilBrown <neilb@suse.de> wrote:
>
> fuse already uses d_splice_alias() to ensure an appropriate dentry is
> found for a newly created dentry.  Now that ->mkdir can return that
> dentry we do so.
>
> This requires changing create_new_entry() to return a dentry and
> handling that change in all callers.
>
> Note that when create_new_entry() is asked to create anything other than
> a directory we can be sure it will NOT return an alternate dentry as
> d_splice_alias() only returns an alternate dentry for directories.
> So we don't need to check for that case when passing one the result.

Still, I'd create a wrapper for non-dir callers with the above comment.

As is, it's pretty confusing to deal with a "dentry", which is
apparently "leaked" (no dput) but in reality it's just err or NULL.

Thanks,
Miklos

