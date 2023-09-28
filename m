Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B32E743FF
	for <linux-um@archiver.kernel.org>; Fri, 29 Sep 2023 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eA60VqmdqA84bzexFXyJsNYGimGWiMr8VxsaUI7qRKk=; b=vVv0NXViLP74tG
	2d2nqbJAi1kQO6TI+jIzHmi+ue758VU31JTZpFF1LN5p47LDcUhKJltO7SRxAQP8M1SHipkiWrnlp
	+FiqF+QK3fawiJFkyUTg32HXnryp8YmqZ6ZYYjdbuLCpVbKZwHi41J/3XjufVC3N43/tPqo2KPQ6q
	ZW692xBsJSlhhTy7PlUZ0QRbVvyBwSSH5idjJKWsQ6jTvwh53PGOFghvDO3dpW+AwB+wcJ5a1v7V/
	iDCpc8nI0kxupPSWTVwIyLdbYAWUDRI4XpShkFR73Eihe1Jf2Tl4oYAlvOdhLyOjuxu0uisqOjZAM
	PKDbmzoSusANnPmVPCTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmFXf-008CVn-1A;
	Fri, 29 Sep 2023 15:36:35 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlpia-003VV2-0D;
	Thu, 28 Sep 2023 12:02:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 63305B81BE2;
	Thu, 28 Sep 2023 12:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA9FC433C8;
	Thu, 28 Sep 2023 12:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695902525;
	bh=1OUz3HfWq12NDsf5pt/6tI4U8Mw0C+kMAWU6iE/wPW8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=X75jpHewuenH5i4yKP6hTRRG96bBnvYSW9ppyaPCvnjRr7Vm9FFZm7UX9cHhEdgJN
	 9sWsiJl4JoQqsZw/GKoi7gqY0vw1WSuYAKrfeyF1owUUDgi337zCsV6xBykTFrjqQ4
	 1IMm02SWv3ExmYV6PPhf6pdloK7xjV68MtysVko9J4sCrAu5RV7rZ7A69VK3LrHZj/
	 A70QTwuFIQFa4pBSyL7/hVskPkmrikqba+e0r1Z/ds7+Y2X+m8S6nvykGKta//EbMF
	 i8R56KOYB+jvupadzk05Se+6sdUCAkxdoK6c3HGUXdwYBTc4QSGFZzFBPryJ+pbGMH
	 lSy4ugTII5Mvw==
Message-ID: <f88106b26a2b647a1541d049999d5546d2ee3e51.camel@kernel.org>
Subject: Re: [PATCH 87/87] fs: move i_blocks up a few places in struct inode
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Sterba <dsterba@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Eric Biederman <ebiederm@xmission.com>,  Kees Cook <keescook@chromium.org>, Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,  Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Mattia Dongili <malattia@linux.it>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>,  Leon Romanovsky <leon@kernel.org>, Brad Warrum <bwarrum@linux.ibm.com>, Ritu Agarwal <rituagar@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mark Gross <markgross@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,  Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,  Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>,  Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Nicolas Pitre <nico@fluxnic.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,  Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Jan Kara <jack@suse.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>, Bob Peterson <rpeterso@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,  Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>, Jan Kara <jack@suse.cz>,  David Woodhouse <dwmw2@infradead.org>, Dave Kleikamp <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,  Ryusuke Konishi <konishi.ryusuke@gmail.com>, Anton Altaparmakov <anton@tuxera.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, Tony Luck <tony.luck@intel.com>,  "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Anders Larsen <al@alarsen.net>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Phillip Lougher
 <phillip@squashfs.org.uk>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Evgeniy Dushistov <dushistov@mail.ru>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>,  linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, v9fs@lists.linux.dev,  linux-afs@lists.infradead.org, autofs@vger.kernel.org,  linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,  codalist@coda.cs.cmu.edu, linux-efi@vger.kernel.org,  linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,  linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,  jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,  linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,  ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,  linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,  linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,  reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,  samba-technical@lists.samba.org, linux-trace-kernel@vger.kernel.org,  linux-xfs@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,  apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,  selinux@vger.kernel.org
