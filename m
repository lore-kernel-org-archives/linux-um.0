Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C046FFED2F5
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 23:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=; b=W2ajFZzDfIMp134aI01gIoUOQd
	Ma9Mem6lditer41x80DbBHfx7O9J8UQI8vL4alQcW3ShgsnCdGuxbG5yI0hnnVf/wZ4aiQW4rYIbk
	4I/U9Ba9iJ6xe6xtFSqY4Bbi5nimmZj/xoauNno9y3wBIRQwfESNieXRT2ej1rP5bvNw+3o0VGdtr
	CNRK2mYOq+dvTD1s5zutlL4IUOmQvdek0QtP2aDwc0bOwR5WLqNSBGAo431QWPrjY8aPDU673RmMa
	PuCP8ps8VYoqQ0eOpvwYU3xxpCpP8cPE+FrWWUg2j35v4hYDXNhQ376V97zGwVT/gXfjvsXVBfqL7
	CYUjspeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0pqb-0000000Fpgf-3NEp;
	Thu, 12 Mar 2026 23:53:45 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0pqY-0000000FpfZ-3ubd
	for linux-um@lists.infradead.org;
	Thu, 12 Mar 2026 23:53:44 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-b96f02b4329so272579366b.2
        for <linux-um@lists.infradead.org>; Thu, 12 Mar 2026 16:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773359621; x=1773964421; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=ZmeUGO0QHo5M5hP3LbakXwqCPkUS1aoxSjeUOIsYhH8IaprUAbqmkYG7UgXh+GIMWo
         yL/focBwmRPxGkX74l26foVSS6Gkk9ev088GHGepokGyWO4+fQlX5gTzQ6saEEuuLODY
         beM1Cyua51tnoSfMX/O5qUu8DOFUNk7q/s1iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773359621; x=1773964421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=revWjb1NMOcsVuW//L7/7ksW0p5rGaM6b34JakFrW05VMCZXZmPe341TNhKIIzqV9g
         TiY2+ctX7OVLDvw74H0nslO9cGfwTnjH6Q/FX/f4m+YJrvV/SbeHCZ16Cm3rR+TGwsLz
         CptjWeGWKHMvaHrEieR66EyKD+yvMLsBNck9Jozk03k0k+jjxLGOHMX5vqmAzoXhaMeU
         pz5Did0iU9Lnahytv9J7TmGyB+Qwc3EsZ9Lwfsb/UyCEpg7EGd3dtY5NPXpo5PdfdTGu
         tGvo3HGS4Im6j818vWYKZv2cWQ+Vdbkb1eWqVFQUN2aIXNZMWQR7SnUoNa9E9wn8S4xt
         AReA==
X-Forwarded-Encrypted: i=1; AJvYcCUXc3XvXLjfDfaYocP65cxkNBgjSRs/wzbsQwVzn86dF4ACmTDl2/1W2pbf0Vz88ix2x8nhTrzdLA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxigUGGLZokxKmchqQPilwoD0K7inYCXuFBOIqjJ3dtm3EpSzuv
	NfvREFJRkHlJb/et3ApA5apjvyqyFKHB5l3PVaZOJ9kTNARuGVbvOlIp3CCptCLBFT+2Qrtu5ew
	jbrjJIg0=
X-Gm-Gg: ATEYQzzd4vk/ov99EwLPxCGxwuJWTybD1gpfk4xaun6qb18QmSCnKpCG+xlYiMbCrTp
	glGa1v9c8falnqm4vHj2DkUzFaUNxdcsBOtVGVomwY466EWX3+OpmdMJaM5IumUMzhHleIwt+jk
	rUG4rlPCfDJiBdU4SHHK5RAMkmkHY7qsinp34/cP/xs63MmHuqTj8DWlkidl7pZ0rY8Nmo+roct
	QO78fW9n974sXWj3oYkmKGDN9xPHUMI7zQKLqxaB4ufy4UQBTJqhkc4LR+xhY0Q1Xomz9UfEjoP
	SZQV3sW1hgDt9W1sZWan2etPrtKUFetWv2BPFJ6gjE3zMXzgA+pOeH6Oldmy3QKrfHeMs1ehdZ4
	Ipid3YwQGWm7E/c4Hwv47WIH2Ewc0Oq0X69fsIiQ1+EmevAx8FAwnD3Zk5+NVVGiLez2Ws6YBgX
	+hTUrok74ReICL+4J8PLhqXjgZ4x2GEnh+75m6v/0i6BbSX74XR5uy8YpYH0Vj145Pu/YnxKtB
X-Received: by 2002:a17:907:d1e:b0:b96:d904:9616 with SMTP id a640c23a62f3a-b97653faba7mr67242666b.40.1773359620756;
        Thu, 12 Mar 2026 16:53:40 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cbab225sm3842366b.13.2026.03.12.16.53.40
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 16:53:40 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b976e181895so2779866b.1
        for <linux-um@lists.infradead.org>; Thu, 12 Mar 2026 16:53:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2GI/7KBIgNY4ZlSn60uJdUFXWqt3bfXowsCT9CUrR8mz2U8VLRgHd7Z8XNHPbHYC+V2iPm9bnZA==@lists.infradead.org
X-Received: by 2002:a17:907:c5c9:b0:b96:d802:8b41 with SMTP id
 a640c23a62f3a-b9764fd8722mr66207066b.15.1773359215961; Thu, 12 Mar 2026
 16:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260312214330.3885211-1-neilb@ownmail.net>
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Mar 2026 16:46:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
X-Gm-Features: AaiRm503fTaccEgKNbxF9h_dDHM9fUsSr52XJuxzTwCI0G9L03uDq8g5di1zchk
Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/53] lift lookup out of exclive lock for dir ops
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Carlos Maiolino <cem@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Tyler Hicks <code@tyhicks.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, coda@cs.cmu.edu, linux-mm@kvack.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, gfs2@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_165342_985525_51798C04 
X-CRM114-Status: GOOD (  13.47  )
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

On Thu, 12 Mar 2026 at 14:44, NeilBrown <neilb@ownmail.net> wrote:
>
> This patch set progresses my effort to improve concurrency of
> directory operations and specifically to allow concurrent updates
> in a given directory.

I only got about half the patches, but the ones I did get didn't raise
my hackles.

HOWEVER.

This is very much a "absolutely requires ACKs from Al" series. Al?

Also, because I only got about half the patches, and there's 53 of
them total, I'd really like to see a git branch for something like
this. It makes it easier to review for me, and I suspect it makes it
easier for some of the test robots too.

But again - this needs Al to look at it. Iirc he had some fundamental
concern with the last version - hopefully now fixed, but ...

                 Linus

