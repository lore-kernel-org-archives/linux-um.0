Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273A0C433FE
	for <linux-um@archiver.kernel.org>; Fri, 18 Nov 2022 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wLGBtXihB9nkAvL8JCtntrW0jokdb1YHjCZ+I6aIsUs=; b=QYHzbfyiyzEkcm
	VHHufrjOHPe3LGcyB3TXZpIhhGnDnviAhtAkUZrz/rdEWZZIEGkGwqYDhWzGgs5KCxQ1xebQKW/hW
	Ssk295hHd+S+d/k37rwhbfpm3y97ADgX0PzhwJ1W5IBypVQIbDMwokqNbyJIOjNoRUA77q9AdzCzH
	UJQS7N5ZjRyM1T8ibhnaCYiu4HpqEKoa3hl64NHUafnsxzp6ljzo5dXxgJBnu9V0XLOsRdV0QHdOO
	nHweApQ7/cK7W5uz8nqcaGEbXinazXoztobgDu8yD7hVs5jmY4I6Cd+RUHn610n/AlxhwBjr/4lCB
	Iaqjo+5fUQsw/CpfI0pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow46L-005FCB-LF; Fri, 18 Nov 2022 16:20:25 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow468-005F3A-Dg; Fri, 18 Nov 2022 16:20:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE6541FD2A;
	Fri, 18 Nov 2022 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1668788407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdCAdBuUfE3Rqc7NKln9hVuWsUdVVMVjbpiUee2vmvc=;
	b=gFn628LRme6mgJaZwZXeXxqjVHZ1dhRwig/bm8/PJr2zPCzCtNxBMW9LTId3gWUCMDCXyK
	TtXWbFh2gTikA3YMbaaroxv4l1XPLUH9rONQd0Dr+UuiMwnQoW4bEdHtBzAdzRgdfTZpOo
	z5sm6N12GAAOBYVJKj61R24kx7azRZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1668788407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdCAdBuUfE3Rqc7NKln9hVuWsUdVVMVjbpiUee2vmvc=;
	b=TNP3u8Xx8uZo+sUiWVVILNS2hk5mwr0qssvrZKBXcmmjqp8qeTg4rudZW0WqfwYAgYNMk2
	poai8KIFEEpddcDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10E861345B;
	Fri, 18 Nov 2022 16:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id uA9uA7ewd2PXAwAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 18 Nov 2022 16:20:07 +0000
Message-ID: <5104fc7b-7b38-652a-9a3f-6116e48d4129@suse.cz>
Date: Fri, 18 Nov 2022 17:20:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH mm-unstable v1 01/20] selftests/vm: anon_cow: prepare for
 non-anonymous COW tests
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>,
 Nadav Amit <namit@vmware.com>, Matthew Wilcox <willy@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Shuah Khan <shuah@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-2-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221116102659.70287-2-david@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_082012_635234_36EF59AB 
X-CRM114-Status: GOOD (  10.45  )
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

On 11/16/22 11:26, David Hildenbrand wrote:
> Originally, the plan was to have a separate tests for testing COW of
> non-anonymous (e.g., shared zeropage) pages.
> 
> Turns out, that we'd need a lot of similar functionality and that there
> isn't a really good reason to separate it. So let's prepare for non-anon
> tests by renaming to "cow".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
