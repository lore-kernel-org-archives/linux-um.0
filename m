Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EB8C4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sOweXI35fJEX7TaL1KY6lKJ4Ci7OIE04l9EyjKhOXZM=; b=pc5V20IE/8DSxF6xz6v8v7ciiR
	E/43A9tXYu3hFd84wleciu0Bal4gg+1+UOJL3zmnoD80ouRNKQVRqC2qQ7rMfKfcLVbqCm+MWj/bF
	Qep686RX2oN+PFCjGqt8hBrEhvqRH1nkHochivYOvT7XGXjxEB2wXvtafZJ/xZIbnQn78YWyT8S7q
	aOknuHMQX2CjvFTEhvpvh0i/XecQ3ETuxr96ONUSQq8XrFLaNqLZs0Yw/dqRGQLT2xuJ+J1C1vj8E
	kc9cBXfdjTCV4JriWqsSXItcbVTIG4wEDWNvLUNDuyJKJpO17W2ohHOnniqY9+N5E/mUWOOrDLWgo
	8fJSkTQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFAZ-0000000HMQC-3ivI;
	Tue, 23 Apr 2024 12:22:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFAX-0000000HMHl-1J7p
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 12:22:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sOweXI35fJEX7TaL1KY6lKJ4Ci7OIE04l9EyjKhOXZM=;
	t=1713874925; x=1715084525; b=R7elTYlwbPQgVzpF/DXNAGMkidjTLcnkxULM2FH17jS5NyZ
	NnNPYjL0Va9tBskvQqiP1O8YObhKkbc//slToW2vOgSSiwSTUBCJQu/gXHOqGnYMj4ITIy7X07AvM
	FZmHvIuQwEK//wOAVCgasxhPtBqBmbxYHSADTriUsvmj81PHDjjJqLr4cIQoEQzpnsyZDsrPzsRpQ
	yspXRH0OACsAP8pZ7QO/QO0roA8ImnCal1CqhuEomMN85YIydgPEJwyyBz7Kh7V3JcKRpEtap0qf8
	h2cDA1cnGa1k2rJpyF0vJPS6NxMNr4d3Wq3UaRdMfv0KXTYGqeCgb/bkaTLDNL6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzF9t-000000027hu-3mGu;
	Tue, 23 Apr 2024 14:22:02 +0200
Message-ID: <21cd05c895abc4f4e66190b26632543ff7990b32.camel@sipsolutions.net>
Subject: Re: [PATCH 5/7] um: Add an internal header shared among the user
 code
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2024 14:22:00 +0200
In-Reply-To: <ee636701-3f92-4424-8b04-dd2cecd8313a@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
	 <20240423112457.2409319-6-tiwei.btw@antgroup.com>
	 <e850e5016348805e7e2f427ed98cb1eb539fc434.camel@sipsolutions.net>
	 <ee636701-3f92-4424-8b04-dd2cecd8313a@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_052241_370471_39C0F6A1 
X-CRM114-Status: GOOD (  15.06  )
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

On Tue, 2024-04-23 at 20:09 +0800, Tiwei Bie wrote:
> On 4/23/24 7:30 PM, Johannes Berg wrote:
> > On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
> > >=20
> > >  $(USER_OBJS:.o=3D.%): \
> > > -	c_flags =3D -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/i=
nclude/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
> > > +	c_flags =3D -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/i=
nclude/linux/kern_levels.h \
> > > +		-include user.h -include $(srctree)/arch/um/os-Linux/internal.h $(=
CFLAGS_$(basetarget).o)
> > >=20
> >=20
> > Why not just include it explicitly?
>=20
> I think it might be more convenient if we include it implicitly,
> especially since there are two levels of directories under os-Linux/.
> But I don't have a strong opinion on this. I'm also willing to
> include it explicitly.

Yeah, ok, dunno.

> > We do have the warnings?
>=20
> Yeah. Without this patch, I can get below warnings with `make ARCH=3Dum d=
efconfig && make ARCH=3Dum`:
>=20

Sure. I meant, we don't need to hide the include, if we need to add it
to some other file, we'll have the warnings as a reminder. :)

I don't think anyone today would write the code as it is now ...

johannes

