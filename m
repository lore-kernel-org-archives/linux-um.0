Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15327C7115B
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YvO5fzYLvhWnXwDLeu0osljtoe46Ll4TNlde5gM445I=; b=kXoyk44nhkw7zyLcf8v0BrwlKG
	/H9ILSNZyWqIuNdeC2v+VV/VXdXXwLGP1dv+WaaUHbYCcQBxMJYKvx/Scm8hXCo9ukrlfpboNWOTA
	neRkXSJ0AEnlWHrC9lwhdN4oJtO93Nf9DQg4ExlNJ0tTNMnAaVCbVJGc7+j5camyPzQ8BqbWvjzU7
	ecVx4RspNIZ77nMtQiTGmmzS+FI1AVHhkRkhEbJTPGwbRDjCRiVjsfmJp4edxu/CK+TMlZv1kA8vx
	s3gjw+GjdFLBhbqDSia0T2xRElvtD0X1ova8AqMC8RKT47jddBfNNS7hPaVe4HEQ5+57CNzNDMxpa
	DlcHG1wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSLpK-0000000ECc9-3Tz1;
	Thu, 19 Jun 2025 20:25:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSJN6-0000000Do61-1hbM;
	Thu, 19 Jun 2025 17:48:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YvO5fzYLvhWnXwDLeu0osljtoe46Ll4TNlde5gM445I=; b=qPzBgSE18GECzxPD/Jej04d5D7
	oPOwnwW1jBfWw0/AJ0OvVqGHfSDkBoxemXuq5eNmgnbYT7tSRtZnEHDpvvgtUv9FkfVxblTXfgxhA
	iWaK9ZSaCTHWmAPJ6UB9LKJ7eCnfkfbNG0n+EhhO1HL0LgE+JPkfwnMYh2/44CJS1oGzuY2nJo4u4
	0WhqwFXEYog+IT/Hsg7fj6HI0QO0q3u1osQS4+Y1B6jYB8CydQVjog1cUcPiDkkpqo4Oj5UeHpwwv
	YmW3iTVwtuyKI/UFTh2i3IuqiWmGitYYja2pheMdv3sjwtZXBKO2oVC3IGRThZaV1KyPWtOsC8Rc4
	IPg+iqdg==;
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSJN4-00000004W0a-08p6;
	Thu, 19 Jun 2025 17:48:19 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-32b855b468bso9819991fa.3;
        Thu, 19 Jun 2025 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750355295; x=1750960095; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvO5fzYLvhWnXwDLeu0osljtoe46Ll4TNlde5gM445I=;
        b=XLkQnt767jWaN5tHHjii6D+7mWMvi3+cn126Qv1l7/qy8gXvzkBT3StuYVii2E9BKU
         mEZEaU87IGQh9lVBOXr1rvaZC2mmYqEwYdONbSLuPs1s10Mt9Q2+NLDD8YO1adLgLsEh
         UKWqplPNLox9IW0I40eEsP/OiK2RusI6nZDOlRrZrhizgAcAJA2Z1nRYsRov2tuz/UgK
         hG4a1AhJcj9lcZVxVpUfzBG3gsGmI99EF0OVVrh1CjIhUFbJSRydHURSq1zcHw4hMpzY
         s+WNubyWiJBUWYJh6vyX6CuIHOpvlOrtlPlf/zjZrrPNXfepU59R7PWX5UdKqUZ+1Nvz
         zyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750355295; x=1750960095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvO5fzYLvhWnXwDLeu0osljtoe46Ll4TNlde5gM445I=;
        b=YQZXeqdhRGAs+CRwY1xmVue3oFOZrJyl/f3Qg6QA2CF4ZptSWCFtgy6L9fL7HoAZnT
         DBgfbx6413y2Vwb8JQ7ugJYjzpTjI+4Ukkx8TLOFnmUGXr7cjgMcxVWW5mhYTolcFaOs
         tJBwUAlxITz24loWt3V9q3GcFCwtwz6uGZ3e8M4UVxgUV23Y/0hDxVP4MbiR+NNTEeDJ
         H9dzbDiBhXWLv3ShQRr/All1QmFEEb2ttT3M550g2HJMz8+IRzpeVq56uisXRIzBwgT1
         kUImdfV6Qb/PciJukjWU9hsEJkx+DVyteve9xa1GBakafwnZjbhtQPD1EZOoUvbjoUjB
         8TXA==
