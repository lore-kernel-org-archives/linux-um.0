Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13893D10BF0
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lCWAwKFY3FMRe3bwyNO2/MTOjWVsMpbRVuZvGNCOCgU=; b=OUw+mKptgxt/NLPKb97EpSIY7F
	/qxGipjqb8rHH6uWI995qXDNlpbZZZxzDPq8t7DA+//kfa8QScX3mtWtXk1rcu2LaC8Q4zz/5svBh
	SGKdQiURQvvzCB4qZxEcbszn0Hpf+0m6cLuALB5wI3B8bUwRP8iS9JlDXxJgFKarltoPbgRpfSH+m
	z/A9AM0rFsnB/qe0x15wPVv25oUvTMToCT5gjKpZO9RosnMFQAGFs8U0Jrt57rDjtogckIofBIDnJ
	p9dD6HTwkSoQRKAPIU+YCEiTPjf0Ro9/f4WEcbld3WxNNUs8axigvDompmP96kACbZZhIaAVPvGF8
	44RbTcMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4e79-00000006NTf-0ijD;
	Sat, 26 Oct 2024 10:33:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4e76-00000006NTE-0iym
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 10:33:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lCWAwKFY3FMRe3bwyNO2/MTOjWVsMpbRVuZvGNCOCgU=;
	t=1729938823; x=1731148423; b=PAXDE/NP0WWoPN0qrFHrwXRB2+xFYi3YXlBD0kOKu/+EQw3
	T+6/95ox0X+r81yRgk9wDuODYCHt+044H+zWqtIHwNf08c3wubL35vTukN/lESfBmWvOk6rzlL8er
	ydl+VnUW2NQ8HtPD1cYKDO1nrphVK/NHOyEiNwAljFkuPW3YP6/8H9vOsxCu0pzrT5M52fBcOJnNe
	UbJP0BP8BNwy+HWuiMGDWx0O/auZpZv+pzN2+eevloubW02XhmWMLzU778OjyQnoCVf2ORO8DaBbH
	hbqfra8yt57+XJ1CsRtFp0cPAmhTn1FtALUi/b9T+4OJgwJyWLfUGntIOCwnFu9Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t4e73-00000005MXy-0IUJ;
	Sat, 26 Oct 2024 12:33:41 +0200
Message-ID: <b33ec6bb3e832c8424c675f1766dcb8e4fe0fd35.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 9/9] um: pass FD for memory operations when needed
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org
Date: Sat, 26 Oct 2024 12:33:38 +0200
In-Reply-To: <e6e0b12d-a5b4-41e7-bccc-a14626b4dde6@antgroup.com>
References: <20241023140827.136550-1-benjamin@sipsolutions.net>
	 <20241023140827.136550-10-benjamin@sipsolutions.net>
	 <e6e0b12d-a5b4-41e7-bccc-a14626b4dde6@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241026_033344_232848_42E451A0 
X-CRM114-Status: UNSURE (   9.29  )
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

Hi,

On Thu, 2024-10-24 at 21:52 +0800, Tiwei Bie wrote:
> On 2024/10/23 22:08, Benjamin Berg wrote:
> [...]
>=20
>=20
> It looks the memcpy could trigger a crash when UML_SECCOMP is
> enabled:
>=20
> [...]
>=20
> It can be fixed with changes like below on my machine:
>=20
> diff --git a/arch/um/include/shared/skas/mm_id.h
> b/arch/um/include/shared/skas/mm_id.h
> index f2d4c383c958..26d922443454 100644
> --- a/arch/um/include/shared/skas/mm_id.h
> +++ b/arch/um/include/shared/skas/mm_id.h
> @@ -6,6 +6,8 @@
> =C2=A0#ifndef __MM_ID_H
> =C2=A0#define __MM_ID_H
> =C2=A0
> +#include <linux/kconfig.h>
> +
> =C2=A0#ifdef CONFIG_UML_SECCOMP
> =C2=A0#define STUB_MAX_FDS 4
> =C2=A0#else

Hmm, the "#include <linux/kconfig.h>" in userspace code again. I
dropped the include from process.c after Johanne's comment =E2=80=A6

Maybe we can really just include kconfig.h. But we can also avoid it by
adding the definition into common-offsets.h, or just keeping a couple
of extra integers around in non-seccomp compiles :-)

Benjamin

