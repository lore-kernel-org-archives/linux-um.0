Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86408E7C4EF
	for <linux-um@archiver.kernel.org>; Wed,  4 Oct 2023 19:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jalDf4sqF62mAddFapU/auIqNEl+MIjpiRLnz0WjsBg=; b=X93e8RdxpisuXJ
	V8HFUMv5Gevg4EJzNMqnOixU+RKNCQPjAxmTHG54TZxGaX/H0bawJGzmUWQ4uFwH9HB165GqnzOCm
	83VUI6H5t1iAzF1roqYS7UY6wjpq2ghBa2Zd5MdeHzwPYdly3EAEqkuGddqa1O1k2XQri2fb1MIFQ
	FDzAL0OnQW2OZf2CDkWf5t0XwuQQ93wn4OIW8AkhSnLx6Xp6qNEfZbEeE2N5ykp6NAoCwAZwb/a7d
	7twdRV+9m01O01KYn+k32HL7rsajuoeNjqsqnkf1DwviG6jmzHk9AIAGD5ojDP9kyWUdRNBtayjft
	pYIPxb8xYGRbHboz69NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo7t3-000p0A-2d;
	Wed, 04 Oct 2023 19:50:25 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmbJ3-009hX5-36;
	Sat, 30 Sep 2023 14:50:59 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50567477b29so3457772e87.3;
        Sat, 30 Sep 2023 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696085453; x=1696690253; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laSU2ptF5dJtGJTOfsu2vTDoKsI4bo31YwsLIpMZHsY=;
        b=TFKIXGu6K43EkzQn8DItlQcsICmijMXX3gq/XLFyjaEgYc2e+Nth/Ko6RscsAIA/T7
         Q5t9kLTfy9zBxobNkSNkeB8dfbQTqtMeUx4PpQbtpq+MuE0vBOC0kKcIMkR6Tn1/OP/f
         ub8yK04gBHuo+7su2tm/+i1l9lm611xptDyQpB9J7WZlDf4oqgFLVbP80oGXbnKjuGf7
         wknkZ132510X/fAeBbp2F5En70D1RE6A+dRzTCj1Lhqm66QM7zsV/HQn9v0enWFTY+JT
         MrAjmM8NbDIdh/BAO8OuBboBZ5OcYyiSkup9iENMwAjvckhCDl8OwIcflh7cwZr3pzO/
         D5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696085453; x=1696690253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laSU2ptF5dJtGJTOfsu2vTDoKsI4bo31YwsLIpMZHsY=;
        b=ksywcGIihM6ERaxMremnygU/ZtkOUvcbyEqP1g+e+u5SqRJQctUgJPOoLoMQC6yk+A
         7TaM/EazVcR3yOCNRtLlhdQCoM1r/aZg8xWaZdfrdpyBjZjUgeRwOq0TmC/aY5vSETZ+
         Huqs8QGgboAj4DfeABrJ3cVlIxPvAiwfbwN5sD5WyYjJokkkBjzwJDfWCco/9GglZ4y+
         xPnycDPV9L8m23h0p2kHm9SmwlNa+10JHQ5MYmpxN2qrA54a31fmIF4VlcE8XFzT4TF6
         a89rjw+VCytAWgZiSl3NeL8zrEwxUxhH9Fu29RYX5EWnwlZSyNA6KKDLW7DpTvjADGN/
         rPhA==
X-Gm-Message-State: AOJu0YxrJ97lSONIT1J1JcTb0Q9ibbO3jtOjWtfasgcFqIC0mooHR4nZ
	BV2jJjhNErUKeDG/DDZu6sX7y1oFR+eZGq0OHHQ=
