Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E93C28B2F
	for <linux-um@archiver.kernel.org>; Tue, 18 Mar 2025 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YCBeEB8YQK6DU9gs3AcIAIYeb+jS1B6RY5f3Zb+uuaQ=; b=1Wa0CPITSxSCtGA/WsmB+6wH9M
	OB/z0VowN7jUrPjashShTirpOQVmY3AfV8SWSeePW4bgcxdEXiFqPyp3Ab/0dHUlvtJrJa2CinMx3
	zCoDbfarpSkQvGz3b8AYEQvALpyy8aYBfMjcst/dEvCOiPYx01l29SVYmy6/UfWEz/0ESzLvSmRpQ
	IKDF8bH42E5xFy7yO6DOW4d2Qs/XsQfgMGuJIyy2WNRPe94Y1C3oOEfpYpaZzG5D832GAEjARwrZU
	Okei+WSV/Rp5+29UeiGqrrYd6mKrcIGi6myhPkieIWGlk0JPqB+9DusK2l9HJUD6PA1k5zF4EslMF
	nd9NOIug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuWiQ-00000005ywC-2HC0;
	Tue, 18 Mar 2025 13:10:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuWeH-00000005yJi-0IL0
	for linux-um@lists.infradead.org;
	Tue, 18 Mar 2025 13:06:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YCBeEB8YQK6DU9gs3AcIAIYeb+jS1B6RY5f3Zb+uuaQ=;
	t=1742303184; x=1743512784; b=sreu9r08M4tjtcsdkF9XxDXQ+Z0G3QsVIA3YYBF7STMkJei
	q8c99J7vqcJu3uNPqnFqnF29855vRqv9di9Oz6wDjtf6YRT5+O9Ln1z/nps76Hr8qUN4hQrVBIwJQ
	D8z+snAq2dYia430PttRRLju+vpxZEeHaqKqfL4gR58HQptMvWd9CiqqisoVQesw3v0SayEueYyK1
	RCN9AlMecCwU7rfRU/P1CiHIJpuXS86QkwpsUZXs0w6kHG3FDt0GOJs1jL1no0snqRhJ7HrtOvx4N
	XIW7O5liNqgYAvU9aY8hHBNHJv/Dv/ye1ZyVr3gLzGThSfGS+85eQpwsL6zPn+8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuWeD-0000000FIDn-0ZC9;
	Tue, 18 Mar 2025 14:06:21 +0100
Message-ID: <306312a14326a482cba476733a4adde1799b7ccf.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/4] um: Add pthread-based helper support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
Date: Tue, 18 Mar 2025 14:06:20 +0100
In-Reply-To: <20250306150747.2926434-2-tiwei.btw@antgroup.com>
References: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
	 <20250306150747.2926434-2-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_060625_111667_089C4BE2 
X-CRM114-Status: UNSURE (   7.37  )
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

On Thu, 2025-03-06 at 23:07 +0800, Tiwei Bie wrote:
> Introduce a new set of utility functions that can be used to create
> pthread-based helpers. Helper threads created in this way will ensure
> thread safety for errno while sharing the same memory space.

Using pthreads seemed odd, but Benjamin argues that it's the only way to
get libc to really sort it all out, unless we never use libc syscall
functions, which is probably kind of unreasonable? Or maybe we could?


Either way though,

> +#include <pthread.h>

> +	err =3D pthread_create(&td->handle, NULL, routine, arg);

if we're going to use pthread API, then we need to link against it?

johannes

