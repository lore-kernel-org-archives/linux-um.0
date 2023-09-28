Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11CBE728C0
	for <linux-um@archiver.kernel.org>; Fri, 29 Sep 2023 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YuIjyqyRKvIDObqqe5JButardaEFZNjBQna3Laj/9FQ=; b=nHUXY5pw7bhIzD
	d9OwJYXDgRdbt7Z41OiuiO3I1K6OeZ1mcMd+kJd4RVEtSCkIMMxdgvJ3yLgYngjhInVTHXd56he2e
	K9BKyU1i7qTYRFvD0VcWIZzMmj+g1HEBDyWUj8JZbjbpczrp45sgG/+NmobfjtqQpy7/ZH3cCHg5T
	Gh4KRlWjs+Gfp7c7xPly7FWOPuiSF9Q9tVYys2a/8ywd5SvsxnWTAuNqpLDK3oo9NJR98I1pTl8zo
	9deMhQF3MRejvU8+9i2m7IE7JYk+uc2I1VHFuuKigLq/Xc5bujY4NFuUm3DePyl6m+FvINnIoz7en
	z8Z3u6FV2ab83Z8q/uBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmFXi-008CZ9-11;
	Fri, 29 Sep 2023 15:36:38 +0000
Received: from new2-smtp.messagingengine.com ([66.111.4.224])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlxVy-006dKp-1j;
	Thu, 28 Sep 2023 20:21:41 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id B1F00580AFC;
	Thu, 28 Sep 2023 16:21:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 28 Sep 2023 16:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1695932496; x=1695939696; bh=35
	hGd5DtemMMIKF1Zr0cZ5jy7ToQQid1yaZKtlkxNu4=; b=MUE4NuUNxBV8C2JWjX
	zo2RFUMSKG29VIQlMAZyABCgpP48v5BZ44KZaszw31hXuDUzuPiDx8ereQtF5dD2
	PLFYKB3PyaWgEsR5ETEmpmpHqfSHQ7Odga/OxYCV9GE0rrpe22f+TtcRGKKBgE4p
	7FxNm+EQqwAv7unUN5TgjxaMejRA2uHtSpa2Js3W+wqtFsS6IgxDbAUhRsWh+VhD
	uLaUbM6avkh5zQR+6N9Zx9JDAKsSbg9LmnicvYGPTh7TDsxT+GARn4ozY64R48uD
	WxCwxqi++8usWHSn/xI+UWf4NO934b0f9ARH3hYvYSAyI6G04WC/MDS0/PCJ07ht
	beuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695932496; x=1695939696; bh=35hGd5DtemMMI
	KF1Zr0cZ5jy7ToQQid1yaZKtlkxNu4=; b=RJpH1cyYF+4V2cvRJ6GFo4yr8fbFp
	jEodYHfEkn3UI35z/vaw97Pf0Jf+yHdulsu82VxxWClbp5nVTqIjOWEsZeS7alcl
	v2Oyjwsf1HiEEgSIYzzQCTpxZsDqWu5nHMpc206m1GkYgJQ31F+ez10QBTGzyacu
	hF21N3A8NLP/D+OqhcjdBWh9nTd8AkLkN9iZA/9pPm+dpBELiNV6NDmt4sqkPWUs
	GXOqQZGOVp2z8HuKinTOD7MmgubMFQCanxogbQSxveJ5B24D8wi9EuLSBYcPTVZE
	HE+qcGnwW2b7+6r6pgmmqnyCJSk7IxgL6cv5Pr5RzpoA15iNrYa60h3/g==
X-ME-Sender: <xms:T-AVZRR_AGB6vyD5X2xpOUnDOLqeZje1eOqF02Jwf7WxWDIK-cYevA>
    <xme:T-AVZawvyBibQxmkuX48G4Ma04plfeY9CgEiCJ3fjKs39pL9v_1EYlnBolgXynyki
    s7_71GI5NOrDNwhI3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:T-AVZW0sAXrRsUv64R7TtvWoMC17BfivRDJ8l1MU8f3grQi6xmza1g>
    <xmx:T-AVZZBEyb8nHoozbu2kCeslfnmWr_4wgP8EkdniydJfYndeN38qKg>
    <xmx:T-AVZahVT83ov6yzbM8zQVndntmvS8Ff6hYRBpoACSl6U8SQukhXaQ>
    <xmx:UOAVZXInDFE18anTYIFfmSh-8weQMT0A4yBvf6VWoerpsSWpvx4Izw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 360CCB60089; Thu, 28 Sep 2023 16:21:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <ded0ef74-bdad-42f2-b0a7-5d867e446c19@app.fastmail.com>
In-Reply-To: <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
References: <20230928110554.34758-1-jlayton@kernel.org>
 <20230928110554.34758-2-jlayton@kernel.org>
 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com>
 <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
 <20230928171943.GK11439@frogsfrogsfrogs>
 <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