Date: Thu, 28 Sep 2023 08:01:50 -0400
In-Reply-To: <CAOQ4uxjSrgGr+6UOs4ADGYCderpQ7hAaPjNmB1DExAPLQQsHSg@mail.gmail.com>
References: <20230928110554.34758-1-jlayton@kernel.org>
	 <20230928110554.34758-3-jlayton@kernel.org>
	 <CAOQ4uxjSrgGr+6UOs4ADGYCderpQ7hAaPjNmB1DExAPLQQsHSg@mail.gmail.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_050209_243233_61A3914E 
X-CRM114-Status: GOOD (  20.10  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAyMDIzLTA5LTI4IGF0IDE0OjM1ICswMzAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToK
PiBPbiBUaHUsIFNlcCAyOCwgMjAyMyBhdCAyOjA24oCvUE0gSmVmZiBMYXl0b24gPGpsYXl0b25A
a2VybmVsLm9yZz4gd3JvdGU6Cj4gPiAKPiA+IFRoZSByZWNlbnQgY2hhbmdlIHRvIHVzZSBkaXNj
cmV0ZSBpbnRlZ2VycyBpbnN0ZWFkIG9mIHN0cnVjdCB0aW1lc3BlYzY0Cj4gPiBpbiBzdHJ1Y3Qg
aW5vZGUgc2hhdmVkIDggYnl0ZXMgb2ZmIG9mIGl0LCBidXQgaXQgYWxzbyBtb3ZlcyB0aGUgaV9s
b2NrCj4gPiBpbnRvIHRoZSBwcmV2aW91cyBjYWNoZWxpbmUsIGF3YXkgZnJvbSB0aGUgZmllbGRz
IHRoYXQgaXQgcHJvdGVjdHMuCj4gPiAKPiA+IE1vdmUgaV9ibG9ja3MgdXAgYWJvdmUgdGhlIGlf
bG9jaywgd2hpY2ggbW92ZXMgdGhlIG5ldyA0IGJ5dGUgaG9sZSB0bwo+ID4ganVzdCBhZnRlciB0
aGUgdGltZXN0YW1wcywgd2l0aG91dCBjaGFuZ2luZyB0aGUgc2l6ZSBvZiB0aGUgc3RydWN0dXJl
Lgo+ID4gCj4gCj4gSW5zdGVhZCBvZiBjcmVhdGluZyBhbiBpbXBsaWNpdCBob2xlLCBjYW4geW91
IHBsZWFzZSBtb3ZlIGlfZ2VuZXJhdGlvbgo+IHRvIGZpbGwgdGhlIDQgYnl0ZXMgaG9sZS4KPiAK
PiBJdCBtYWtlcyBzZW5zZSBpbiB0aGUgc2FtZSBjYWNoZSBsaW5lIHdpdGggaV9pbm8gYW5kIEkg
Y291bGQKPiB1c2UgdGhlIHZhY2FudCA0IGJ5dGVzIGhvbGUgYWJvdmUgaV9mc25vdGlmeV9tYXNr
IHRvIGV4cGFuZCB0aGUKPiBtYXNrIHRvIDY0Yml0ICh0aGUgMzJiaXQgZXZlbnQgbWFzayBzcGFj
ZSBpcyBydW5uaW5nIG91dCkuCj4gCj4gVGhhbmtzLAo+IEFtaXIuCj4gCgpTb3VuZHMgbGlrZSBh
IHBsYW4uIFJlc3VsdGluZyBzdHJ1Y3QgaW5vZGUgc2l6ZSBpcyB0aGUgc2FtZSAoNjE2IGJ5dGVz
CndpdGggbXkga2Rldm9wcyBrY29uZmlnKS4gQlRXOiBhbGwgb2YgdGhlc2UgY2hhbmdlcyBhcmUg
aW4gbXkgImFtdGltZSIKYnJhbmNoIGlmIGFueW9uZSB3YW50cyB0byBwdWxsIHRoZW0gZG93bi4K
LS0KSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11
bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtdW0K