X-Google-Smtp-Source: AGHT+IFKxuEfsWI2Hoye015VefDxXDDWWovJHhYR0GsRnul5m9+uvo7GWv6zNWozBrWHqGB+PwbJIGFbA8W5CapoIHU=
X-Received: by 2002:a05:6512:124a:b0:503:5cd:998b with SMTP id
 fb10-20020a056512124a00b0050305cd998bmr7557694lfb.28.1696085453195; Sat, 30
 Sep 2023 07:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230928110554.34758-1-jlayton@kernel.org> <20230928110554.34758-2-jlayton@kernel.org>
 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com> <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
 <20230928171943.GK11439@frogsfrogsfrogs> <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
 <636661.1695969129@warthog.procyon.org.uk>
In-Reply-To: <636661.1695969129@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Sat, 30 Sep 2023 09:50:41 -0500
Message-ID: <CAH2r5ms14hPaz=Ex2a=Dj0Hz3XxYLRKFj_rHHekznTbNJ_wABQ@mail.gmail.com>
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete integers
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Anders Larsen <al@alarsen.net>, Carlos Llamas <cmllamas@google.com>, Andrii Nakryiko <andrii@kernel.org>, Mattia Dongili <malattia@linux.it>, Hugh Dickins <hughd@google.com>, John Johansen <john.johansen@canonical.com>, Yonghong Song <yonghong.song@linux.dev>, Alexander Gordeev <agordeev@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-xfs@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, James Morris <jmorris@namei.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Christian Borntraeger <borntraeger@linux.ibm.com>, devel@lists.orangefs.org, Shyam Prasad N <sprasad@microsoft.com>, linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Eric Van Hensbergen <ericvh@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anton Altaparmakov <anton@tuxera.com>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Chuck Lever <chuck.lever@oracle.com>, Sven Schnelle <svens@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Jan Kara <jack@suse.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-trace-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Dave Kleikamp <shaggy@kernel.org>, linux-mm@kvack.org, Joel Fernandes <joel@joelfernandes.org>, Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@google.com>, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Leon Romanovsky <leon@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, codalist@coda.cs.cmu.edu, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Todd Kjos <tkjos@android.com>, Vasily Gorbik <gor@linux.ibm.com>, selinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Yue Hu <huyue2@coolpad.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Martijn Coenen <maco@android.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Hao Luo <haoluo@google.com>, Tony Luck <tony.luck@intel.com>, "Theodore Ts'o" <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>, linux-ntfs-dev@lists.sourceforge.net, Muchun Song <muchun.song@linux.dev>, linux-f2fs-devel@lists.sourceforge.net, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, gfs2@lists.linux.dev, "Eric W. Biederman" <ebiederm@xmission.com>, Anna Schumaker <anna@kernel.org>, Brad Warrum <bwarrum@linux.ibm.com>, Mike Kravetz <mike.kravetz@oracle.com>, linux-efi@vger.kernel.org, Martin Brandenburg <martin@omnibond.com>, ocfs2-devel@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>, platform-driver-x86@vger.kernel.org, Chris Mason <clm@fb.com>, linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, Jiri Slaby <jirislaby@kernel.org>, linux-afs@lists.infradead.org, Ian Kent <raven@themaw.net>, Naohiro Aota <naohiro.aota@wdc.com>, Daniel Borkmann <daniel@iogearbox.net>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, linux-rdma@vger.kernel.org, coda@cs.cmu.edu, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Ilya Dryomov <idryomov@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Christian Schoenebeck <linux_oss@crudebyte.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, autofs@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Mark Gross <markgross@kernel.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Eric Paris <eparis@parisplace.org>, ceph-devel@vger.kernel.org, Gao Xiang <xiang@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Song Liu <song@kernel.org>, samba-technical@lists.samba.org, Steve French <sfrench@samba.org>, Jeremy Kerr <jk@ozlabs.org>, Netdev <netdev@vger.kernel.org>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>, Chandan Babu R <chandan.babu@oracle.com>, jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>, Neil Brown <neilb@suse.de>, Dominique Martinet <asmadeus@codewreck.org>, Amir Goldstein <amir73il@gmail.com>, Bob Copeland <me@bobcopeland.com>, KP Singh <kpsingh@kernel.org>, linux-unionfs@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Ard Biesheuvel <ardb@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Dai Ngo <Dai.Ngo@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-serial@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Salah Triki <salah.triki@gmail.com>, Evgeniy Dushistov <dushistov@mail.ru>, linux-cifs@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Chao Yu <chao@kernel.org>, apparmor@lists.ubuntu.com, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Hans de Goede <hdegoede@redhat.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, Johannes Thumshirn <jth@kernel.org>, Ritu Agarwal <rituagar@linux.ibm.com>, Luis de Bethencourt <luisbg@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, v9fs@lists.linux.dev, David Sterba <dsterba@suse.cz>, linux-security-module@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>, Phillip Lougher <phillip@squashfs.org.uk>, Johannes Berg <johannes@sipsolutions.net>, Sungjong Seo <sj1557.seo@samsung.com>, David Woodhouse <dwmw2@infradead.org>, linux-karma-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230930_075058_004805_7B5752AE 
X-CRM114-Status: GOOD (  16.44  )
X-Mailman-Approved-At: Wed, 04 Oct 2023 12:50:24 -0700
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

