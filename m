Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154CAC48BF6
	for <linux-um@archiver.kernel.org>; Thu,  7 Mar 2024 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vkFekbspeK5lcVDIHIUxDZO/hMV0UJA60B9DU9IECYA=; b=WOUU8+CkR3+ZkGIYwbyZtccSXB
	qGZeArpBfFeiPaOx+hh41PwYblZNitm+ii0nl+avWSxxgRHtlDzMxlPnT2pKybXho6aWG/pbtI9cH
	1IP06orWbpu6URRdTywml95oLeTqW7qkLNRhJxE63NuzjvOJHQh8MH2XJ/Y/kkiUVzAHqHA+zJ3s3
	kgmpHE8DAk0os0wrZCRXTRrWsyj38FkpkiWI5k/oSk5mC2HDH1OFAjY3PCJhuMnPwRfNSAHSodn7H
	IatqNwPY+Gwtc3qN3Md8h0m7RGYTS50ctZuZ1lmbCimGrOhthkIKsl3p1LXtgXvNyyUiaQnkOTT47
	KZEZ81ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riB0a-000000045ja-1yPX;
	Thu, 07 Mar 2024 10:29:52 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riB0X-000000045iw-2Jzn
	for linux-um@lists.infradead.org;
	Thu, 07 Mar 2024 10:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vkFekbspeK5lcVDIHIUxDZO/hMV0UJA60B9DU9IECYA=;
	t=1709807389; x=1711016989; b=VGXnNUZc/P+de7Tg501CT7kEHoKPGlCOF2QDGMat4UUqhS7
	2v3zjshr7AuDqSvfjMnljY7gcYAkCHcxVWWieaYkm9LKqAheQhVL8+cpjBhVPyckZD3sAxgbfL3fb
	um/KRyGcNu5pi6k2gEFmvQ+jzoYtcJ49Ii1wmrztcyIohfGsSoh/nQ0jy+pXHFjZCilZjZvqDLwSR
	/sUyFduSFqHPbn9BuGysn8iJrXbkbKGbrBttAZq02zMolddMMEYeZG9ejG42DOQiOuA4qY3zzR5iO
	Gz6WR3HRJD0ll/OhwPvfjYnFJbG6ICtS1lZYs6Tc0cl653jbSEQGO05RPLLHuttg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1riB0U-00000005bPH-16fc;
	Thu, 07 Mar 2024 11:29:46 +0100
Message-ID: <a485fbdea26e19afe00f603bd65c83e2be20abe6.camel@sipsolutions.net>
Subject: Re: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Waqar Hameed
	 <waqar.hameed@axis.com>, Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel@axis.com, Richard Weinberger <richard@nod.at>, 
	linux-um@lists.infradead.org
Date: Thu, 07 Mar 2024 11:29:45 +0100
In-Reply-To: <2cc222b7-618c-46a9-b78b-eb099d0f4be7@cambridgegreys.com>
References: <202403052336.y6DkUd8a-lkp@intel.com> <pndzfvbibgm.fsf@axis.com>
	 <87cfca1e-3f53-4935-a274-0920bce86373@cambridgegreys.com>
	 <463be980baf66b967031e3294c3b9745b07aa058.camel@sipsolutions.net>
	 <2cc222b7-618c-46a9-b78b-eb099d0f4be7@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_022949_739629_48D84061 
X-CRM114-Status: GOOD (  13.73  )
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

On Thu, 2024-03-07 at 10:27 +0000, Anton Ivanov wrote:
> >=20
> > How's that required to be formatted and loaded? tcpdump itself can also
> > dump the filter in BPF format, with -d/-ddd (-dd is a C representation,
> > so probably not useful). Perhaps we could even automatically call
> > 'tcpdump' at runtime?
>=20
> That is one option.
>=20
> As far as common use cases are concerned, at present you can:
>=20
> tcpdump -ddd, convert it to raw binary (3 liner in a language of choice) =
and pass that to vecX as a bpffile=3D
>=20
> It may be worth it to make vecX also take the -ddd format directly by add=
ing "format" options to bpffile.
>=20
> I'd rather do that instead of invoking tcpdump out of a device open. The =
-ddd notation (+/- a comma here and there) is
> standard - it is also used by iptables, etc. It can used by other code ge=
nerators as well.

Yeah, that makes sense, this is all kind of special configuration
anyway, and given that it's been broken forever ...

I actually doubt anyone would scream if we just removed it, so maybe
just remove it and if they do scream, point to the above, including said
3-liner in the response?

johannes

