Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69EFC54E49
	for <linux-um@archiver.kernel.org>; Thu,  7 Mar 2024 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JFLuqFDwfQNL2xOZkFhl8oaJxM0htnjHmGADG1CLZbw=; b=2WnzgtfJn5sc7j3mjm5e8+CqNS
	co9UDe2dHsmnVvSQe61IvIBwFzMWUOKPO5QRjVPweHkNiPq916yjQVviP7RSeWYVm/DD2ET5tiKzM
	zUw+GWPq6HxgNeeYh+GiE4mAfz4SzgiYNiUVHKrBELOq/isahIN8byMNg7l2srtAu9qLhLzZokgFA
	KbvvJGBcr6d+VXAUZgttecJoLC7UszmQ68Gu+EowW33FKTDNFQkwdYq7a7g3TlTMdkFgf49JYGTkR
	Rp0SRf0fA32Blbj/C/aMNWu4v1gVT+Lhg/1kj9oaJpebl/So06d8fgf3XfAiDdy5+7LetQPhItQ4P
	h7ofCafQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAbL-000000040Dq-3Ym3;
	Thu, 07 Mar 2024 10:03:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAbI-000000040Bz-2FJR
	for linux-um@lists.infradead.org;
	Thu, 07 Mar 2024 10:03:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JFLuqFDwfQNL2xOZkFhl8oaJxM0htnjHmGADG1CLZbw=;
	t=1709805822; x=1711015422; b=LOBk6Tz6cqlg4okhHkSwxylnBXBPGbrXK5O2iPH4cUlubJu
	yCbd7NWGt82S3BQivTBUdqZPxzY9kIPNAG9ceIcYabDaHcQFaRGIC0ukHSlkaOA8NHIa7XbULuU73
	UTLb7Qg006gU30aGHCrh3l8+uqnZkkWYzJBVYG/IwLuqbSvi9jdXOgeAdcsA2XAl7bV5u73kHH50e
	vhYul4bvG9YsSFx75bxe7CRgIuCWXLBsIsWtEqDXd7ds67DFJgT0Pw3QfRoMhAHHTV8eEJ5wie6we
	3JUvt5Mf63p8CGdh/KlBSPb0MosAGXYyibTu7DO4fs4au2YUlL82GHXEOXx3AagQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1riAb7-00000005aOU-0Sdn;
	Thu, 07 Mar 2024 11:03:33 +0100
Message-ID: <463be980baf66b967031e3294c3b9745b07aa058.camel@sipsolutions.net>
Subject: Re: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Waqar Hameed
	 <waqar.hameed@axis.com>, Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel@axis.com, Richard Weinberger <richard@nod.at>, 
	linux-um@lists.infradead.org
Date: Thu, 07 Mar 2024 11:03:32 +0100
In-Reply-To: <87cfca1e-3f53-4935-a274-0920bce86373@cambridgegreys.com>
References: <202403052336.y6DkUd8a-lkp@intel.com> <pndzfvbibgm.fsf@axis.com>
	 <87cfca1e-3f53-4935-a274-0920bce86373@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_020344_908663_6C6CAC50 
X-CRM114-Status: GOOD (  14.40  )
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

On Thu, 2024-03-07 at 09:54 +0000, Anton Ivanov wrote:
>=20
> PCAP is not feasible to incorporate into the build system at present.
> It has grown all kinds of warts over the years and brings a lot of depend=
encies.
> IMHO we should remove it from the tree. It has reached a point where it c=
annot
> be built on a modern system.

I suppose it might be possible to call pcap-config? But agree that it
doesn't seem really worth investing in.

> The users who need the same functionality can produce a bpf filter using =
tcpdump
> and load it as "firmware" into the vector/raw driver.
>=20
> I am working on a pure python bpf compiler which takes the same syntax as=
 PCAP.
> It is showing signs of life and it can do some of the simpler use cases. =
Once
> that is ready, it should be possible to use that instead of pcap/tcpdump.

How's that required to be formatted and loaded? tcpdump itself can also
dump the filter in BPF format, with -d/-ddd (-dd is a C representation,
so probably not useful). Perhaps we could even automatically call
'tcpdump' at runtime?

johannes

