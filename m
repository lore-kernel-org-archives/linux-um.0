Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DD2E743F0
	for <linux-um@archiver.kernel.org>; Fri, 29 Sep 2023 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ltezoZDy3sDuIUETMlaKZMVWv17Mh/U5jVDH/vUJmIc=; b=FdUrMAddMid1Ky
	Ve3c54U09FoDkthyvGIkJZR060mp9lcIT71NnTwRi5N47Mf6IfoEU2RRP/l35GWsGjjfI9j4HdTWr
	hKG1H8GmUkOYGNLxo1Iy7Ghjzhp6LTuS25YB3uR79emNFAwnQxMpQkU7rGtISdl/gEAoXSvG8vKdA
	lf8gFZnCg1ylDWRjoXoke/lcihUd867LoCwNdRuG3/4hnQYft89gLgKaj6GedZKaCjLZYLAb2Ci+V
	5d5Ac4l0nk95F5uDccxgA6qNDeureJpjO7vDQ2z7kDvEim45JQTrxGT+KDFdAvUzscMN0XQYKZlAE
	tSwQOcZmIWsgeEZAFE1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmFXf-008CVW-07;
	Fri, 29 Sep 2023 15:36:35 +0000
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlpIk-003Fub-1r;
	Thu, 28 Sep 2023 11:35:29 +0000
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7ab9488f2f0so4641814241.3;
        Thu, 28 Sep 2023 04:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695900924; x=1696505724; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3oHHfr+yAdtkrxVkV3qE0VFTbMzK/MU2TZf7sFiWp8=;
        b=URKvlMAnCnRQhTvggReydQTZ3LRDTNr9FTh0FF9MCEDiXZTxgNoDTrARYT9wp0RUVW
         bC458dQYIEFcdF8p/YR8nQrlCTtnhQt5OSjLUXMHXzhP0k1PmYINBb3Ncl3rV94be9xE
         9AM+CVbLLaTUTTbWpKo7T+CyPEs4wsjaSPIt5X5REdnoRZnaIYrOfeEXdS/IuCBOWzyC
         GihdXkd1m+50QWe1wPz8LdSutLEN7uz1C+s6D5Ym2rAbWLmSib26CmipcErjuoO6/3lJ
         AeX4wlad/CBskCCngNa4xJ8RZXzGCNioom5lMtUR3lSfPigJJnGoFsRTuYCLZlbcjAVX
         B3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695900924; x=1696505724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3oHHfr+yAdtkrxVkV3qE0VFTbMzK/MU2TZf7sFiWp8=;
        b=LR0hJmXmkw8a+u7YhMUVH128PlPjxZnEhgIyawzDbGdbfhVDH7r012OOU2Xo7Cle4c
         IY6m4Utw1W7KwPglXz39TXPN+PWDPJvX8vrFv2vdl7Ccoi7iT9K3mTLLHcAlItS31Lbv
         BIMa/7MpKnW2IFYUILpR3otTa0ZL1tjT7zI6HcfpuCp4KcHXUUOnL/uG1f2rJnddd2OT
         UlPmFRYR2zv6k7+Wa1g6oe8NoVKQ5AwjJnqZUWTdwdP4V7oEJOQuiFDO+JyBsO9cSZIX
         /Mn3f+T7yMQcHPltfUGYe1cRnuWWnHO+4Ze8lsfNfdw8IVd25JY8n8zNa+F8Msu9PZUq
         m8PA==
X-Gm-Message-State: AOJu0YzioBRdq+Sv7mAhOqPoespmFh6wDqbSZI+W1+BBaIAcs21ow3wG
	dSht6yb6/uVX8NTGdr6RkLD6slljrTcMIihv9Q8=
X-Google-Smtp-Source: AGHT+IHhHz7xARweFavd1XDLqmOlGZR89qjTYiX4UH69lO2YZAJePIkqF9BJYGYmOq/G1/CVWLpaXpMDMsrrAqgyB+o=
X-Received: by 2002:a67:ec16:0:b0:452:63b7:2f6d with SMTP id
 d22-20020a67ec16000000b0045263b72f6dmr830755vso.34.1695900924494; Thu, 28 Sep
 2023 04:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230928110554.34758-1-jlayton@kernel.org> <20230928110554.34758-3-jlayton@kernel.org>
In-Reply-To: <20230928110554.34758-3-jlayton@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 Sep 2023 14:35:13 +0300
Message-ID: <CAOQ4uxjSrgGr+6UOs4ADGYCderpQ7hAaPjNmB1DExAPLQQsHSg@mail.gmail.com>
Subject: Re: [PATCH 87/87] fs: move i_blocks up a few places in struct inode
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Sterba <dsterba@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Mattia Dongili <malattia@linux.it>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Brad Warrum <bwarrum@linux.ibm.com>, Ritu Agarwal <rituagar@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mark Gross <markgross@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Nicolas Pitre <nico@fluxnic.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Jan Kara <jack@suse.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>, Bob Peterson <rpeterso@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>, Jan Kara <jack@suse.cz>, David Woodhouse <dwmw2@infradead.org>, Dave Kleikamp <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, Anton Altaparmakov <anton@tuxera.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Anders Larsen <al@alarsen.net>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Phillip Lougher <phillip@squashfs.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Evgeniy Dushistov <dushistov@mail.ru>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, linux-efi@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_043526_616933_195C022E 
X-CRM114-Status: GOOD (  23.68  )
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

