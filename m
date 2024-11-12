Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69066D42BBF
	for <linux-um@archiver.kernel.org>; Tue, 12 Nov 2024 20:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQvCSgq64T+wf/TPNFDiNWUiao198TlsvJUEDfd6IKY=; b=29Ds9iBzkHGUORw+CFoMhMCd40
	FcJ2dh4K0PzcOrMRDxymMX+SjQv1s3OSWN9QjzSUtnjmXz/GKmR6R52CcOTYxpjo2BCX09VqEX0hJ
	jRbCkNFFsvmNgvw40qoixY0DRbDolRwMeCeQI/Yzdo0gesYgc4bS1hzzTNH0hinR0FhqOejKhpZKL
	ZTdL5SRA5mlI3OfHhqzLP6K4JRakoTpoQmjHqAYMWhhj23Q/PeKEwQ/kWiPRYQHMaWdK5JLvGPL+v
	WBHRrXNhYMFtwfAMl0453hIiigIGN/prqY/DZl3TuDR07Vy+H0gKlfxi15arEMpeuEyinKKUTU41K
	yjT37Zmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAxFN-00000004puy-3M9A;
	Tue, 12 Nov 2024 20:12:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAxFJ-00000004pt1-09SC
	for linux-um@lists.infradead.org;
	Tue, 12 Nov 2024 20:12:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731442335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lQvCSgq64T+wf/TPNFDiNWUiao198TlsvJUEDfd6IKY=;
	b=e0Zm5rOTlzc0Lla8gwCTXfk38cJi71db4Dfv963X9Q9LtrwDdM4Ku1zQa5BOT+ZQCEWIyC
	yAQT6civ7SZc+22ffqRJnqt9xaLVC9fZeYd39iK4hLKuEos0xBWHTnYUIF0jn4Pf2/HX+9
	V5DWNCw52Z+21njzyOWOObn6U4FtKLQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-9wYFJSKuOy2Ip-OBMrooKw-1; Tue,
 12 Nov 2024 15:10:23 -0500
X-MC-Unique: 9wYFJSKuOy2Ip-OBMrooKw-1
X-Mimecast-MFC-AGG-ID: 9wYFJSKuOy2Ip-OBMrooKw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA06119560AF;
	Tue, 12 Nov 2024 20:10:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.223])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5554F1956086;
	Tue, 12 Nov 2024 20:10:18 +0000 (UTC)
Date: Tue, 12 Nov 2024 21:10:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>, 
	Johannes Berg <johannes@sipsolutions.net>, rrs@debian.org
Subject: Re: UML mount failure with Linux 6.11
Message-ID: <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_121217_220080_2DD90040 
X-CRM114-Status: GOOD (  15.14  )
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


 Hi,

On Mon, Nov 11, 2024 at 09:16:18AM GMT, Hongbo Li wrote:
> We are discussing about the hostfs mount with new mount API in [1]. And may
> need your help.
> 
> After finishing the conversion to the new mount API for hostfs, it
> encountered a situation where the old version supported only one mount
> option, and the whole mount option was used as the root path (it is also
> valid for the path to contain commas). But when switching to the new mount
> API, the option part will be split using commas (if I'm not mistaken, this
> step would be done in libmount), which could potentially split a complete
> path into multiple parts, and the call fsconfig syscall to set the mount
> options for underline filesystems. This is different from the original
> intention of hostfs. And this kind of situation is not common in other
> filesystems.

The options has been always parsed by mount(8) and it's very fragile
to assume that kernel get as in the original order (etc.). 

For decades, commas have been supported in mount options. For example,
SeLinux uses them frequently in context settings. All you need to do
is use quotes, but be careful because the shell will strip them off.
Therefore, double quoting is required.

   mount -o 'rw,bbb="this,is,value",ccc'

It's also supported in fstab, just use name="v,a,l,u,e"

You can try it:

 # strace -e fsconfig mount -t tmpfs -o 'rw,bbb="this,is,value",ccc' tmpfs /dontexist

 fsconfig(3, FSCONFIG_SET_STRING, "source", "tmpfs", 0) = 0
 fsconfig(3, FSCONFIG_SET_FLAG, "rw", NULL, 0) = 0
 fsconfig(3, FSCONFIG_SET_STRING, "bbb", "this,is,value", 0) = -1 EINVAL 

You can see the expected result when using fsconfig().

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


