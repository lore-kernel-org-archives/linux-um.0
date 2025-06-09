Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA0EC61CE8
	for <linux-um@archiver.kernel.org>; Mon,  9 Jun 2025 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9yFNgGlGCkVHg1knXwtU8l8k12+pdKexGY49aaidt7U=; b=P60tlCqXRj4DAB6pDfKAGqP55K
	+k1fSsRgBjuTY4azTeBjDDa64fj+h2LqYvb30MmHVzamKFvC4lqxaPRXhTo8PBPUst6ywhdEk/4rR
	JDOoksmIg19NBD+/YKlEkdUzgQAa4XSTa9nVpj5/UaswK+997UvQIDXo45jIncB/ce6SwjJbQhw/M
	2lnYsDiF6y8olcciDPmXCs7iCNQV6vxbgRJ6cgjlVy/FEo9lZsMB4VYX333snQawWNj3Bls51lxy3
	Dv5s+zmHW1wyUvDgAK0N7i2GPSzVAanKZEwtM03rprOVXhFJUT+i9OQe8WZFYW5sBAXD0SSUCPKCi
	ZjP1vlzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOisH-000000058Y8-3BQ2;
	Mon, 09 Jun 2025 20:13:41 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOisF-000000058XJ-0fyZ
	for linux-um@lists.infradead.org;
	Mon, 09 Jun 2025 20:13:40 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso3771605a91.1
        for <linux-um@lists.infradead.org>; Mon, 09 Jun 2025 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749500016; x=1750104816; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yFNgGlGCkVHg1knXwtU8l8k12+pdKexGY49aaidt7U=;
        b=V871XfCmOTv9s28P/Q0ZKBHYYH52KYd+oOCMuGi3EKLs9/O7gEi5WCxpZNuhie16dQ
         72eMhI2RM7luGEn3xBn28Y2CY2ZgVn1y6wubasMOpB9hcb9/WfINHJ8Ojkbce9vIZnR4
         45V1iHAtGkDQoEZC0hIe8fdEHV1dyYKgQHRLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749500016; x=1750104816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yFNgGlGCkVHg1knXwtU8l8k12+pdKexGY49aaidt7U=;
        b=N2tnpMb3SVCcNgx65MYOCybUsw85sKh4x8TDY58iYKwYix9eMV/pWVlm19bJEZ5bCh
         mYO+FEn9OZjxhXS5ypTqb2bwhDlDiop25EbZRq4NL6FQoFe2FFs9I63I0R7jY2l8EYEI
         T/+ipTXHjEOn3u207GBUWAhnrD3Etxjr93IRoZnFq+NHCfm4Qx8HMJYwWyFzb/hN601X
         mFDUdaJ4pjQztd/57818AFjGP6aAk5B+d27d44QWQNGYKyQ0quFiHRtOLubI5zCRKgSk
         fV4rj968Vij0fo2m8/gdXleBlUWv4lVehVoulel3XwgZFJFLVhIFu6B05f+ZjT5P+Jzx
         1p0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9HWXLjl58MmIkD+iQg1NAHAJzBO5i7MKSnEVMMoavWZBpBUGlyBvZufql+h6eeXZX/0aBeVnuPQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwLHmeJ4YXCNfUC81KYHzUnouMzfJU7wPe9UTusbNgPYGF/lCxz
	+fQdHE5VXGLj9ZExwwmOUpDTFaqsqZia2hbBYofA3kFwOS6byDYh1gh3vECso6yE6UKn97W6PYh
	KTm4=
X-Gm-Gg: ASbGncsxRe+tq12T6YsPlUtD8Jj21rl7MZHZJr+SZj2/GZRjJlHWmRR3FE/cXpOp3c/
	BnhdrGuDjg1m63sjK6dT8k7DKAajYErzEeJCEWr6LH8y+GYlxswLWoaoPeJH+DJzMqTIV++0sEL
	ak9y8C+Dsu0BY0dZPVcJCt6Pp136ChpkXlUrn4kQswqTLKUGt9YKbECAghPo96GQ0ipDky8aEf+
	bcbOGRCRnQWZ3YvMIC0fw546U9gZDOL52hOo3ac4rhHxjGMgJx1z/gHFcHrwmHIXWSTolpAKKz2
	Xi/YgzUq+OZogT/V5TNd00yJ9PydTjTTURnVerHfHgGDJ7SsYy5SW7PZ4k6fJFbC+FV15LQr0EL
	QepkceOyqJ741jmmk1Q5AyYxkSNfgww==
X-Google-Smtp-Source: AGHT+IHrJat2AjNBi+fJxjxha+VWZRfAunSSNF3d6+GiY65H4GP9Gd9GmFxSOlu/ssA9TUhvgDP2cw==
X-Received: by 2002:a17:90b:520d:b0:313:480f:ee72 with SMTP id 98e67ed59e1d1-313480feed8mr17084703a91.23.1749500016415;
        Mon, 09 Jun 2025 13:13:36 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b128050sm6637065a91.25.2025.06.09.13.13.33
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 13:13:34 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b1fb650bdf7so2563376a12.1
        for <linux-um@lists.infradead.org>; Mon, 09 Jun 2025 13:13:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBLppJ4I/By3B8gCDYbfEa0xiBex9A/ZWppU3jTIKXBULj+FMPswJLHA+n1Vrxq3dLInV3jtz7Rw==@lists.infradead.org
X-Received: by 2002:a17:90b:2d4e:b0:311:afd1:745b with SMTP id
 98e67ed59e1d1-313472e8c6dmr21398818a91.11.1749500013266; Mon, 09 Jun 2025
 13:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com> <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
In-Reply-To: <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 9 Jun 2025 13:13:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
X-Gm-Features: AX0GCFtFMIswKIAvt6rQB2Iu1HAY0gUkQ581gK2nBv_6C3TWCO4_jkt3VeYMeO4
Message-ID: <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
Subject: Re: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED instead
 of CON_ENABLED
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_131339_223852_F0833551 
X-CRM114-Status: GOOD (  19.17  )
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

On Fri, Jun 6, 2025 at 7:54=E2=80=AFPM Marcos Paulo de Souza <mpdesouza@sus=
e.com> wrote:
>
> All consoles found on for_each_console are registered, meaning that all o=
f
> them are CON_ENABLED. The code tries to find an active console, so check =
if the
> console is not suspended instead.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 85f6c5a76e0fff556f86f0d45ebc5aadf5b191e8..af6d2208b8ddb82d62f33292b=
006b2923583a0d2 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char *opt)
>         console_list_lock();
>         for_each_console(con) {
>                 if (con->write && con->read &&
> -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> +                   (con->flags & CON_BOOT) &&
> +                   ((con->flags & CON_SUSPENDED) =3D=3D 0) &&

I haven't tried running the code, so I could easily be mistaken, but...

...the above doesn't seem like the correct conversion. The old expression w=
as:

(con->flags & (CON_BOOT | CON_ENABLED))

That would evaluate to non-zero (true) if the console was _either_
"boot" or "enabled".

The new expression is is:

(con->flags & CON_BOOT) && ((con->flags & CON_SUSPENDED) =3D=3D 0)

That's only true if the console is _both_ "boot" and "not suspended".

-Doug

