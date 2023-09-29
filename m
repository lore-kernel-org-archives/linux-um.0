Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FE9E728C4
	for <linux-um@archiver.kernel.org>; Fri, 29 Sep 2023 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o2r3dUdw3H6ztxMQS7QjI6gb2ILLbwL3chA7ZdwrAkM=; b=mFoYTrTNjruFT9
	T+XRXoepfxC2osPWzDjTf174rgPmBa7DJ6eSQwl7SIwiKasYm86fpkGvV1+rXnQX82S8/KnISk+7q
	kwJ8H2w4KUQJm0XBpkLXBaEL2zhxEj57uDfKNyGpf61LUXWNr2BvapSck3+NVgoI8ory5RkpuoNC7
	zIKXh4jl+MSV4lnVbsJXChljvxLmAzdu1BnSnylcd+l6I1vN/kRyZhlVB3qmUcZ659k6wSTq/81Ff
	74uqYnWDOetJxM6YJs455wu8ZiPrnJ413/CfKZdW+EipMrwM7BbIYyT8Qj0pwhy4cuAXGZY9p78c2
	gLxdYut5gnNXp/XK0qlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmFXj-008Cba-1z;
	Fri, 29 Sep 2023 15:36:39 +0000
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qm4Al-0074Ai-0G;
	Fri, 29 Sep 2023 03:28:13 +0000
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7a803afa8c5so5182913241.0;
        Thu, 28 Sep 2023 20:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695958089; x=1696562889; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiAb/i1gc98L6SazD4d4ItKm7HOWY4Sc1dUvsARnIt8=;
        b=PgrpDWYxAA/alL5AuTDOV9szABLjmVpdO18XEaGoT7xB6lPJ5fHakxUOWpjQZuSHhS
         Dura5sOW/jql/wt4HmJLF3CfFvPSeTSjLZCITiBm9u9FC55uO/dIckVCEhnr0uuCJIfc
         Qz6kgLl9JHFLmzBUuYbM9+TVgiriDENwTr1s9ALOOzYah0PVxVax82tBGwQEd9t8NA7q
         v0fzAFWGqIlDIdWJKjbfdfjggnh7KIrb4Odwp4d5pHlK2JhYhtgFjbfa6CJqYvT+wshz
         NrY1mmMXkc+VzdiPTMkKQQ/vwQ1u+Y7ZP8GnF5xWmVkU7F4sJwI6t/6s4/1FTXkviW1t
         PEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695958089; x=1696562889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiAb/i1gc98L6SazD4d4ItKm7HOWY4Sc1dUvsARnIt8=;
        b=byFhDRmrdCSJGHvLFDRGuqEKzoP7yQj0yZDcUyvbuuk/06Jd2oEflfaye21sDZiWjB
         AeQQHmBvaUrL4D3Ae8RK5g1O73gK2HzDIrx4VdEz9065VU6aD+a1YdX5DmP1ninFo4ol
         l+MXsPMUt5WmnK3k5AJfuR29WzB+mpvf8nP8sfqVvrj0hh1RB4/Zlv2GnSMGAJH3u2BH
         42qP44OaTRfw7r+Q4Xy5MQZjc3fgsYjL/aEbBkDGn8TpPD4bie1aiFsNMu6iBWZ15Pvb
         ztaaD2FWK9+ZuphYuGXdwJQL/rIsQTzqX9U/hHkzVdYGrtFKp/8N6QxFmEEkO2yMxwzs
         8JyQ==
X-Gm-Message-State: AOJu0Yy5ned7IY/f9aANlHwlHMIC4QGLYMBj7t1EGKyMVDtc2oopMVd7
	Fea77wkIW4NJEer8CPfyPuCCs5IOaDAEBGu+br4=