T24gRnJpLCBTZXAgMjksIDIwMjMgYXQgMzowNuKAr0FNIERhdmlkIEhvd2VsbHMgdmlhIHNhbWJh
LXRlY2huaWNhbAo8c2FtYmEtdGVjaG5pY2FsQGxpc3RzLnNhbWJhLm9yZz4gd3JvdGU6Cj4KPgo+
IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gPiBDb3JyZWN0LiBX
ZSdkIGxvc2Ugc29tZSBmaWRlbGl0eSBpbiBjdXJyZW50bHkgc3RvcmVkIHRpbWVzdGFtcHMsIGJ1
dCBhcwo+ID4gTGludXMgYW5kIFRlZCBwb2ludGVkIG91dCwgYW55dGhpbmcgYmVsb3cgfjEwMG5z
IGdyYW51bGFyaXR5IGlzCj4gPiBlZmZlY3RpdmVseSBqdXN0IG5vaXNlLCBhcyB0aGF0J3MgdGhl
IGZsb29yIG92ZXJoZWFkIGZvciBjYWxsaW5nIGludG8KPiA+IHRoZSBrZXJuZWwuIEl0J3MgaGFy
ZCB0byBhcmd1ZSB0aGF0IGFueSBhcHBsaWNhdGlvbiBuZWVkcyB0aGF0IHNvcnQgb2YKPiA+IHRp
bWVzdGFtcCByZXNvbHV0aW9uLCBhdCBsZWFzdCB3aXRoIGNvbnRlbXBvcmFyeSBoYXJkd2FyZS4K
Pgo+IEFsYmVpdCB3aXRoIHRoZSBkYW5nZXIgb2YgbWFraW5nIFN0ZXZlIEZyZW5jaCB2ZXJ5IGhh
cHB5Oy0pLCB3b3VsZCBpdCBtYWtlCj4gc2Vuc2UgdG8gc3dpdGNoIGludGVybmFsbHkgdG8gTWlj
cm9zb2Z0LXN0eWxlIDY0LWJpdCB0aW1lc3RhbXBzIHdpdGggdGhlaXIKPiAxMDBucyBncmFudWxh
cml0eT8KCjEwMG5zIGdyYW51bGFyaXR5IGRvZXMgc2VlbSB0byBtYWtlIHNlbnNlIGFuZCBJSVJD
IHdhcyB1c2VkIGJ5IHZhcmlvdXMKRENFIHN0YW5kYXJkcyBpbiB0aGUgOTBzIGFuZCAyMDAwcyAo
bm90IGp1c3QgdXNlZCBmb3IgU01CMi9TTUIzIHByb3RvY29sIGFuZAp2YXJpb3VzIFdpbmRvd3Mg
ZmlsZXN5c3RlbXMpCgoKLS0gClRoYW5rcywKClN0ZXZlCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1A
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXVtCg==
