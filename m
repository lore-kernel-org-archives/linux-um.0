Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7D5CD13D2
	for <linux-um@archiver.kernel.org>; Mon, 18 Sep 2023 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Ax6lfm8RQU9okLD0KoG9JBY0iUWtn3pK43UcW0M0Tg=; b=UqM7TpVO8YMDUG
	imt/hfQ1h3XgN0DgtoAZYoTpRBqAn5eOyImHBAd6yHQpLlERaQiAvt8U6JMaLcIwcjg1PExH7SiWz
	lwzDu9/ub3FQY5yCj0m4682tjDz5HlDejMqi+6BZxSHWSKnHxEmr+Mofq3tibVYVTtCFKiryy2FVw
	nYTAh1BziBYksOxQkt/FLr95p5FgqJTD7F4G2J99sPA7/hO4d+Jywat5vQuDsn0vdsS4+gDO4cQLL
	YikWe2T7TbebSc//1gHu/3AaDaW6YmqyYnuEkob6o5+Z/eEUXC55MNiWRO822iQ/2H33vd8vZd2LH
	7fUkDQyzNR9wbJZCxgfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiHEU-00Fsxz-13;
	Mon, 18 Sep 2023 16:36:22 +0000
Received: from mail-4018.proton.ch ([185.70.40.18])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiHER-00Fswz-2r
	for linux-um@lists.infradead.org;
	Mon, 18 Sep 2023 16:36:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695054973; x=1695314173;
	bh=NOCWuGgx6TByWSIA4slIKttyguCA2SmfrwgzSjl+euQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oZe6LP7TdsuCZpLFglGgKNaK7G+ZlzKX9vwpqf4gSmtV6rxEbTUAkGd+KkjC1gx97
	 nQJtu+XHlWVGs8wioYFfsNCinnc+jeXDwlzZnrb+G9/7uwez3Ik3OS6vNOKNApbJVl
	 aEmBFH2NmU6lgO1PEfdgOpNGUK/bnbfwl4H0IXO9Gx0EmC2PzUOHCQMJhNGQgFUzVT
	 nlblEgz6QNQUMggNqUi/Ua1g9Wfrh5XiPyzgoWnGY6GPhveq9AfqHT/rLqZxAfL7qG
	 9D0xJShWzWfsMJ41KKbgWcvfE5zYlPRenX1QAszBd4WGvN26zlD0y58ZziUkJ6E0Uw
	 EVYgCmeygIpDA==
Date: Mon, 18 Sep 2023 16:35:52 +0000
To: geert@linux-m68k.org
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: anton.ivanov@cambridgegreys.com, jack@suse.cz, johannes@sipsolutions.net, linux-um@lists.infradead.org, peter@n8pjl.ca, reiserfs-devel@vger.kernel.org, richard@nod.at
Subject: Re: [PATCH RESEND] um: Remove CONFIG_REISERFS_FS from defconfig
Message-ID: <20230918163544.8604-1-peter@n8pjl.ca>
In-Reply-To: <CAMuHMdWzN0Gs2FTQDFeBLz2498dv3ZYCBL2xOvL5YdHAveaH9g@mail.gmail.com>
References: <20230910232640.113938-1-peter@n8pjl.ca> <20230918125744.4342-1-peter@n8pjl.ca> <20230918132614.zmmuc72purc2psik@quack3> <CAMuHMdWzN0Gs2FTQDFeBLz2498dv3ZYCBL2xOvL5YdHAveaH9g@mail.gmail.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_093620_076747_5D30DA61 
X-CRM114-Status: GOOD (  27.16  )
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

