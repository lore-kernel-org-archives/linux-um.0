Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C805AEE3EC2
	for <linux-um@archiver.kernel.org>; Sat,  9 Sep 2023 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g4m/mBAGWnzIyBcQWcdLaTSmi2PaCqJQIHBxtxepudo=; b=BdhA/JQP04ONAq
	xG0cPmSvY+ll67HF7HyymdSXMlyXWc2Gl0gRV/gzDw7ufP9rBOc0vk6qRdRKREBpzlEG5DbxCG9Kh
	DKsAbyz7LJYNabDOufT1E/mlZszFfWkbJQsODJdBO7sR8XasMOJaKCmdVvTBiJAgLj5svZeLxgZKg
	U8+/wwA935Oxnz/wTsN0J2YmV374hiHTYVGMAmdw+laq/zMco55RJKpSXdH+1NiW1DPtDih9eK/iY
	FkE7unIUGccICOJgroYvwOLagsc3f/AfaBRWWazzORUiGGxaGo0dWl7Db9Mt/3Jct25L5Yc6V7ULh
	4PTsCf9vw1vaGy/CwI1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qf12K-00Fdzr-2n;
	Sat, 09 Sep 2023 16:42:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qb9OP-00CXHf-1k
	for linux-um@lists.infradead.org;
	Wed, 30 Aug 2023 00:49:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 727CE61187;
	Wed, 30 Aug 2023 00:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15649C433C8;
	Wed, 30 Aug 2023 00:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693356547;
	bh=Y6mimTT4f5bHTNOgMAPJs7UzoDd9JcRrnEgta8s7/7g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R2eMjMGcVP6twJXzPd3GjCC/QAkoBXyIXwyF0PetiX1VDQJtkSU/FrVUdLPhlHeJk
	 dBHqNW4EShjtZaWh7sFQvaiUl3mq77UH9KDN3DI2snJ6o1c+81N9JuEjNxovdv+bSx
	 sgcIB4JoE+RW7C4bNpHemTP/NmKBpTL7+v/S4iHTHVlduZjb2wd1jti+ZtvOSZrtwV
	 l+HJJMf2BwuQ5fHlwOGaHAX0BTHl6xVSRaJy3EeRODk9yD0xK9grM4eFB73+9nNR6U
	 SUPRRhBT9hKA3cHo92ct+4AiPcoeZ/GYLow2fGYu2g/oM5lHg/5skk6mbUINrwlVsy
	 FRJBQs41w8qcA==
