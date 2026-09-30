Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C3FCA5FC1
	for <linux-um@archiver.kernel.org>; Wed, 30 Sep 2026 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q1A+WlULujwTkG6nahgS6pUXERQ7Qa2I13iMuWs4TUk=; b=bynHBlynyP1sEiLmQ8AiCXiEAr
	/Dn7I+ZqS6i3ZHqiZZwjV/NRdBqVjcQkoesiuH/x5ANPtyE+s2Yj9xKIt+e9D/S6/cXxbPeEKKZGw
	bn5/fBrohsqY2hL0mj12ShMi9jC9P8haATO1opuTl9sGy/BXVOfKW7lHhKW7XRTAnSeSGg+CPuLAo
	o+HbR1ZtY7xobCi1voJTGs1pu4Y7gBV/B9f8TnsanHgBRJwrrXloOLirTFS1WOuO10lq+wZ+W8XeA
	V1hf2QIo4unBVvgHLeh1fpGKcPKvSXTlS+Y7IGyOm6MqrJwOHegLjMtz+NsFHusu5OrH0/A5foGiX
	uv3QT1cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBqRp-00000005XXr-1UfM;
	Wed, 30 Sep 2026 09:17:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBqRo-00000005XXd-0JPt
	for linux-um@lists.infradead.org;
	Wed, 30 Sep 2026 09:17:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 724EE43653;
	Wed, 30 Sep 2026 09:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B151F000FF;
	Wed, 30 Sep 2026 09:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759875;
	bh=Q1A+WlULujwTkG6nahgS6pUXERQ7Qa2I13iMuWs4TUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UauxHsxmJYoEhmXuIJJ/UPFeXejYxaiQKZPO7NyNDw8gm9kLo127Hkg6o/OuzYpak
	 neThc3i4svWHBeRIH+8LFrKnMz6R8dnr/d2qT3JvphBBimg4og/E96u78huJKXROKA
	 r7RLUXzeC5+a53CwSpr1klK6yaS9QJn0ib0rWiordGcQSAzioHQSCpVrqdA6yOr++L
	 RTeL41++Yywva4yIrj09NdzHIhH4TVag8EYtKFjD+ti37gHNU7RQIBm9Aq0/0s4gkp
	 qyE5TiqZaToB/wSCoy0IQ7RPqS7Hi3DFEnCIOrBBO3R7y+79tn66UGmQ60a1IZgQd3
	 4iKrX3a57sFnw==
Date: Wed, 30 Sep 2026 10:17:47 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-mm@kvack.org, liam@infradead.org, rbm@suse.com, 
	akpm@linux-foundation.org, luto@amacapital.net, brendan.jackman@linux.dev, david@kernel.org, 
	liuhangbin@gmail.com, corbet@lwn.net, kees@kernel.org, broonie@kernel.org, 
	mhocko@suse.com, rppt@kernel.org, shuah@kernel.org, surenb@google.com, 
	vbabka@kernel.org, wad@chromium.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, geert@linux-m68k.org, 
	daniel@thingy.jp
Subject: Re: [PATCH v4 1/2] selftests: run tests on nommu architecture
Message-ID: <arzTBqww5_1MH0B7@gremlin>
References: <20260929235711.2287931-1-thehajime@gmail.com>
 <20260929235711.2287931-2-thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929235711.2287931-2-thehajime@gmail.com>
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

On Wed, Sep 30, 2026 at 08:57:10AM +0900, Hajime Tazaki wrote:
> Architectures lacking MMU don't support fork(2) syscall and only
> vfork(2) is available with limitations.  Thus, we cannot run kselftest
> on nommu architecture as is.
>
> This commit addresses this issue with the following changes:
>
> - on test run stage, avoid calling timeout command when NOMMU=1 variable
>   added to environmental variable, since timeout command uses fork
>   syscall which nommu platform doesn't support.
> - describe the difference of nommu tests in the document.
>
> So command line to build/execute tests for nommu should be like below:
>
>  $ make ARCH=um NOMMU=1 O=build kselftest-all TARGETS=nommu
>  $ make ARCH=um NOMMU=1 O=build kselftest-install TARGETS=nommu
>  $ NOMMU=1 ./build/kselftest/kselftest_install/run_kselftest.sh -p \
>    -c nommu
>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Brendan Jackman <brendan.jackman@linux.dev>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: "Ricardo B. Marliere" <rbm@suse.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-mm@kvack.org
> Cc: linux-doc@vger.kernel.org

Not sure we need all the Cc's explicitly :) Andrew adds them in (I'm actually
not sure in general if they're really all that useful, some of my series sent to
hoards of people due to touching multiple bits scroll off the screen :P)

> Closes: https://sashiko.dev/#/patchset/20260813063401.1786548-1-thehajime%40gmail.com
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

--
Cheers, Lorenzo

