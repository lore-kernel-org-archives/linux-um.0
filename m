Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31AAE728C3
	for <linux-um@archiver.kernel.org>; Fri, 29 Sep 2023 15:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bioI5n8vqnw52uuUH4Os2r7zX8ySUlAB+uXskiFzgIo=; b=D9NPtfjn9r9BNi
	bd0+FY+DlSM4KDTycT4gAtdMqqkD9gjfSjQjZ46KebtqsByk+DRQNZTXeFt9Yi62B4HRMEVpQDpyO
	kGW5uFlBsjPQKev/Ks3eMXflzwSskpzSIoVfZ9nB3lMWWVBpt0sKjgfsfvDiFsF+dzWdWVg7h7ebG
	WQxAciRPEQR+SnW92Gd5no4Xe15AeAMUwVzk8uOTBQZ2lx/4XnK1f2q8Ld7jxYp/fbEFK21sSsY48
	OOA8xkk8iO7xYSW4yN9QRdlAM3uBUsnWN2HhzeFihhAMEFCDGFsk+fb8tfrxPTbN6YzCk5toJ9DjD
	oKtSKaU3zLBKijOIiBiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmFXj-008Cao-0o;
	Fri, 29 Sep 2023 15:36:39 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qm1JS-006v5o-2m
	for linux-um@lists.infradead.org;
	Fri, 29 Sep 2023 00:25:00 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3248e90f032so984076f8f.1
        for <linux-um@lists.infradead.org>; Thu, 28 Sep 2023 17:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695947093; x=1696551893; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bvzvBt54YKz6rxhAovyc5UddK2JDmyrig02MAqmRW1o=;
        b=Crehqw9fRi+i8PvIDFyWZUEHUxbe/lPePbtnQsxb+3QjWkOIGeOTck4eLrD5nYOHRG
         +Cbrzjx4yytqqcAtYD/0/1ftRFK5sVE3xbKhRKkdAOxZzXReUPOFq35vaKsXr25tmii/
         N7KODrYXjJgPsuSP39g2YyDa8Lfi/elRGIeac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695947093; x=1696551893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvzvBt54YKz6rxhAovyc5UddK2JDmyrig02MAqmRW1o=;
        b=kO9DCG5J5/IEYBuvAS6ACaBYmBCT/5mP7sbfx5qdnQdaTzilDvyQAvout3RRn6hnjk
         qpU9jKkr55IPL8r9Pn0ukMrWYYib2u0zsqysF/O13SUCv374iFWInRVfonS/F86JX6/w
         8XAJ1J/8ANod8etm+Ei/ViuNih+p5rDhrL//7/ILOs0oIZhxG1hNKAB4PyPWLVMcycPa
         JHGOQKODVK3gOeXr8/6MKpilGf8RCDrfy16/sc5fJoNpftzwGoBZEIY52i/6TURvOsF9
         Yd5tVCJCOp7wPU1nrq5bZugvjgaIqy1Hlnh05rSdOfDJ5B8+dqnNpz+yoV45BsAXq8Od
         HHdA==
X-Gm-Message-State: AOJu0YyPuUxE8ujqlmBAeM9G8N0wzgdMoimXyd88RoCUlHUeG1VvOPK8
	ZFDeY/Il+oSpNfcs4jiDQvuSqPov+khP5wFL8W2Fl3F2bgg=
X-Google-Smtp-Source: AGHT+IG/tl9M5MIHBziyg+0qOwcjAeZlmTogoY3pOljGFdKhmEV7Zu5bbZq85qRKyyb3bEVAAB534g==
X-Received: by 2002:adf:e543:0:b0:317:f714:3be6 with SMTP id z3-20020adfe543000000b00317f7143be6mr2377681wrm.61.1695947093073;
        Thu, 28 Sep 2023 17:24:53 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id g27-20020a170906395b00b009ae587ce128sm11506809eje.216.2023.09.28.17.24.52
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 17:24:52 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso1737852866b.1
        for <linux-um@lists.infradead.org>; Thu, 28 Sep 2023 17:24:52 -0700 (PDT)
X-Received: by 2002:aa7:d807:0:b0:530:52d2:f656 with SMTP id
 v7-20020aa7d807000000b0053052d2f656mr2404674edq.21.1695946739584; Thu, 28 Sep
 2023 17:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230928110554.34758-1-jlayton@kernel.org> <20230928110554.34758-2-jlayton@kernel.org>
 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com> <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
 <20230928171943.GK11439@frogsfrogsfrogs> <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
 <20230928212656.GC189345@mit.edu>
In-Reply-To: <20230928212656.GC189345@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Sep 2023 17:18:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTynK9BdGbi+8eShU77nkPvipFwRxEd1TSBrw2+LiuDg@mail.gmail.com>
Message-ID: <CAHk-=wjTynK9BdGbi+8eShU77nkPvipFwRxEd1TSBrw2+LiuDg@mail.gmail.com>
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete integers
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jeff Layton <jlayton@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.cz>, Amir Goldstein <amir73il@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, Jeremy Kerr <jk@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Mattia Dongili <malattia@linux.it>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Brad Warrum <bwarrum@linux.ibm.com>, Ritu Agarwal <rituagar@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mark Gross <markgross@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Nicolas Pitre <nico@fluxnic.net>, "Rafael J . Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>, Jeffle Xu <jefflexu@linux.alibaba.com>, Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Jan Kara <jack@suse.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>, Bob Peterson <rpeterso@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>, Jan Kara <jack@suse.cz>, David Woodhouse <dwmw2@infradead.org>, Dave Kleikamp <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, Anton Altaparmakov <anton@tuxera.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Anders Larsen <al@alarsen.net>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Evgeniy Dushistov <dushistov@mail.ru>, Chandan Babu R <chandan.babu@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, codalist@telemann.coda.cs.cmu.edu, linux-efi@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, bpf@vger.kernel.org, Netdev <netdev@vger.kernel.org>, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_172458_923427_14B6E6B3 
X-CRM114-Status: GOOD (  17.42  )
X-Mailman-Approved-At: Fri, 29 Sep 2023 08:36:32 -0700
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

On Thu, 28 Sept 2023 at 14:28, Theodore Ts'o <tytso@mit.edu> wrote:
>
> I don't think anyone will complain about breaking the userspace API
> --- especially since if, say, the CIA was using this for their spies'
> drop boxes, they probably wouldn't want to admit it.  :-)

Well, you will find that real apps do kind of of care.

Just to take a very real example, "git" will very much notice time
granularity issues and care - because git will cache the 'stat' times
in the index.

So if you get a different stat time (because the vfs layer has changed
some granularity), git will then have to check the files carefully
again and update the index.

You can simulate this "re-check all files" with something like this:

    $ time git diff

    real 0m0.040s
    user 0m0.035s
    sys 0m0.264s

    $ rm .git/index && git read-tree HEAD

    $ time git diff

    real 0m9.595s
    user 0m7.287s
    sys 0m2.810s

so the difference between just doing a "look, index information
matches current 'stat' information" and "oops, index does not have the
stat data" is "40 milliseconds" vs "10 seconds".

That's a big difference, and you'd see that each time the granularity
changes. But then once the index file has been updated, it's back to
the good case.

So yes, real programs to cache stat information, and it matters for performance.

But I don't think any actual reasonable program will have
*correctness* issues, though - because there are certainly filesystems
out there that don't do nanosecond resolution (and other operations
like copying trees around will obviously also change times).

Anybody doing steganography in the timestamps is already not going to
have a great time, really.

                 Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