Date: Thu, 28 Sep 2023 16:21:12 -0400
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeff Layton" <jlayton@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>, "David Sterba" <dsterba@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, "Kees Cook" <keescook@chromium.org>, "Jeremy Kerr" <jk@ozlabs.org>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Martijn Coenen" <maco@android.com>, "Joel Fernandes" <joel@joelfernandes.org>, "Carlos Llamas" <cmllamas@google.com>, "Suren Baghdasaryan" <surenb@google.com>, "Mattia Dongili" <malattia@linux.it>, "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>, "Brad Warrum" <bwarrum@linux.ibm.com>, "Ritu Agarwal" <rituagar@linux.ibm.com>, "Hans de Goede" <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Mark Gross" <markgross@kernel.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Eric Van Hensbergen" <ericvh@kernel.org>, "Latchesar Ionkov" <lucho@ionkov.net>, "Dominique Martinet" <asmadeus@codewreck.org>, "Christian Schoenebeck" <linux_oss@crudebyte.com>, "David Sterba" <dsterba@suse.com>, "David Howells" <dhowells@redhat.com>, "Marc Dionne" <marc.dionne@auristor.com>, "Ian Kent" <raven@themaw.net>, "Luis de Bethencourt" <luisbg@kernel.org>, "Salah Triki" <salah.triki@gmail.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, "Chris Mason" <clm@fb.com>, "Josef Bacik" <josef@toxicpanda.com>, "Xiubo Li" <xiubli@redhat.com>, "Ilya Dryomov" <idryomov@gmail.com>, "Jan Harkes" <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, "Joel Becker" <jlbec@evilplan.org>, "Christoph Hellwig" <hch@lst.de>, "Nicolas Pitre" <nico@fluxnic.net>, "Rafael J . Wysocki" <rafael@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>, "Yue Hu" <huyue2@coolpad.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>, "Namjae Jeon" <linkinjeon@kernel.org>, "Sungjong Seo" <sj1557.seo@samsung.com>, "Jan Kara" <jack@suse.com>, "Andreas Dilger" <adilger.kernel@dilger.ca>, "Jaegeuk Kim" <jaegeuk@kernel.org>, "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>, "Christoph Hellwig" <hch@infradead.org>, "Miklos Szeredi" <miklos@szeredi.hu>, "Bob Peterson" <rpeterso@redhat.com>, "Andreas Gruenbacher" <agruenba@redhat.com>, "Richard Weinberger" <richard@nod.at>, "Anton Ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg" <johannes@sipsolutions.net>, "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>, "Mike Kravetz" <mike.kravetz@oracle.com>, "Muchun Song" <muchun.song@linux.dev>, "Jan Kara" <jack@suse.cz>, "David Woodhouse" <dwmw2@infradead.org>, "Dave Kleikamp" <shaggy@kernel.org>, "Tejun Heo" <tj@kernel.org>, "Trond Myklebust" <trond.myklebust@hammerspace.com>, "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>, "Neil Brown" <neilb@suse.de>, "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>, "Ryusuke Konishi" <konishi.ryusuke@gmail.com>, "Anton Altaparmakov" <anton@tuxera.com>, "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>, "Mark Fasheh" <mark@fasheh.com>, "Joseph Qi" <joseph.qi@linux.alibaba.com>, "Bob Copeland" <me@bobcopeland.com>, "Mike Marshall" <hubcap@omnibond.com>, "Martin Brandenburg" <martin@omnibond.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Iurii Zaikin" <yzaikin@google.com>, "Tony Luck" <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Anders Larsen" <al@alarsen.net>, "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.com>,
 "Ronnie Sahlberg" <lsahlber@redhat.com>, "Shyam Prasad N" <sprasad@microsoft.com>, "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Phillip Lougher" <phillip@squashfs.org.uk>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Evgeniy Dushistov" <dushistov@mail.ru>, "Chandan Babu R" <chandan.babu@oracle.com>, "Damien Le Moal" <dlemoal@kernel.org>, "Naohiro Aota" <naohiro.aota@wdc.com>, "Johannes Thumshirn" <jth@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@google.com>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Hugh Dickins" <hughd@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "David S . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "John Johansen" <john.johansen@canonical.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Eric Paris" <eparis@parisplace.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, linux-efi@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, bpf@vger.kernel.org, Netdev <netdev@vger.kernel.org>, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete integers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_132139_125240_8B5A672F 
X-CRM114-Status: GOOD (  19.42  )
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

On Thu, Sep 28, 2023, at 13:40, Jeff Layton wrote:
> On Thu, 2023-09-28 at 10:19 -0700, Darrick J. Wong wrote:
>>
>> > I remember seeing those patches go by. I don't remember that change
>> > being NaK'ed, but I wasn't paying close attention at the time 
>> > 
>> > Looking at it objectively now, I think it's worth it to recover 8 bytes
>> > per inode and open a 4 byte hole that Amir can use to grow the
>> > i_fsnotify_mask. We might even able to shave off another 12 bytes
>> > eventually if we can move to a single 64-bit word per timestamp. 
>> 
>> I don't think you can, since btrfs timestamps utilize s64 seconds
>> counting in both directions from the Unix epoch.  They also support ns
>> resolution:
>> 
>> 	struct btrfs_timespec {
>> 		__le64 sec;
>> 		__le32 nsec;
>> 	} __attribute__ ((__packed__));
>> 
>
> Correct. We'd lose some fidelity in currently stored timestamps, but as
> Linus and Ted pointed out, anything below ~100ns granularity is
> effectively just noise, as that's the floor overhead for calling into
> the kernel. It's hard to argue that any application needs that sort of
> timestamp resolution, at least with contemporary hardware. 

There are probably applications that have come up with creative
ways to use the timestamp fields of file systems that 94 bits
of data, with both the MSB of the seconds and the LSB of the
nanoseconds carrying information that they expect to be preserved.

Dropping any information in the nanoseconds other than the top two
bits would trivially change the 'ls -t' output when two files have
the same timestamp in one kernel but slightly different timestamps
in another one. For large values of 'tv_sec', there are fewer
obvious things that break, but if current kernels are able to
retrieve arbitrary times that were stored with utimensat(), then we
should probably make sure future kernels can see the same.

        Arnd

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
