Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06740606A32A
	for <linux-um@archiver.kernel.org>; Tue, 17 Nov 2026 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1FqgK1Eq;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=0GAKIdqw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hDWO0Tpk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=C7sWl1wG48MQ07r4zoW2vh68HNiuHxVXcgb2L1fNbYE=; b=1FqgK1EqoNUXVNGlY03mKxH+3w
	OsVOwLqF1gMGMvG3bw3dCENioqtivhgAiwU3lLFFLxYeZXDnq+QDPksSYyOqJXgJ1JnsDMw51YW7c
	kASCX4z66ueryd5iCqDJ4jAsgJ6IcPGfuk5OlGDvLFRPOE9qKnYZ0tyHzv7rQg3PSz0mQ1nyYiikR
	d8PAWxLXy6I+E6SOOqiAkk7k9A1NVQDC3RTNUXkS0j6hEXT/4UIjJzcPAgKPzXs0uvB7/aavpVF5j
	xbaN9Boxl+FXuz2Mu8kEosxIVEm+Q8eMHWRkbATz13k+dnZBlOGoOTg4sOjyR6IoxhUp4T0bVlGxc
	DC2JFDNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6e8-00000004EAR-349Q;
	Tue, 17 Nov 2026 00:02:00 +0000
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6e4-00000004E8k-3Z4l
	for linux-um@lists.infradead.org;
	Tue, 17 Nov 2026 00:01:59 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A4B1EC087D
	for <linux-um@lists.infradead.org>; Mon, 16 Nov 2026 19:01:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 16 Nov 2026 19:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1794873715;
	 x=1794960115; bh=C7sWl1wG48MQ07r4zoW2vh68HNiuHxVXcgb2L1fNbYE=; b=
	0GAKIdqwLEVc4s2GojNoid6jRJ4e9UF1YhZqqdeXkcLiCeOdQOkFEK1+1J6MiywO
	Ctc47Sd4XX5N1RAywkHl2itA08MmiYtpqAj+4BZII0e/cECUcDT7LEM567MZxPSb
	AV7CzOR03NLhDeRszgE8MEIKuMKeldIhBjcTTKfd3wgsHRhDw+y5SR8gika4vKiQ
	aq03JqD0ACawK6iuwEKWkpEKmkHGSqdae95BHtW49d448zOtgOGCMxWfmzwIyhGV
	/GIg5Y2QsHRd4qQVgJDt7kDnWE2bptPeg3Z7o0JVM8I41UgIAqdLP3BosXAMseTV
	DV5ONpYrJ+TBTLJ1eoMp/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794873715; x=1794960115; bh=C
	7sWl1wG48MQ07r4zoW2vh68HNiuHxVXcgb2L1fNbYE=; b=hDWO0Tpkh8TVL5xtZ
	kfX755qHlI7pUIVjrsV6ptN3irpKvydI/BjoMhrIdt811u4ENuIq0R+2ULRWYb3t
	GmSBS98/6kCPAjNVfTK4mwPW1SbzbNICVBiPfRRoaeOKxqIvGoF/c7SHNOQuGXgc
	ZUPd5/H29vm/VF2s7BBguXzwXcvB9deD36iIQOcjgr01p8jRHvRplP6HZLU1pniG
	WPCbe4s1yC6oQOIuFpp9YNZNF6fse5xdBYxF7vNWB4+EydAy8IaHl7hUAl5+lBhB
	HE0G3cns3+krFT7QxgWOboCPbGxJudxmbVasRHBdK96wu4Ye5gbsc0mQxnhP7fPP
	cfa8w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794873715; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:QN0EQ7aSIlrYKWLL8U2GZ4HiiAKK6kah+VetPb4rPr17J0z
	VNvPnT2fhEi9G5BZ5g8bcmQeUoF8E2uedp4gAxlSt5H3gKt0wB0yovGuLvSaLyQJ
	DG7rvNzaclTbNv98PW5bbVt6Fk9Cc/qxB2w/7qioW9bl0tRTDkvzTRuJyuBIJlen
	zgJpk+iIjnl3TkPL31pp2tdHVSO3dZuZ8lhDpQf7z20Ptcavnb6ZmwlbqgngYd3K
	uIVijD2npkaqD1IiAcc0HLDogh4gKWRk2mwpz3vyYUm7c6EteS5CJhVwyGk8/v2d
	D45Sv8auh8qVLTU5c4yeJ0DvRKTmyI+EMYEpYxQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:oMgQUvucOl4P8cRbGNSDfSmjEMYlFoatWXuIC44BE+U=:Xd1WqezOWR4RGPff0oXZeRAR/TSzcmc9gClT/ovY9uY=;
