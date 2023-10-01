Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0170E7C4EF
	for <linux-um@archiver.kernel.org>; Wed,  4 Oct 2023 19:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s28oe/MuLHeIQKcIQBOxhtdp5hHQG4sL+KRXZNu+U30=; b=PerhETUUp15z6H
	xnJLrS5vX00ibJs+FJvcdS+Ju5jVqw17lTxM5LcJiaurEPLKUT+tuJXz/cuN7TUWmGTu0tA3+kAhY
	+GKEp6KaHO7egZB2V/URVII+G8ahkO4LZXHyv3k6nE06/esL2nFB2UBYLPGpXScjXv/5wAo39Vubs
	WrRALR2YS1mXD3wl70kXAJYnmiNdqdA7ZABQnx+vA3gCObTVWqySxNzZUjWfaRwlM+WS/9x9T90XH
	y+HG3Tg5BYz4R5AgrDbg4Bdxk5uCi688dGgLJUkamJO57pVgxkn2uknKF37lZ0BrhrnNlHG1v6OLG
	CctgRDBpbkXH+JyC244w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo7tL-000p7B-1G;
	Wed, 04 Oct 2023 19:50:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmocL-00AXwt-08;
	Sun, 01 Oct 2023 05:03:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5JgHwkJ5bZA+PRufvniyMuRJN1Jr6719sKCuadOAMmw=; b=IVbaC5OmtT4hRdDkL8KHcrCIQp
	rExla4a/mhljdelgDa3BBMbGrf4CLmrm7cUjDg5jyi3ZY6O3zdWz5XH941C6/wh1NrQiXXc1PSbtL
	PkBOX5Ox36MpTWJvI/jCSzOaKhOJ3gh/srpK0dZ26GLjH44CO/QNC7UGxiGghvYsx35wrz9cHqBx6
	UXchaZa01ny3JFCvLEhoBrvGzqPh6PYUr8YnOUzPgu/XNCj7aMIWhRyd52JWogHqna009c7P19915
	fZ73T4QK70TRQ7KWODG2V20KiPnAFRfuw/WSVFWG46KWH0OP7VHIOR3ws16T9DR6QyK/6h0R6PxYl
	9UpFSBYQ==;
Received: from mx08-006a4e02.pphosted.com ([143.55.148.243])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qmocG-001P7r-0d; Sun, 01 Oct 2023 05:03:43 +0000
Received: from pps.filterd (m0316696.ppops.net [127.0.0.1])
	by mx08-006a4e02.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3914Sfhl004611;
	Sun, 1 Oct 2023 07:02:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iram.es; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to:content-transfer-encoding; s=dkim3;
	 bh=5JgHwkJ5bZA+PRufvniyMuRJN1Jr6719sKCuadOAMmw=; b=hDNmwqgug1An
	fvwB2cRTfoutFDu+tai+5nrTyDJGpD0Pkv+UoD9dDHnHHIAd09gz+r02mse1Cs9K
	ZCgOca/WGL5QjFanXXswWHZ9gsDFv9HUsGVbSl0NWG9zgx7F1IrS1vcyAC4I2TBu
	vtCiSXblwT2BOKB168GcAoNAG3zywK5ZIdX9TFP4bHS8GBFExgd9NXibijGF4eid
	NlYGioPXJRFaYlb2eKu0casy5f5iNW/FoS1c0RbxZP9tWhnpwN4+plV0Uq3PyrZu
	vjfbiPtJ7zPzKAVMjvhFWJMgaNJzLRSZANzAdWFrm7A8N1ie1vidQt1Dp6QldrsP
	8q3fZB20SA==
Received: from sim.rediris.es (mta-out04.sim.rediris.es [130.206.24.46])
	by mx08-006a4e02.pphosted.com (PPS) with ESMTPS id 3teykjrcsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Oct 2023 07:02:19 +0200 (MEST)
Received: from sim.rediris.es (localhost.localdomain [127.0.0.1])
	by sim.rediris.es (Postfix) with ESMTPS id 08405182CD0;
	Sun,  1 Oct 2023 07:02:17 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by sim.rediris.es (Postfix) with ESMTP id 3AA0218321E;
	Sun,  1 Oct 2023 07:02:16 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
 mta-out04.sim.rediris.es