Message-ID: <d73e7de5056a34578a193185770e46584450d8b7.camel@kernel.org>
Subject: Re: [PATCH v2 08/92] fs: new helper: simple_rename_timestamp
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: jk@ozlabs.org, arnd@arndb.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, maco@android.com,  joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com, surenb@google.com, dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca, leon@kernel.org, bwarrum@linux.ibm.com, rituagar@linux.ibm.com, ericvh@kernel.org, lucho@ionkov.net,  asmadeus@codewreck.org, linux_oss@crudebyte.com, dsterba@suse.com,  dhowells@redhat.com, marc.dionne@auristor.com, raven@themaw.net, luisbg@kernel.org,  salah.triki@gmail.com, aivazian.tigran@gmail.com, ebiederm@xmission.com,  keescook@chromium.org, clm@fb.com, josef@toxicpanda.com, xiubli@redhat.com,  idryomov@gmail.com, jaharkes@cs.cmu.edu, coda@cs.cmu.edu, jlbec@evilplan.org,  hch@lst.de, nico@fluxnic.net, rafael@kernel.org, code@tyhicks.com, ardb@kernel.org, xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,  linkinjeon@kernel.org, sj1557.seo@samsung.com, jack@suse.com, tytso@mit.edu,  adilger.kernel@dilger.ca, jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp,  miklos@szeredi.hu, rpeterso@redhat.com, agruenba@redhat.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, mikulas@artax.karlin.mff.cuni.cz, mike.kravetz@oracle.com, muchun.song@linux.dev,  dwmw2@infradead.org, shaggy@kernel.org, tj@kernel.org,  trond.myklebust@hammerspace.com, anna@kernel.org, chuck.lever@oracle.com,  neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,  konishi.ryusuke@gmail.com, anton@tuxera.com,  almaz.alexandrovich@paragon-software.com, mark@fasheh.com,  joseph.qi@linux.alibaba.com, me@bobcopeland.com, hubcap@omnibond.com,  martin@omnibond.com, amir73il@gmail.com, mcgrof@kernel.org, yzaikin@google.com,  tony.luck@intel.com, gpiccoli@igalia.com, al@alarsen.net, sfrench@samba.org,  pc@manguebit.com, lsahlber@redhat.com, sprasad@microsoft.com,  senozhatsky@chromium.org, phillip@squashfs.org.uk, rostedt@goodmis.org,  mhiramat@kernel.org, dushistov@mail.ru, hdegoede@redhat.com, djwong@kernel.org, dlemoal@kernel.org, naohiro.aota@wdc.com, jth@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,  yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,  haoluo@google.com, jolsa@kernel.org, hughd@google.com, akpm@linux-foundation.org,  davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,  john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,  serge@hallyn.com, stephen.smalley.work@gmail.com, eparis@parisplace.org,  jgross@suse.com, stern@rowland.harvard.edu, lrh2000@pku.edu.cn, sebastian.reichel@collabora.com, wsa+renesas@sang-engineering.com, quic_ugoswami@quicinc.com, quic_linyyuan@quicinc.com, john@keeping.me.uk, error27@gmail.com, quic_uaggarwa@quicinc.com, hayama@lineo.co.jp, jomajm@gmail.com,  axboe@kernel.dk, dhavale@google.com, dchinner@redhat.com, hannes@cmpxchg.org,  zhangpeng362@huawei.com, slava@dubeyko.com, gargaditya08@live.com, penguin-kernel@i-love.sakura.ne.jp, yifeliu@cs.stonybrook.edu, madkar@cs.stonybrook.edu, ezk@cs.stonybrook.edu, yuzhe@nfschina.com, willy@infradead.org, okanatov@gmail.com, jeffxu@chromium.org, linux@treblig.org,  mirimmad17@gmail.com, yijiangshan@kylinos.cn, yang.yang29@zte.com.cn,  xu.xin16@zte.com.cn, chengzhihao1@huawei.com, shr@devkernel.io,  Liam.Howlett@oracle.com, adobriyan@gmail.com, chi.minghao@zte.com.cn,  roberto.sassu@huawei.com, linuszeng@tencent.com, bvanassche@acm.org,  zohar@linux.ibm.com, yi.zhang@huawei.com, trix@redhat.com, fmdefrancesco@gmail.com,  ebiggers@google.com, princekumarmaurya06@gmail.com, chenzhongjin@huawei.com,  riel@surriel.com, shaozhengchao@huawei.com, jingyuwang_vip@163.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,  linux-afs@lists.infradead.org, autofs@vger.kernel.org, linux-mm@kvack.org,  linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,  codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, linux-efi@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Date: Tue, 29 Aug 2023 20:48:48 -0400
In-Reply-To: <20230830001917.GC461907@ZenIV>
References: <20230705185812.579118-1-jlayton@kernel.org>
	 <20230705185812.579118-3-jlayton@kernel.org>
	 <20230830001917.GC461907@ZenIV>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_174909_669532_29B2720A 
X-CRM114-Status: GOOD (  12.48  )
X-Mailman-Approved-At: Sat, 09 Sep 2023 09:42:19 -0700
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

On Wed, 2023-08-30 at 01:19 +0100, Al Viro wrote:
> On Wed, Jul 05, 2023 at 02:58:11PM -0400, Jeff Layton wrote:
> 
> > + * POSIX mandates that the old and new parent directories have their ctime and
> > + * mtime updated, and that inodes of @old_dentry and @new_dentry (if any), have
> > + * their ctime updated.
> 
> APPLICATION USAGE
> Some implementations mark for update the last file status change timestamp
> of renamed files and some do not. Applications which make use of the
> last file status change timestamp may behave differently with respect
> to renamed files unless they are designed to allow for either behavior.
>
> So for children POSIX permits rather than mandates.  Doesn't really matter;
> Linux behaviour had been to touch ctime on children since way back, if
> not since the very beginning.

Mea culpa. You're quite correct. I'll plan to roll a small patch to
update the comment over this function.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