T24gVGh1LCBTZXAgMjgsIDIwMjMgYXQgMjowNuKAr1BNIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtl
cm5lbC5vcmc+IHdyb3RlOgo+Cj4gVGhlIHJlY2VudCBjaGFuZ2UgdG8gdXNlIGRpc2NyZXRlIGlu
dGVnZXJzIGluc3RlYWQgb2Ygc3RydWN0IHRpbWVzcGVjNjQKPiBpbiBzdHJ1Y3QgaW5vZGUgc2hh
dmVkIDggYnl0ZXMgb2ZmIG9mIGl0LCBidXQgaXQgYWxzbyBtb3ZlcyB0aGUgaV9sb2NrCj4gaW50
byB0aGUgcHJldmlvdXMgY2FjaGVsaW5lLCBhd2F5IGZyb20gdGhlIGZpZWxkcyB0aGF0IGl0IHBy
b3RlY3RzLgo+Cj4gTW92ZSBpX2Jsb2NrcyB1cCBhYm92ZSB0aGUgaV9sb2NrLCB3aGljaCBtb3Zl
cyB0aGUgbmV3IDQgYnl0ZSBob2xlIHRvCj4ganVzdCBhZnRlciB0aGUgdGltZXN0YW1wcywgd2l0
aG91dCBjaGFuZ2luZyB0aGUgc2l6ZSBvZiB0aGUgc3RydWN0dXJlLgo+CgpJbnN0ZWFkIG9mIGNy
ZWF0aW5nIGFuIGltcGxpY2l0IGhvbGUsIGNhbiB5b3UgcGxlYXNlIG1vdmUgaV9nZW5lcmF0aW9u
CnRvIGZpbGwgdGhlIDQgYnl0ZXMgaG9sZS4KCkl0IG1ha2VzIHNlbnNlIGluIHRoZSBzYW1lIGNh
Y2hlIGxpbmUgd2l0aCBpX2lubyBhbmQgSSBjb3VsZAp1c2UgdGhlIHZhY2FudCA0IGJ5dGVzIGhv
bGUgYWJvdmUgaV9mc25vdGlmeV9tYXNrIHRvIGV4cGFuZCB0aGUKbWFzayB0byA2NGJpdCAodGhl
IDMyYml0IGV2ZW50IG1hc2sgc3BhY2UgaXMgcnVubmluZyBvdXQpLgoKVGhhbmtzLApBbWlyLgoK
PiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPgo+IC0tLQo+
ICBpbmNsdWRlL2xpbnV4L2ZzLmggfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnMuaCBi
L2luY2x1ZGUvbGludXgvZnMuaAo+IGluZGV4IGRlOTAyZmYyOTM4Yi4uM2UwZmUwZjUyZTdjIDEw
MDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvZnMuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvZnMu
aAo+IEBAIC02NzcsMTEgKzY3NywxMSBAQCBzdHJ1Y3QgaW5vZGUgewo+ICAgICAgICAgdTMyICAg
ICAgICAgICAgICAgICAgICAgaV9hdGltZV9uc2VjOwo+ICAgICAgICAgdTMyICAgICAgICAgICAg
ICAgICAgICAgaV9tdGltZV9uc2VjOwo+ICAgICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAg
aV9jdGltZV9uc2VjOwo+ICsgICAgICAgYmxrY250X3QgICAgICAgICAgICAgICAgaV9ibG9ja3M7
Cj4gICAgICAgICBzcGlubG9ja190ICAgICAgICAgICAgICBpX2xvY2s7IC8qIGlfYmxvY2tzLCBp
X2J5dGVzLCBtYXliZSBpX3NpemUgKi8KPiAgICAgICAgIHVuc2lnbmVkIHNob3J0ICAgICAgICAg
IGlfYnl0ZXM7Cj4gICAgICAgICB1OCAgICAgICAgICAgICAgICAgICAgICBpX2Jsa2JpdHM7Cj4g
ICAgICAgICB1OCAgICAgICAgICAgICAgICAgICAgICBpX3dyaXRlX2hpbnQ7Cj4gLSAgICAgICBi
bGtjbnRfdCAgICAgICAgICAgICAgICBpX2Jsb2NrczsKPgo+ICAjaWZkZWYgX19ORUVEX0lfU0la
RV9PUkRFUkVECj4gICAgICAgICBzZXFjb3VudF90ICAgICAgICAgICAgICBpX3NpemVfc2VxY291
bnQ7Cj4gLS0KPiAyLjQxLjAKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11
bQo=
