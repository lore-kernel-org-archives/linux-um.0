Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7346EE49A5
	for <linux-um@archiver.kernel.org>; Sat, 19 Aug 2023 23:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hwq/OCv7hLxR0UXAq1G/O6MF5XQ/bCZSeci+3OHsvsQ=; b=ysMdwZp5ikKM2P
	YkauZuL6NP1GBeYHPtcO4CesyiJgytB1E2IEvRJ7fe2tN2AERPLqAshFxwOprGIPWtOvbRYbOi4jq
	OuQmWj98RCiSOKNOBgt19D8ILZd8Amhq88Y1EUyM713y6cGJqXiS2/gQ9csRvTwbeLxDChAgw4Qyh
	CrNL/7UIqXsN/0xx6+ivl9AJm3uxRskNUDVZShJjb6XLiIt+qE+VgyT0uKXtHbOk3r5jZIh5fElOU
	JVs1kHsSkSj88L3J5EXib1fHDCKKzhdRoFcYsTYnS9R8vBxluC3SOSclByrwFusrgwAFSmfc2m6dQ
	s81Yq9XE9QesmSTXFYZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXUzk-00BEHn-1S;
	Sat, 19 Aug 2023 23:04:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXUzh-00BEHB-2Y
	for linux-um@lists.infradead.org;
	Sat, 19 Aug 2023 23:04:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 73A12619B6
	for <linux-um@lists.infradead.org>; Sat, 19 Aug 2023 23:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B74CC43397
	for <linux-um@lists.infradead.org>; Sat, 19 Aug 2023 23:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692486271;
	bh=+j9WRqednGH1+NxFhVTgnVGn/8Qvkzl/efsDkEK8uhM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HO4PfW0Vmh2ehaeIt++wBNm79ATKd11hq0U5+B92cMoT0BOBJwmRzCK/BxSCcHvi5
	 CC6Ti8JOyjOx4hdHkMq1AcyrjnkKmLLWs0LkOgrWYuRFynrTqoPe73eVLPTarYzKaJ
	 XF6cD0Hl+395lViiWPxkvk2mqav6W2V9mkJPoKd/j1PLX5puLu5mQZKLVhgZtyeKXi
	 k5/PpZJn8kZb+QTLeWm3CDsZujElEKEOz/6gYmjppYRGKY0XQ5to2ochUpNCZpiqs6
	 2KehJ9QZzz5+N6No8so/oKVYySVa3goKhpXcG72PLtmrRR16oAShvhdc3vS8ftLNeu
	 mZsaSqlY2tGXw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-56d8bc0d909so1399965eaf.3
        for <linux-um@lists.infradead.org>; Sat, 19 Aug 2023 16:04:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YyKdxEO5cz4VrVv+rFQcV6s3RZkT/TF/MparFASbQTTj2VtGUt1
	XeEVTkkOx9nzmxwZ1PJJ3vKbXDGhXf817BpyB98=
X-Google-Smtp-Source: AGHT+IGyF9vfyHiext9WLpiou5vaMm6T5IbSdf7XdCrPvrTrtIwD+GibBH5g6g7fKzc0ObxkJ0SuXemN3HeHkHD2wuM=
X-Received: by 2002:aca:2216:0:b0:3a7:83f6:9d19 with SMTP id
 b22-20020aca2216000000b003a783f69d19mr3868919oic.51.1692486270519; Sat, 19
 Aug 2023 16:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230721171857.3612639-1-masahiroy@kernel.org> <707999896.6490583.1692479291135.JavaMail.zimbra@nod.at>
In-Reply-To: <707999896.6490583.1692479291135.JavaMail.zimbra@nod.at>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 20 Aug 2023 08:03:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATX4uekv=W9Rsvwxc-3fuNJvUZsAO49qV_TCzsWZu76XA@mail.gmail.com>
Message-ID: <CAK7LNATX4uekv=W9Rsvwxc-3fuNJvUZsAO49qV_TCzsWZu76XA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] UML: hard-code the result of 'uname -s'
To: Richard Weinberger <richard@nod.at>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, bp <bp@alien8.de>, 
	dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>, mingo <mingo@redhat.com>, 
	tglx <tglx@linutronix.de>, x86 <x86@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230819_160433_869890_147F2C39 
X-CRM114-Status: GOOD (  12.43  )
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

T24gU3VuLCBBdWcgMjAsIDIwMjMgYXQgNjoxNeKAr0FNIFJpY2hhcmQgV2VpbmJlcmdlciA8cmlj
aGFyZEBub2QuYXQ+IHdyb3RlOgo+Cj4gLS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+
ID4gVm9uOiAibWFzYWhpcm95IiA8bWFzYWhpcm95QGtlcm5lbC5vcmc+Cj4gPiBXZSByZWx5IG9u
ICd1bmFtZSAtcycgcmV0dXJuaW5nICdMaW51eCcgYmVjYXVzZSB0aGVyZSBhcmUgb3MtTGludXgv
Cj4gPiBkaXJlY3RvcmllcywgYnV0IG5vIG90aGVyIG9zLSovLgo+ID4KPiA+IFN1cHBvcnRpbmcg
YSBub24tTGludXggaG9zdCBpcyB1bmxpa2VseSB0byBoYXBwZW4uCj4gPgo+ID4gTGV0J3MgaGFy
ZC1jb2RlICdMaW51eCcuCj4KPiBXaGlsZSBJIGFncmVlIHRoYXQgYSBub24tTGludXggdmVyc2lv
biBpcyB1bmxpa2VseSBJJ2QgbGlrZSB0bwo+IGtub3cgd2h5IHdlIGNhbid0IGtlZXAgdGhlIHVu
YW1lIC1zIGNoZWNrPwo+IEkgZ3Vlc3MgdG8gYXZvaWQgdW5uZWNlc3NhcnkgY29tbWFuZCBleGVj
dXRpb24/CgoKCkp1c3QgYmVjYXVzZSAndW5hbWUgLXMnIGlzIG1lYW5pbmdsZXNzLgoKSnVzdCBi
dWlsZCAnTGludXgnIG9uZXMgaXJyZXNwZWN0aXZlIG9mIHRoZSBob3N0IHBsYXRmb3JtLgpJZiBp
dCB3b3JrcywgaXQgd29ya3MuCklmIG5vdCwgaXQgZG9lcyBub3Qgd29yay4KCgoKCi0tIApCZXN0
IFJlZ2FyZHMKTWFzYWhpcm8gWWFtYWRhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==