X-Google-Smtp-Source: AGHT+IFwxD5MHwB8nCElH3p97gGzSZFtR6vWTxEs/mssfRQyF6PkJIQiA0uHM4z+FM+M3FEQI561MxdOs0m92SBkdVk=
X-Received: by 2002:a05:6102:d8:b0:452:6da0:678f with SMTP id
 u24-20020a05610200d800b004526da0678fmr2890488vsp.9.1695958089382; Thu, 28 Sep
 2023 20:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230928110554.34758-1-jlayton@kernel.org> <20230928110554.34758-2-jlayton@kernel.org>
 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com> <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
 <20230928171943.GK11439@frogsfrogsfrogs>
In-Reply-To: <20230928171943.GK11439@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 Sep 2023 06:27:57 +0300
Message-ID: <CAOQ4uxjTpPPUa3VXW+DWKy72JABOZBCXD6pjNk-FhJZWnqvNPA@mail.gmail.com>
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete integers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Sterba <dsterba@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, Jeremy Kerr <jk@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Mattia Dongili <malattia@linux.it>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Brad Warrum <bwarrum@linux.ibm.com>, Ritu Agarwal <rituagar@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mark Gross <markgross@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Nicolas Pitre <nico@fluxnic.net>, "Rafael J . Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Jan Kara <jack@suse.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>, Bob Peterson <rpeterso@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>, Jan Kara <jack@suse.cz>, David Woodhouse <dwmw2@infradead.org>, Dave Kleikamp <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, Anton Altaparmakov <anton@tuxera.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Anders Larsen <al@alarsen.net>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Evgeniy Dushistov <dushistov@mail.ru>, Chandan Babu R <chandan.babu@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, linux-efi@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, bpf@vger.kernel.org, Netdev <netdev@vger.kernel.org>, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_202811_148228_F14916E7 
X-CRM114-Status: GOOD (  27.51  )
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