Received: from sim.rediris.es ([127.0.0.1])
 by localhost (mta-out04.sim.rediris.es [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Q82QmjsDiqOz; Sun,  1 Oct 2023 07:02:13 +0200 (CEST)
Received: from gp-workstation.iram.es (haproxy01.sim.rediris.es [130.206.24.69])
	by sim.rediris.es (Postfix) with ESMTPA id 96282180084;
	Sun,  1 Oct 2023 07:01:58 +0200 (CEST)
Date: Sun, 1 Oct 2023 07:01:56 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Latchesar Ionkov <lucho@ionkov.net>, "Rafael J . Wysocki" <rafael@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Anders Larsen <al@alarsen.net>, Carlos Llamas <cmllamas@google.com>, Sven Schnelle <svens@linux.ibm.com>, Mattia Dongili <malattia@linux.it>, Yonghong Song <yonghong.song@linux.dev>, Alexander Gordeev <agordeev@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, Jason Gunthorpe <jgg@ziepe.ca>, James Morris <jmorris@namei.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, devel@lists.orangefs.org, Shyam Prasad N <sprasad@microsoft.com>, Jan Harkes <jaharkes@cs.cmu.edu>, linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Eric Van Hensbergen <ericvh@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anton Altaparmakov <anton@tuxera.com>, Christian Brauner <brauner@kernel.org>, Greg Kr oah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jan Kara <jack@suse.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dave Kleikamp <shaggy@kernel.org>, samba-technical@lists.samba.org, Marc Dionne <marc.dionne@auristor.com>, Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@google.com>, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Leon Romanovsky <leon@kernel.org>, Hugh Dickins <hughd@google.com>, Andrii Nakryiko <andrii@kernel.org>, codalist@coda.cs.cmu.edu, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, linux-trace-kernel@vger.kernel.org, Todd Kjos <tkjos@android.com>, Vasily Gorbik <gor@linux.ibm.com>, selinux@vger.kernel.org, reiserfs-devel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>, ocfs2-devel@lists.linux.dev, Yue Hu <huyue2@coolpad.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Martijn Coenen <maco@android.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Hao Luo <haoluo@google.com>, Tony Luck <tony.luck@intel.com>, Theodore Ts'o <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>, linux-ntfs-dev@lists.sourceforge.net, Muchun Song <muchun.song@linux.dev>, linux-f2fs-devel@lists.sourceforge.net, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Anna Schumaker <anna@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Brad Warrum <bwarrum@linux.ibm.com>, Mike Kravetz <mike.kravetz@oracle.com>, linux-efi@vger.kernel.org, Martin Brandenburg <martin@omnibond.com>, Alexei Starovoitov <ast@kernel.org>, platform-driver-x86@vger.kernel.or.g, Joseph Qi <joseph.qi@linux.alibaba.com>, Chris Mason <clm@fb.com>, linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Jiri Slaby <jirislaby@kernel.org>, linux-afs@lists.infradead.org, Ian Kent <raven@themaw.net>, Naohiro Aota <naohiro.aota@wdc.com>, Daniel Borkmann <daniel@iogearbox.net>, Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org, coda@cs.cmu.edu, Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Ilya Dryomov <idryomov@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, autofs@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Mark Gross <markgross@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Eric Paris <eparis@parisplace.org>, ceph-devel@vger.kernel.org, Gao Xiang <xiang@kernel.org>, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-ext4@vger.ker.nel.org,
 Olga Kornievskaia <kolga@netapp.com>, Song Liu <song@kernel.org>, Jeff Layton <jlayton@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, linux-xfs@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>, Chandan Babu R <chandan.babu@oracle.com>, jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>, Neil Brown <neilb@suse.de>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Bob Copeland <me@bobcopeland.com>, KP Singh <kpsingh@kernel.org>, David Sterba <dsterba@suse.cz>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-mm@kvack.org, Andreas Dilger <adilger.kernel@dilger.ca>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Ard Biesheuvel <ardb@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Dai Ngo <Dai.Ngo@oracle.com>, Steve French <sfrench@samba.org>, linux-serial@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Salah Triki <salah.triki@gmail.com>, John Fastabend <john.fastabend@gmail.com>, Evgeniy Dushistov <dushistov@mail.ru>, linux-cifs@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Chao Yu <chao@kernel.org>, apparmor@lists.ubuntu.com, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Hans de Goede <hdegoede@redhat.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, John Johansen <john.johansen@canonical.com>, Ritu Agarwal <rituagar@linux.ibm.com>, Luis de Bethencourt <luisbg@kernel.org>, Netdev <netdev@vger.kernel.org>, v9fs@li.sts.linux.dev, linux-unionfs@vger.kernel.org, linux-security-module@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>, Phillip Lougher <phillip@squashfs.org.uk>, Johannes Berg <johannes@sipsolutions.net>, Johannes Thumshirn <jth@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-karma-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Subject: [OT] Re: [PATCH 86/87] fs: switch timespec64 fields in inode to
 discrete integers
Message-ID: <20231001050156.GA3366643@gp-workstation.iram.es>
References: <20230928110554.34758-1-jlayton@kernel.org>
 <20230928110554.34758-2-jlayton@kernel.org>
 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com>
 <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
 <20230928171943.GK11439@frogsfrogsfrogs>
 <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
 <636661.1695969129@warthog.procyon.org.uk>
 <CAH2r5ms14hPaz=Ex2a=Dj0Hz3XxYLRKFj_rHHekznTbNJ_wABQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAH2r5ms14hPaz=Ex2a=Dj0Hz3XxYLRKFj_rHHekznTbNJ_wABQ@mail.gmail.com>
X-Proofpoint-GUID: kkBSTf9MqmX5iUKHKuTc98X9WmtvqH75
X-Proofpoint-ORIG-GUID: kkBSTf9MqmX5iUKHKuTc98X9WmtvqH75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-01_02,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=salida_notspam policy=salida score=0 mlxlogscore=695 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2309180000
 definitions=main-2310010040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231001_060340_150539_CCC989DB 
X-CRM114-Status: GOOD (  15.47  )
X-Mailman-Approved-At: Wed, 04 Oct 2023 12:50:41 -0700
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

T24gU2F0LCBTZXAgMzAsIDIwMjMgYXQgMDk6NTA6NDFBTSAtMDUwMCwgU3RldmUgRnJlbmNoIHdy
b3RlOgo+IE9uIEZyaSwgU2VwIDI5LCAyMDIzIGF0IDM6MDbigK9BTSBEYXZpZCBIb3dlbGxzIHZp
YSBzYW1iYS10ZWNobmljYWwKPiA8c2FtYmEtdGVjaG5pY2FsQGxpc3RzLnNhbWJhLm9yZz4gd3Jv
dGU6Cj4gPgo+ID4KPiA+IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOgo+
ID4KPiA+ID4gQ29ycmVjdC4gV2UnZCBsb3NlIHNvbWUgZmlkZWxpdHkgaW4gY3VycmVudGx5IHN0
b3JlZCB0aW1lc3RhbXBzLCBidXQgYXMKPiA+ID4gTGludXMgYW5kIFRlZCBwb2ludGVkIG91dCwg
YW55dGhpbmcgYmVsb3cgfjEwMG5zIGdyYW51bGFyaXR5IGlzCj4gPiA+IGVmZmVjdGl2ZWx5IGp1
c3Qgbm9pc2UsIGFzIHRoYXQncyB0aGUgZmxvb3Igb3ZlcmhlYWQgZm9yIGNhbGxpbmcgaW50bwo+
ID4gPiB0aGUga2VybmVsLiBJdCdzIGhhcmQgdG8gYXJndWUgdGhhdCBhbnkgYXBwbGljYXRpb24g
bmVlZHMgdGhhdCBzb3J0IG9mCj4gPiA+IHRpbWVzdGFtcCByZXNvbHV0aW9uLCBhdCBsZWFzdCB3
aXRoIGNvbnRlbXBvcmFyeSBoYXJkd2FyZS4KPiA+Cj4gPiBBbGJlaXQgd2l0aCB0aGUgZGFuZ2Vy
IG9mIG1ha2luZyBTdGV2ZSBGcmVuY2ggdmVyeSBoYXBweTstKSwgd291bGQgaXQgbWFrZQo+ID4g
c2Vuc2UgdG8gc3dpdGNoIGludGVybmFsbHkgdG8gTWljcm9zb2Z0LXN0eWxlIDY0LWJpdCB0aW1l
c3RhbXBzIHdpdGggdGhlaXIKPiA+IDEwMG5zIGdyYW51bGFyaXR5Pwo+IAo+IDEwMG5zIGdyYW51
bGFyaXR5IGRvZXMgc2VlbSB0byBtYWtlIHNlbnNlIGFuZCBJSVJDIHdhcyB1c2VkIGJ5IHZhcmlv
dXMKPiBEQ0Ugc3RhbmRhcmRzIGluIHRoZSA5MHMgYW5kIDIwMDBzIChub3QganVzdCB1c2VkIGZv
ciBTTUIyL1NNQjMgcHJvdG9jb2wgYW5kCj4gdmFyaW91cyBXaW5kb3dzIGZpbGVzeXN0ZW1zKQoK
SGlzdG9yaWNhbGx5IGl0IHByb2JhYmx5IGNvbWVzIGZyb20gVk1TLCB3aGVyZSBzeXN0ZW0gdGlt
ZSBhbmQgZmlsZQp0aW1lc3RhbXBzIHdlcmUgYSA2NCBiaXQgaW50ZWdlciBjb3VudGluZyBpbiAx
MDBucyB1bml0cyBzdGFydGluZyBvbiBNSkQKMjQwMDAwMC41IChOb3YgMTd0aCAxODU4KS4KCkdh
YnJpZWwKCj4gCj4gCj4gLS0gCj4gVGhhbmtzLAo+IAo+IFN0ZXZlCiAKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QK
bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
