Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759BCC4707C
	for <linux-um@archiver.kernel.org>; Fri,  5 Jan 2024 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EHmRq5ttEdfAsFXY0yaV0xO5z0TOeJj9CPBqPduHyAU=; b=Fze3EjP2HsdodniRhX/qFHvujd
	kwJaVLqx4FKWKcGpB4nS/4mWx9OuIumFghPjrRM3weBEcLfggnrGI0ROUGmbl6EV6kwnqXX0sq4iw
	4hXHJmXtYjYzv9pCL36LaGCVqVgklm/QzvyxB1+rhiFW1s9h/bALYVXTU5Z4CworzpciRVowROHBt
	yoj6AiqOiG5i539xF1V+fSQ3Ol2Nxl9WrOr8UsZza/49Yke0P3nPRLRcRB5jkCG/WM/TIOOxxOTCE
	2NFIkA4nWti1oa/TphDT6cyJcDIWvawT5NLMNtPqum1rzLwUs/B1DxyIMTligPJZC8Fs0jACfbO7k
	grcb9/Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLfKE-00GDPZ-10;
	Fri, 05 Jan 2024 08:13:06 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLfKB-00GDOQ-1P
	for linux-um@lists.infradead.org;
	Fri, 05 Jan 2024 08:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EHmRq5ttEdfAsFXY0yaV0xO5z0TOeJj9CPBqPduHyAU=;
	t=1704442380; x=1705651980; b=FO9bBaRDN8JyLEInT6f0IKSOmMxVADzEao3rjmSKoVauf/t
	byXtLwFnnWJsui3gvN2tTWs2UEjfnlBou+UkwSL0sNIcIZhiRAQ9OBmIPviPcmpBa4g8ltALVf45x
	gGpmln0aRgTL6GUzkTNTLwSRlEfkYQZ1iydpJUSbs32v1BwEaMrnqAmHif/RA9GUVT4ZKyo0trCHv
	nzjubqv8iJiNtF6A3uGaHic5sA5mg1sMZ8uiXj9POXUn1pEm9CJ55yOeRW4zojfaQAnhty4JyrjmH
	Kgi3OGdqUffFwvHCdk7NBRe28gyVmq+3rCt4Zy28J8uK2EU8uRjtLJqzQ4dF3kqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rLfK5-00000005uaZ-1gHr;
	Fri, 05 Jan 2024 09:12:57 +0100
Message-ID: <a75fb1e3b92f748a81e032b5138e2cdccc4d2c92.camel@sipsolutions.net>
Subject: Re: [PATCH v3 04/11] um: Don't use vfprintf() for os_info()
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: linux-um@lists.infradead.org
Date: Fri, 05 Jan 2024 09:12:55 +0100
In-Reply-To: <CAFLxGvxads6JaAgm2MvXKKJrJiYGk1oLa2EDC0YLemcQ866cvg@mail.gmail.com>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
	 <20231110110348.1815612-5-benjamin@sipsolutions.net>
	 <CAFLxGvxads6JaAgm2MvXKKJrJiYGk1oLa2EDC0YLemcQ866cvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_001303_681870_484C2154 
X-CRM114-Status: GOOD (  10.22  )
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

On Thu, 2024-01-04 at 23:37 +0100, Richard Weinberger wrote:
> On Fri, Nov 10, 2023 at 12:03=E2=80=AFPM <benjamin@sipsolutions.net> wrot=
e:
> >=20
> > From: Benjamin Berg <benjamin@sipsolutions.net>
> >=20
> > The threads allocated inside the kernel have only a single page of
> > stack. Unfortunately, the vfprintf function in standard glibc may use
> > too much stack-space, overflowing it.
>=20
> Another option is giving the helper threads more memory, we don't have
> that many.
> Did you explore this option already?

I had not really considered that.

One thing though is that userspace_tramp calls os_info while working
with the stub stack. So that also means setting STUB_DATA_PAGES to 2.
But, I suspect we may want to do that anyway eventually to fit the ever
increasing mcontext size for all the AVX512 registers and such.

As I said, I think that is fine to do.

Benjamin

