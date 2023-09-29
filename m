Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103A1E728CA
	for <linux-um@archiver.kernel.org>; Fri, 29 Sep 2023 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UK6ARABbLbpfeXSTpExZQ8uuceg9oGHzIOtrBTeqgPI=; b=gGihuAvglf1uuE
	XAe/ZAjqCemqlJuWJj8ep5mts23fJkeLeeIyIOSpkhJGi0BBodD7njGBrjEkAr7vQcleuq3xhv2gw
	upuhtiWPRA7YwgIfLpJOH8HI//xz8DpsXNw7BAEG8/QVXBzulpjHFx5v7HuvKxIeH5Ia8v1yToH0Y
	IHVERR3wdErNSEPCfUPsThU1g1ySGUwlJl076NG/P6ukpPJS0JeNRvLJS7CkKdk37N6csdAd06AEb
	kX7grGVj7P5tGPdcGcLTzMr0lvEPeuC7W1EyvTRVbzNHrf+MpDwqCfBHZR4DHDKhjr8U2jpj2LZfg
	I973OMKl0U42fSZwGkEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmFXl-008Ce8-23;
	Fri, 29 Sep 2023 15:36:41 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmAYd-007Wp2-1J;
	Fri, 29 Sep 2023 10:17:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 8BAA9B81E85;
	Fri, 29 Sep 2023 10:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55EAC433C7;
	Fri, 29 Sep 2023 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695982632;
	bh=P0eff07RhtpS5UOcz3JkNsf+Ld6yeT/W26VJM0WDCPo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XzS9mEvGo34Ng6IbV0phy7oFkBghevr6TXQtKuvgCZiNk6sipSIK1ybdV8fiZNmJi
	 ryG2oocKEqZZKJ0Qpanb9xZf3XPiR4Bq6wmT9EMmf0fleXLKV9fNEg9/bkdRQXUeb0
	 6CCRA5VO7ZThmTCkkfWYanznw4Z3cZqE/s5mMA3tjLRXwYn9bn1bqt+qj2Mv3mg9Lj
	 pTssK95Hwcb1T8QjlazVp2JhItPwZmMqN2Vq1pnJqTnlHDG5dK0bcBFAZ33vjsFaWl
	 leIqxKSfZkutf2lGQF/4jFFb0IVmQg0er/lH6TmX4JwaSuIbh4XkLnYFCd3nLSRRA6
	 40ODyX835zJVA==
Message-ID: <d52b4330cd26e8ef9b2999281b05e50bd7106b3a.camel@kernel.org>
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete
 integers
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Sterba <dsterba@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Theodore Ts'o <tytso@mit.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, Jeremy Kerr <jk@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Mattia Dongili <malattia@linux.it>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>,  Leon Romanovsky <leon@kernel.org>, Brad Warrum <bwarrum@linux.ibm.com>, Ritu Agarwal <rituagar@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mark Gross <markgross@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,  Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,  Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>,  Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Nicolas Pitre <nico@fluxnic.net>, "Rafael J . Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,  Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Jan Kara <jack@suse.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>, Bob Peterson <rpeterso@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,  Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>, Jan Kara <jack@suse.cz>,  David Woodhouse <dwmw2@infradead.org>, Dave Kleikamp <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,  Ryusuke Konishi <konishi.ryusuke@gmail.com>, Anton Altaparmakov <anton@tuxera.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, Tony Luck <tony.luck@intel.com>,  "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Anders Larsen <al@alarsen.net>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Phillip Lougher
 <phillip@squashfs.org.uk>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Evgeniy Dushistov <dushistov@mail.ru>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>,  linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, v9fs@lists.linux.dev,  linux-afs@lists.infradead.org, autofs@vger.kernel.org,  linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,  codalist@coda.cs.cmu.edu, linux-efi@vger.kernel.org,  linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,  linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,  jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,  linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,  ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,  linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,  linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,  reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,  samba-technical@lists.samba.org, linux-trace-kernel@vger.kernel.org,  linux-xfs@vger.kernel.org, bpf@vger.kernel.org, Netdev <netdev@vger.kernel.org>, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Date: Fri, 29 Sep 2023 06:16:57 -0400
In-Reply-To: <20230929-yuppie-unzweifelhaft-434bf13bc964@brauner>
References: <20230928110554.34758-1-jlayton@kernel.org>
	 <20230928110554.34758-2-jlayton@kernel.org>
	 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com>
	 <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
	 <20230929-yuppie-unzweifelhaft-434bf13bc964@brauner>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230929_031715_758668_74D88EF2 
X-CRM114-Status: GOOD (  20.27  )
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

On Fri, 2023-09-29 at 11:44 +0200, Christian Brauner wrote:
> > It is a lot of churn though.
> 
> I think that i_{a,c,m}time shouldn't be accessed directly by
> filesystems same as no filesystem should really access i_{g,u}id which
> we also provide i_{g,u}id_{read,write}() accessors for. The mode is
> another example where really most often should use helpers because of all
> the set*id stripping that we need to do (and the bugs that we had
> because of this...).
> 
> The interdependency between ctime and mtime is enough to hide this in
> accessors. The other big advantage is simply grepability. So really I
> would like to see this change even without the type switch.
> 
> In other words, there's no need to lump the two changes together. Do the
> conversion part and we can argue about the switch to discrete integers
> separately.
> 
> The other adavantage is that we have a cycle to see any possible
> regression from the conversion.
> 
> Thoughts anyone?

That works for me, and sort of what I was planning anyway. I mostly just
did the change to timestamp storage to see what it would look like
afterward.

FWIW, I'm planning to do a v2 patchbomb early next week, with the
changes that Chuck suggested (specific helpers for fetching the _sec and
_nsec fields). For now, I'll drop the change from timespec64 to discrete
fields. We can do that in a separate follow-on set.
-- 
Jeff Layton <jlayton@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