SGkgR2VlcnQsCgpPbiBNb25kYXksIFNlcHRlbWJlciAxOHRoLCAyMDIzIGF0IDEwOjU4LCBHZWVy
dCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToKPiBIaSBKYW4sCj4g
Cj4gT24gTW9uLCBTZXAgMTgsIDIwMjMgYXQgMzoyNuKAr1BNIEphbiBLYXJhIGphY2tAc3VzZS5j
eiB3cm90ZToKPiAKPiA+IE9uIE1vbiAxOC0wOS0yMyAxMjo1ODoyNiwgUGV0ZXIgTGFmcmVuaWVy
ZSB3cm90ZToKPiA+IAo+ID4gPiBSZWlzZXJGUyBoYXMgYmVlbiBkZXByZWNhdGVkIGZvciBhIHll
YXIgYW5kIGEgaGFsZiwgeWV0IGlzIHN0aWxsIGJ1aWx0Cj4gPiA+IGFzIHBhcnQgb2YgYSBkZWZj
b25maWcgVU1MIGtlcm5lbC4KPiA+ID4gCj4gPiA+IEFjY29yZGluZyB0byBjb21taXQgZWIxMDNh
NTE2NDBlICgicmVpc2VyZnM6IERlcHJlY2F0ZSByZWlzZXJmcyIpLCB0aGUKPiA+ID4gZmlsZXN5
c3RlbSBpcyBzbGF0ZWQgdG8gYmUgcmVtb3ZlZCBpbiAyMDI1LiBSZW1vdmUgaXQgZnJvbSB0aGUg
ZGVmY29uZmlnCj4gPiA+IHByb2ZpbGUgbm93LCBhcyBwYXJ0IG9mIGl0cyBkZXByZWNhdGlvbiBw
cm9jZXNzLgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgTGFmcmVuaWVyZSBwZXRl
ckBuOHBqbC5jYQo+ID4gCj4gPiBNYWtlcyBzZW5zZSBidXQgSSd2ZSBub3RpY2VkIHRoZXJlIGFy
ZSBtYW55IG1vcmUgYXJjaGl0ZWN0dXJlcyB0aGF0IGRlZmluZQo+ID4gQ09ORklHX1JFSVNFUkZT
X0ZTIGluIHRoZWlyIGRlZmNvbmZpZyAoc2gsIHBvd2VycGMsIG1pcHMsIG02OGssIGlhNjQsIGFy
bSwKPiA+IGFscGhhKS4gU28gcGVyaGFwcyB3ZSBzaG91bGQgZG8gdGhpcyBmb3IgYWxsIG9mIHRo
ZW0gd2hlbiB3ZSBhcmUgYXQgaXQ/Cj4gCj4gCj4gVGhlIHBvbGljeSBmb3IgdGhlIG02OGsgZGVm
Y29uZmlncyBpcyB0byBlbmFibGUgYWxsIGF2YWlsYWJsZSBleG90aWMKPiBmaWxlIHN5c3RlbXMg
YXMgbW9kdWxlcywgc28gc3VwcG9ydCBmb3IgdGhlbSBpcyBhdmFpbGFibGUgd2hlbiBuZWVkZWQu
Cj4gCj4gUGxlYXNlIGxldCBtZSBrbm93IHdoeSB0aGlzIHNob3VsZCBiZSBjaGFuZ2VkLCBhcyBs
b25nIGFzIFJlaXNlckZTIGlzCj4gc3RpbGwgYXZhaWxhYmxlIGluIHRoZSB1cHN0cmVhbSBrZXJu
ZWwuCgpJIHVuZGVyc3RhbmQgdGhhdCBwb2xpY3kgYW5kIGl0IG1ha2VzIHBhcnRpY3VsYXIgc2Vu
c2UgZm9yIG9sZGVyL2hvYmJ5aXN0CmhhcmR3YXJlIGxpa2UgdGhlIG02OGsgY2xhc3NpYyB3aGVy
ZSBSZWlzZXJGUyBpcyBpbmNsdWRlZCBpbiBtYWtlIGRlZmNvbmZpZy4KCkhvd2V2ZXIsIFJlaXNl
ckZTIGlzIGRlcHJlY2F0ZWQgYW5kIHNob3VsZCBiZSBwaGFzZWQgb3V0IGFzIGJlc3QgYXMgcG9z
c2libGUKYmVmb3JlIGl0cyByZW1vdmFsLCBhbmQgcHJ1bmluZyBjb25maWcgb3B0aW9ucyBmb3Ig
YSBmaWxlc3lzdGVtIHRoYXQgaXMgCmNvbnNpZGVyZWQgb2Jzb2xldGUgYW5kIHNob3VsZCBub3Qg
YmUgdXNlZCBvbiB0aGUgbmV3ZXN0IGtlcm5lbHMgaXMgYSBzdGVwCnRvd2FyZHMgdGhhdC4KClJl
aXNlckZTIGlzIHN0aWxsIGF2YWlsaWFibGUgdG8gYmUgY29uZmlndXJlZCBieSBhbnlvbmUgd2hv
IGJ1aWxkcyB0aGVpciBvd24Ka2VybmVsIGFuZCBpcyBzdGlsbCBhdmFpbGlhYmxlIGluIGFsbCht
b2R8eWVzKWNvbmZpZy4gQXMgc3VjaCBJIGNhbiBqdXN0aWZ5CnRoZSByZW1vdmFsIG9mIHNvbWUg
b2xkIGNvbmZpZyBvcHRpb25zIHRoYXQgZG9lc24ndCBhY3R1YWxseSByZW1vdmUgc3VwcG9ydCBm
b3IKdGhlIGZpbGVzeXN0ZW0gd2hlbiBpdCBzaW1wbGlmaWVzIHRoZSBkZXByZWNhdGlvbiBhbmQg
cmVtb3ZhbCBwcm9jZXNzZXMgZm9yIGFuCmFuY2llbnQsIGxhcmdlbHkgdW51c2VkIGZpbGVzeXN0
ZW0uCgpQbGVhc2UgcmVtZW1iZXIgdGhhdCB1c2VycyB3aG8gYnVpbGQgYW5kIGluc3RhbGwgdGhl
aXIgb3duIGtlcm5lbCBvbiBob2JieWlzdApoYXJkd2FyZSBzaG91bGQgYmUgY2FwYWJsZSBlbm91
Z2ggdG8gc2VsZWN0IG9uZSBLY29uZmlnIG9wdGlvbiBpZiB0aGV5IGhhcHBlbiB0bwpuZWVkIFJl
aXNlckZTLiBJZiBub3QsIHRoZW4gcmVtb3ZpbmcgUmVpc2VyRlMgZnJvbSB0aGUgZGVmY29uZmln
IG9uIGEga2VybmVsCnVwZGF0ZSBpcyBhbiBlYXNpZXIgaXNzdWUgdG8gd29yayBhcm91bmQgdGhh
biB3YWl0aW5nIHRvIHJlbW92ZSB0aGUgZmlsZXN5c3RlbQpmcm9tIHRoZSB0cmVlIGVudGlyZWx5
LgoKPiAKPiBHcntvZXRqZSxlZXRpbmd9cywKPiAKPiBHZWVydAo+IAo+IC0tCj4gR2VlcnQgVXl0
dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBs
aW51eC1tNjhrLm9yZwo+IAo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmlj
YWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKPiB3aGVuIEknbSB0YWxraW5n
IHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtl
IHRoYXQuCj4gLS0gTGludXMgVG9ydmFsZHMKCkNoZWVycywKClBldGVyIExhZnJlbmllcmUgCjxw
ZXRlckBuOHBqbC5jYT4KCkFuZCBJIHNlbnQgdGhlIHdyb25nIGVtYWlsIHRoZSBmaXJzdCB0aW1l
LiBTbyBzb3JyeSBhYm91dCB0aGF0LgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K
