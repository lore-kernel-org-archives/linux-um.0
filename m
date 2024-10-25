Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C964ED0C5F8
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 09:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y5xwwIYNKd2GpnAtE56WXV/B+R3Uy49Vn/yzPWu7Fb4=; b=M8G1inEiaXTkkhvAFTcjzTO5P/
	KVqIbpY2w23h8FtlrRwEcC6EVMklLW6LU7VTI2SF3tSlXrj+PiNqbEHzegjxRyq88E7YZDxmDrY47
	d4ZE2hYjG1aVyS1evyhLTRKvBziH6TR7EOMDwsdu0iB36XJ2ovQscpkStI6Wiu9ww+O/NI5SMbScy
	DGVT5JQGMoV8Ks0eRNmRmPkv+fsYyXzhq/21Cv/G7K6Sh16I+Enq0gCYOo+eGJFQ5Yt5C7lFTj1h2
	OtqVqXOe0KqDZI9FVjvCo597C1Mv28UZsFhu7Fi/LUIWMRPLqjqKdruiBpOyp81IgrX+HVon9HSDq
	hNOlUgSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GnG-00000003CdZ-1Bmg;
	Fri, 25 Oct 2024 09:39:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Gkt-00000003C3y-0Gwp
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 09:37:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Y5xwwIYNKd2GpnAtE56WXV/B+R3Uy49Vn/yzPWu7Fb4=;
	t=1729849034; x=1731058634; b=YKc92tuup0ZMP/tHZD7b8Z3gcanUxk7ny2vTjwnbgZ1eRqo
	5x+CsgwA1NeFQ0z2BUjSO3r72uYRpb/8/Vzp6tI3T9KDr07Fpo2KbPw12vjx+PHOuw5t72BQquOL8
	MhJVtNV3+9QmVwojLRTAsOQOXLihUZ/1K3g5E1YWJdVqvciVuxTHEi88wN1j0bYjQDjwBN+aoXX4e
	zRcYaNmLcAE3P/PlkxTjh3Zu5ICJ5tr7ta63IH8Jt4Rmg05zf9L/J+49Q3izeyht0C/kjkvk8A0Ph
	ZvFhrLs2+W+F8BSpNJhodIjz82rr67HIC/0MLQ++VsCNox8y5/HzygntBSK8wUwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4Gkq-00000004SyX-1MOa;
	Fri, 25 Oct 2024 11:37:12 +0200
Message-ID: <8926c205386e9b71f05764441b7a44a24964f50e.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] um: Set parent-death signal for sub-processes
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Oct 2024 11:37:11 +0200
In-Reply-To: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
References: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_023715_134929_17C4F24D 
X-CRM114-Status: UNSURE (   5.97  )
X-CRM114-Notice: Please train this message.
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, 2024-10-24 at 22:28 +0800, Tiwei Bie wrote:
> The ubd io and write_sigio threads/processes may leak e.g. when
> the main process is killed by "kill -9". Fix it by setting the
> parent-death signal for them.
>=20

I always used killall, but yeah, good idea, thanks!

johannes