T24gVGh1LCBTZXAgMjgsIDIwMjMgYXQgODoxOeKAr1BNIERhcnJpY2sgSi4gV29uZyA8ZGp3b25n
QGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gVGh1LCBTZXAgMjgsIDIwMjMgYXQgMDE6MDY6MDNQ
TSAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6Cj4gPiBPbiBUaHUsIDIwMjMtMDktMjggYXQgMTE6
NDggLTA0MDAsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4gPiA+IE9uIFRodSwgU2VwIDI4LCAyMDIz
LCBhdCAwNzowNSwgSmVmZiBMYXl0b24gd3JvdGU6Cj4gPiA+ID4gVGhpcyBzaGF2ZXMgOCBieXRl
cyBvZmYgc3RydWN0IGlub2RlLCBhY2NvcmRpbmcgdG8gcGFob2xlLgo+ID4gPiA+Cj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4KPiA+ID4KPiA+
ID4gRldJVywgdGhpcyBpcyBzaW1pbGFyIHRvIHRoZSBhcHByb2FjaCB0aGF0IERlZXBhIHN1Z2dl
c3RlZAo+ID4gPiBiYWNrIGluIDIwMTY6Cj4gPiA+Cj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvMTQ1MjE0NDk3Mi0xNTgwMi0zLWdpdC1zZW5kLWVtYWlsLWRlZXBhLmtlcm5lbEBn
bWFpbC5jb20vCj4gPiA+Cj4gPiA+IEl0IHdhcyBOYUtlZCBhdCB0aGUgdGltZSBiZWNhdXNlIG9m
IHRoZSBhZGRlZCBjb21wbGV4aXR5LAo+ID4gPiB0aG91Z2ggaXQgd291bGQgaGF2ZSBiZWVuIG11
Y2ggZWFzaWVyIHRvIGRvIGl0IHRoZW4sCj4gPiA+IGFzIHdlIGhhZCB0byB0b3VjaCBhbGwgdGhl
IHRpbWVzcGVjIHJlZmVyZW5jZXMgYW55d2F5Lgo+ID4gPgo+ID4gPiBUaGUgYXBwcm9hY2ggc3Rp
bGwgc2VlbXMgb2sgdG8gbWUsIGJ1dCBJJ20gbm90IHN1cmUgaXQncyB3b3J0aAo+ID4gPiBkb2lu
ZyBpdCBub3cgaWYgd2UgZGlkbid0IGRvIGl0IHRoZW4uCj4gPiA+Cj4gPgo+ID4gSSByZW1lbWJl
ciBzZWVpbmcgdGhvc2UgcGF0Y2hlcyBnbyBieS4gSSBkb24ndCByZW1lbWJlciB0aGF0IGNoYW5n
ZQo+ID4gYmVpbmcgTmFLJ2VkLCBidXQgSSB3YXNuJ3QgcGF5aW5nIGNsb3NlIGF0dGVudGlvbiBh
dCB0aGUgdGltZQo+ID4KPiA+IExvb2tpbmcgYXQgaXQgb2JqZWN0aXZlbHkgbm93LCBJIHRoaW5r
IGl0J3Mgd29ydGggaXQgdG8gcmVjb3ZlciA4IGJ5dGVzCj4gPiBwZXIgaW5vZGUgYW5kIG9wZW4g
YSA0IGJ5dGUgaG9sZSB0aGF0IEFtaXIgY2FuIHVzZSB0byBncm93IHRoZQo+ID4gaV9mc25vdGlm
eV9tYXNrLiBXZSBtaWdodCBldmVuIGFibGUgdG8gc2hhdmUgb2ZmIGFub3RoZXIgMTIgYnl0ZXMK
PiA+IGV2ZW50dWFsbHkgaWYgd2UgY2FuIG1vdmUgdG8gYSBzaW5nbGUgNjQtYml0IHdvcmQgcGVy
IHRpbWVzdGFtcC4KPgo+IEkgZG9uJ3QgdGhpbmsgeW91IGNhbiwgc2luY2UgYnRyZnMgdGltZXN0
YW1wcyB1dGlsaXplIHM2NCBzZWNvbmRzCj4gY291bnRpbmcgaW4gYm90aCBkaXJlY3Rpb25zIGZy
b20gdGhlIFVuaXggZXBvY2guICBUaGV5IGFsc28gc3VwcG9ydCBucwo+IHJlc29sdXRpb246Cj4K
PiAgICAgICAgIHN0cnVjdCBidHJmc190aW1lc3BlYyB7Cj4gICAgICAgICAgICAgICAgIF9fbGU2
NCBzZWM7Cj4gICAgICAgICAgICAgICAgIF9fbGUzMiBuc2VjOwo+ICAgICAgICAgfSBfX2F0dHJp
YnV0ZV9fICgoX19wYWNrZWRfXykpOwo+Cj4gLS1ECj4KClN1cmUgd2UgY2FuLgpUaGF0J3Mgd2hh
dCBidHJmc19pbm9kZSBpcyBmb3IuCnZmcyBpbm9kZSBhbHNvIGRvZXMgbm90IHN0b3JlIGlfb3Rp
bWUgKGJpcnRoIHRpbWUpIGFuZCB0aGVyZSBpcyBldmVuIGEKcHJlY2VkZW50IG9mIHZmcy9idHJm
cyB2YXJpYWJsZSBzaXplIG1pc21hdGNoOgoKICAgICAgICAvKiBmdWxsIDY0IGJpdCBnZW5lcmF0
aW9uIG51bWJlciwgc3RydWN0IHZmc19pbm9kZSBkb2Vzbid0IGhhdmUgYSBiaWcKICAgICAgICAg
KiBlbm91Z2ggZmllbGQgZm9yIHRoaXMuCiAgICAgICAgICovCiAgICAgICAgdTY0IGdlbmVyYXRp
b247CgpJZiB3ZSBkZWNpZGUgdGhhdCB2ZnMgc2hvdWxkIHVzZSAiYmlndGltZSIsIGJ0cmZzIHBy
ZS1oaXN0b3JpYwp0aW1lc3RhbXBzIGFyZSBub3QgYSBzaG93IHN0b3BwZXIuCgpUaGFua3MsCkFt
aXIuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