X-ME-Sender: <xms:c5n7auHIDLqext--NfPK41UrohZQXd0SzE6AZTWr80YVP8AoZStPnA>
    <xme:c5n7agpfKZ_bWH9UfTqc6QV80jgqT3Cxw-8pzDT6ibfG1F5tyRHJfsNPCObMuDUUz
    Axt3fUdqUgPVR1XIcbShEMrSsxQx1YSynW7FPX4cxcTGzOeiA>
X-ME-Received: <xmr:c5n7asx3Z9RUj2zvBcr2ZzYcKB_mLlXQ-_z0xDfiv6lH4YgDy0VEMsJXbKTX982XKOObdKynv5fUkjnPAQ7BoXgEb94PGgc>
X-ME-Proxy-Cause: dmFkZTEWLllwmZbCQ7cO93As6sGHtjiFdYj9k/VSqMvUwk1xfk9pKn/ZCX7mnpLkIaqMef
    K/82szmVYemJN/I0DCAIOCHeaPZ7/Xa2GnBqk902ewdx8hjF22LzMBgW8kwMwZuhDEqmG+
    fRzfUtzcgzHNqdnt0hptgxxppIMFQUfVlAsIvg7fvTNv54Da321pj6NeCTNh6yP98D0Rix
    0qUujhXor+6vA1uX99KaZah7Remd9bF8xjGXqzB2MsscQiqTyvs6dLxlge9fkMF8nj1I3u
    +RSOpU+TvlDvjmsK8NtReLJ34nN/1FLS6YOAknIb84eISWftGKSVwY1LnVjpVMr2cR7DsZ
    w8Wb5rwjaydSGelossxx6bl1V7hOhKVIq+toFprLFYhRN/SlwVDMmaYKduO57Gh7OaGuBF
    h0J4sIrwb2zt8R9hW4hgNqcN8fzRhYzaDBPcxdVTtNH2vUX1m4VQoIpenYJuGlyjzLN8sB
    wi/kGQQCcooy0DrWZfM2ov3GXkEVgq5I5zBJSiuy+vPMURU0NBtPZQS/3EdbHTkVso2+v4
    Ckv+2iECJM88DmP71AxqjfON8WBYjJIHFkY7G93aYb/jDcLJHw/cEvt0enpH8T0capz27l
    7RHejCjOiJI++LMcjLuNNKGl98A5MSAixcFcvWSPAd1YIjZgNtMRDKNYJgpw
X-ME-Proxy: <xmx:c5n7aqzxemjS9U4i14HWz_7__2CGVeJd1tw-oWJDEKQSsotVnV7kDg>
    <xmx:c5n7arQLLyrbTJvbO20jPnJTo41ac5-vdVcPNcnbsMdF1dKQLTjPAQ>
    <xmx:c5n7atN66DenQEH96djIUqJ5Zw6Bk0MjIDbmoJsZlIcD-oCpa1d04Q>
    <xmx:c5n7amQhmLWxxD2dZ3fFuI1Epj5bjY1tlmr-dTsDkRq6C0NXp3s3nA>
    <xmx:c5n7aosnP57ugyhY2Otjf1KpVZNHti6cwXLd9I_thE6BHShMSvWCjukE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 19:01:50 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Carlos Maiolino <cem@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	ntfs@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: [PATCH v2 3/4] hostfs: don't d_drop() before d_splice_alias() in hostfs_mkdir()
Date: Tue, 17 Nov 2026 10:55:00 +1100
Message-ID: <20261117000115.1433875-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261117000115.1433875-1-neilb@ownmail.net>
References: <20261117000115.1433875-1-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_160157_076197_F00D2F4C 
X-CRM114-Status: UNSURE (   8.88  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: NeilBrown <neil@brown.name>

hostfs_mkdir() uses d_drop() and d_splice_alias() to ensure it has the
right dentry after a mkdir.
d_drop() is no longer needed here and will cause problem for future
changes to directory locking.  So remove the d_drop().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/hostfs/hostfs_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 613146e76dec..7cf25c29cb78 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -700,7 +700,6 @@ static struct dentry *hostfs_mkdir(const struct mnt_idmap *idmap, struct inode *
 		dentry = ERR_PTR(err);
 	} else {
 		inode = hostfs_iget(dentry->d_sb, file);
-		d_drop(dentry);
 		dentry = d_splice_alias(inode, dentry);
 	}
 	__putname(file);
-- 
2.50.0.107.gf914562f5916.dirty