X-Forwarded-Encrypted: i=1; AJvYcCV/SOtpRLL41BP40P5Y1he0wxJWuMaUuwoxnhDJKSXa6ju6hkhdZU+7hjRAIkG7NYU/IF0uAAHiYEM=@lists.infradead.org, AJvYcCVFyAxrXiBkKl++56wGCleP0slUPKaZWP/ZXeBCpOTYqCkbh3vw8XN7brybMaWmcHiD/RP8HJYqHuQY@lists.infradead.org, AJvYcCWTDjYv8JsYsJunDbj7Kph/8A1tfqhE2zq5n03PxG4LS1mQ7dIMYAcGYaXh/6L4iRpdMA3RTZyf+G8=@lists.infradead.org
X-Gm-Message-State: AOJu0YwY1lVK3iiGHOIljr2wSG65Nak/vvAoc10XBEZpu2hmOjcaefJ8
	DauDkjxNScR+yQyTKNbs10vpSgL+iy6BVSltrI075QXjI+r7L6nfDn556E/T2sRyqKJcAPRy6kQ
	jk1+8kSvBb26lZncnjD4fIJW5YfhdMKM=
X-Gm-Gg: ASbGncs9LzBYOSokayHrDDKZIWFISCLVi4g8nIIGIcxq8lPM27I/NDWWCMoJX/Iv6AJ
	bVkLb1zwrCKm6XYB+T0Bvvc8XKwUvROIugXWFIVskWRYPQKClztJdMNDqT9GdPoX55IdkmbBHiQ
	LmOGMoMRjzvzuJLZjP1IeEwpWzB0eAfBHJP59QQ8awEyZKDN0/dkkjENhpkx++txLjdXYDjiFGL
	CyjAA==
X-Google-Smtp-Source: AGHT+IGL41V3DbmFvBsWr3jGwFHfcX0duW69mbczpCAOINsa85ECUigYdfUlpWqgF++enxibRnhFFvr8Kxdp2WtP+R0=
X-Received: by 2002:a05:651c:2203:b0:32a:8297:54c9 with SMTP id
 38308e7fff4ca-32b4a3088bbmr63065741fa.8.1750355294494; Thu, 19 Jun 2025
 10:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com> <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 20 Jun 2025 02:47:58 +0900
X-Gm-Features: AX0GCFsRgomy43xV-Lv7Stfld1a1yqIyJ3-ysZ2OVO90S8cEE5UAjZMSvGqxZQ8
Message-ID: <CAKFNMom4NJ91Ov7twQ3AGT7PSqt5vN9ROrNHzfV53GHf=bK6oQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] fs: replace mmap hook with .mmap_prepare for simple mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, 
	"Tigran A . Aivazian" <aivazian.tigran@gmail.com>, Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Dave Kleikamp <shaggy@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Hans de Goede <hdegoede@redhat.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-mm@kvack.org, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org, 
	linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net, 
	devel@lists.orangefs.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org, 
	nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_184818_195911_4AAA6631 
X-CRM114-Status: GOOD (  15.99  )
X-Mailman-Approved-At: Thu, 19 Jun 2025 13:21:43 -0700
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

On Tue, Jun 17, 2025 at 4:48=E2=80=AFAM Lorenzo Stoakes wrote:
>
> Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> callback"), the f_op->mmap() hook has been deprecated in favour of
> f_op->mmap_prepare().
>
> This callback is invoked in the mmap() logic far earlier, so error handli=
ng
> can be performed more safely without complicated and bug-prone state
> unwinding required should an error arise.
>
> This hook also avoids passing a pointer to a not-yet-correctly-establishe=
d
> VMA avoiding any issues with referencing this data structure.
>
> It rather provides a pointer to the new struct vm_area_desc descriptor ty=
pe
> which contains all required state and allows easy setting of required
> parameters without any consideration needing to be paid to locking or
> reference counts.
>
> Note that nested filesystems like overlayfs are compatible with an
> .mmap_prepare() callback since commit bb666b7c2707 ("mm: add mmap_prepare=
()
> compatibility layer for nested file systems").
>
> In this patch we apply this change to file systems with relatively simple
> mmap() hook logic - exfat, ceph, f2fs, bcachefs, zonefs, btrfs, ocfs2,
> orangefs, nilfs2, romfs, ramfs and aio.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

For nilfs2,

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

