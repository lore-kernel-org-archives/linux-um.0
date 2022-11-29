Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C18EC4332F
	for <linux-um@archiver.kernel.org>; Tue, 29 Nov 2022 09:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SVBrXQjfTaevgmzyKZLrChLld6d6pvprl+IOt6NcQ8A=; b=VlVKH+5jD1md61
	EC7w8ITmC9uE2BVbkmIOZeFOZq35oPHcTP/saR8vkGXrqYT7G7+iFR0ztkc9Fb97qyZluenW+dxmG
	yVvZteUDrqNonHloPwgBbuUlvpZGXnY9H9XwPqfNPCpqo+XfsNg0zhwQo8CbrG2fEgLxUCwXZ6Go7
	++7xy1PfFPx7NFwo5sV+Tf6HhyYmdUFiiU6O163yIj8kM6DWAUowzaUfjCDJJGCWfNuhLzvW0jnvl
	idBot4U3jha9U7uQaz9n7wTvEa5d+JkU7p6d93cinEQD+z3idzHbM05/FqvgFJvcfoA214Gi1Tq79
	MVhjHXiqxB6jPCL4zTug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwby-007h6F-03; Tue, 29 Nov 2022 09:09:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwbk-007gyL-2k; Tue, 29 Nov 2022 09:08:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 82AE4615E9;
	Tue, 29 Nov 2022 09:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBBAC433D6;
	Tue, 29 Nov 2022 09:08:43 +0000 (UTC)
Message-ID: <c2681582-1e24-7ed9-e4fb-e2dd17a93aed@xs4all.nl>
Date: Tue, 29 Nov 2022 10:08:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
 Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Shuah Khan <shuah@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa
 <tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
 <81fb0fa3-2e06-b765-56ac-a7d981194e59@redhat.com>
 <08b65ac6-6786-1080-18f8-d2be109c85fc@xs4all.nl>
 <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
 <20221128145927.df895bf1966cfa125cae9668@linux-foundation.org>
 <22b1107b-0acc-5772-a883-8f3c4682eb1b@redhat.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <22b1107b-0acc-5772-a883-8f3c4682eb1b@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_010852_220322_DD57A117 
X-CRM114-Status: GOOD (  20.02  )
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

T24gMjkvMTEvMjAyMiAwOTo0OCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4gT24gMjguMTEu
MjIgMjM6NTksIEFuZHJldyBNb3J0b24gd3JvdGU6Cj4+IE9uIE1vbiwgMjggTm92IDIwMjIgMDk6
MTg6NDcgKzAxMDAgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IHdyb3RlOgo+
Pgo+Pj4+IExlc3MgY2hhbmNlcyBvZiB0aGluZ3MgZ29pbmcgd3JvbmcgdGhhdCB3YXkuCj4+Pj4K
Pj4+PiBKdXN0IG1lbnRpb24gaW4gdGhlIHYyIGNvdmVyIGxldHRlciB0aGF0IHRoZSBmaXJzdCBw
YXRjaCB3YXMgYWRkZWQgdG8KPj4+PiBtYWtlIGl0IGVhc3kgdG8gYmFja3BvcnQgdGhhdCBmaXgg
d2l0aG91dCBiZWluZyBoYW1wZXJlZCBieSBtZXJnZQo+Pj4+IGNvbmZsaWN0cyBpZiBpdCB3YXMg
YWRkZWQgYWZ0ZXIgeW91ciBmcmFtZV92ZWN0b3IuYyBwYXRjaC4KPj4+Cj4+PiBZZXMsIHRoYXQn
cyB0aGUgd2F5IEkgd291bGQgbmF0dXJhbGx5IGRvLCBpdCwgaG93ZXZlciwgQW5kcmV3IHByZWZl
cnMKPj4+IGRlbHRhIHVwZGF0ZXMgZm9yIG1pbm9yIGNoYW5nZXMuCj4+Pgo+Pj4gQEFuZHJldywg
d2hhdGV2ZXIgeW91IHByZWZlciEKPj4KPj4gSSdtIGluY2xpbmVkIHRvIGxldCB0aGluZ3Mgc2l0
IGFzIHRoZXkgYXJlLsKgIENyb3NzLXRyZWUgY29uZmxpY3RzCj4+IGhhcHBlbiwgYW5kIExpbnVz
IGhhbmRsZXMgdGhlbS7CoCBJJ2xsIGZsYWcgdGhpcyAodmVyeSBzaW1wbGUpIGNvbmZsaWN0Cj4+
IGluIHRoZSBwdWxsIHJlcXVlc3QsIGlmIE1NIG1lcmdlcyBzZWNvbmQuwqAgSWYgdjRsIG1lcmdl
cyBzZWNvbmQgdGhlbgo+PiBob3BlZnVsbHkgdGhleSB3aWxsIGRvIHRoZSBzYW1lLsKgIEJ1dCB0
aGlzIG9uZSBpcyBzbyBzaW1wbGUgdGhhdCBMaW51cwo+PiBoYXJkbHkgbmVlZHMgb3VyIGhlbHAu
CgpJdCdzIG5vdCBhYm91dCBjcm9zcy10cmVlIGNvbmZsaWN0cywgaXQncyBhYm91dCB0aGUgZmFj
dCB0aGF0IG15IHBhdGNoIGlzCmEgZml4IHRoYXQgbmVlZHMgdG8gYmUgYmFja3BvcnRlZCB0byBv
bGRlciBrZXJuZWxzLiBJdCBzaG91bGQgYXBwbHkgY2xlYW5seQp0byB0aG9zZSBvbGRlciBrZXJu
ZWxzIGlmIG15IHBhdGNoIGdvZXMgaW4gZmlyc3QsIGJ1dCBpZiBpdCBpcyB0aGUgb3RoZXIgd2F5
CmFyb3VuZCBJIHdvdWxkIGhhdmUgdG8gbWFrZSBhIG5ldyBwYXRjaCBmb3IgdGhlIHN0YWJsZSBr
ZXJuZWxzLgoKQWxzbywgdGhlIHVwZGF0ZWQgY2hhbmdlbG9nIGluIERhdmlkJ3MgcGF0Y2ggdGhh
dCBzaXRzIG9uIHRvcCBvZiBtaW5lCm1ha2VzIGEgbG90IG1vcmUgc2Vuc2UuCgpJZiB5b3UgcmVh
bGx5IGRvbid0IHdhbnQgdG8gdGFrZSBteSBwYXRjaCBhcyBwYXJ0IG9mIHRoaXMsIHRoZW4gbGV0
IG1lIGtub3cKYW5kIEknbGwgdGFrZSBpdCB0aHJvdWdoIHRoZSBtZWRpYSBzdWJzeXN0ZW0gYW5k
IGhvcGUgZm9yIHRoZSBiZXN0IDotKQoKUmVnYXJkcywKCglIYW5zCgo+Pgo+PiBCdXQgTGludXMg
d29uJ3QgYmUgZWRpdGluZyBjaGFuZ2Vsb2dzIHNvIHRoYXQgdGhlIGNoYW5nZWxvZyBtYWtlcyBt
b3JlCj4+IHNlbnNlIGFmdGVyIGJvdGggdHJlZXMgYXJlIGpvaW5lZC7CoCBJJ20gaW5jbGluZWQg
dG8gbGV0IHRoZSBjaGFuZ2Vsb2cKPj4gc2l0IGFzIGl0IGlzIGFzIHdlbGwuCj4gCj4gV29ya3Mg
Zm9yIG1lLiBUaGFua3MgQW5kcmV3IQo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtdW0K
