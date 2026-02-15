Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8424DEF584C
	for <linux-um@archiver.kernel.org>; Sun, 15 Feb 2026 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=555QthD3BOi0oKnL9Ait9gVqXQiUN7RsLDwjha1Lgzs=; b=os/2BSNr45hD5tsmk0D3rjOuVj
	1KUOpZMod68TYoGcICj0Rwzvlw0sJWKV423AMOBcTJpYdAOFcAv1rZzAHH5YPszT6OZyosVyPA/jf
	vG8PDhYn2bzqPil4w7hYaxSdBbR9izYlc6jY5fzGOn3rN6dXLvFtbBClzDlQSAv8LC5MXZY89JbM4
	Lzut/J1JB4DR5ygjjbl6PzQWqKcx8obOVgZtSzjhfpw7Y2hcu1M4tvj6buMpp3sDfp8j972yU5zme
	Hrhdb9PP+H59IfeOuqr34lQzLNlvUmS7oDsGzTYo1DF/aKutQF5fbqksbw/zDgt2U9qNhZD98Ddmp
	c1hkKpOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrbWy-00000005Opk-2BN3;
	Sun, 15 Feb 2026 12:47:20 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrbWw-00000005OpM-3TWF
	for linux-um@lists.infradead.org;
	Sun, 15 Feb 2026 12:47:19 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-2ba76e80509so179964eec.1
        for <linux-um@lists.infradead.org>; Sun, 15 Feb 2026 04:47:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771159638; cv=none;
        d=google.com; s=arc-20240605;
        b=Y33/BozIWrYh589K+3RFITov0MJOXI1dULafpMzfoTsDltvFLvxz+ffAO0CnwwirGy
         BFD9iQ597wwNDUQpf1y+tr/FMaw8fhSKBrr+ZwwJUDGetiPGV29zuC2gWnx72NJQYTm6
         cwKPIAB0o1wl3OuchC7C9/MU5TDclSVnUIbFdCP22sY7QZOrIH2TFqfYEVfcVpdVyDml
         etK9b2bgSxu4pS2isDqmhtPyyifFg6p8/erJNFpWfW6WmfAYYWJLzk6TuedIqUABQZqm
         vYxNpobp+rXjslnIsf4MGC5J3ktpMJwQiKHLGfbx6LyohWdc50PfumfuHGxITBygWixq
         y7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=555QthD3BOi0oKnL9Ait9gVqXQiUN7RsLDwjha1Lgzs=;
        fh=qhHhPG/dlfpFYFGFkCQaK8gr8pIpSb52KccbJKkcwm4=;
        b=ZBUasYTVIFm+Lij/Yh3nZyUZQyZbRYssMNN9Y6jnXBXpoF1rxfWIUUbFEIni76tbfC
         vUV2Y3AkVJprNWK6vbAUGhSg++n3Yx9quWOkHLAbTbdR1BzyLhXW3kj9u/yWm/d+dUgf
         lS7Tb3oWHbM+usAHGlpSeXpISQkwpn2d44rD0ROvfpu598L7nVDwfXyciMCKkbzyaHo3
         U/9prbRAqwJZqNK2yhYKuMwL0R3D1hFRglg7lueUOr2It1QW+SxLPBoLgbUEtpFzk7q3
         Wz36uzRFPhPhAaD3bqMFmUSkpbzSGRDB1hSZlIMSlJ2nAgFTAB0HEYBjmkSSA1J/soKH
         1rDw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771159638; x=1771764438; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=555QthD3BOi0oKnL9Ait9gVqXQiUN7RsLDwjha1Lgzs=;
        b=JsamqMAbxp5IzsX7MKRRwSc7cfDUTQaRI/EWQcSRoLX7GdUNgGyVnURfi76lxRaJaK
         AVNoJ2C7VdCJm/4FnrPv5jTAImat/DU2L2aXve4Ay5uK+euwBonyLovQobIdDIeypovm
         zfK3oSXW6vClSHUFSlfoqv6chVmP8+TEqu1u+IJIHsvqrxDkt+4vjsZx7XiIadvLjsFy
         hGbPzeEbC3n5wabk5AkOIwtWks4mHbN1rRxNSVBIYngm7Kp4ENUR2WDHL+4eCZ32+dl9
         NT5CAF5uLGjqyIpbVFBkRytekKHUXq/d0m8QHt8JhD4vsW9UcYLF/PgOcXK8WqrU5y40
         A96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771159638; x=1771764438;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=555QthD3BOi0oKnL9Ait9gVqXQiUN7RsLDwjha1Lgzs=;
        b=OPYZDk2P+WzR1zCzlyoIXHV8Y1INGGqx0lxG3e7CSLMLBViy9NQwDMHHfyl7u9HInS
         jaPeo1nhlQZGJ60vPZh2vlo9htSaSqReCqTZx1d21mx5pyYCoI7HOE775CNFCnG6nAnk
         xe/vtM1fy6R3f1oi5Wz3FeExkaRZFOhWm5uY8gqQopZqKBz5sRJlf4S2qYICvuPEG4O/
         ONTqoYQStr5aPBsje31CKbWOUguacBgq4fTmfRzuctNs56JVl5hFQC2Ag0hEligxhvUI
         N/NlCQVKaLI5g2gsHrVuhcVpmc8OW0kXOCZj0OWS1bYQcqVZ1s8mG8Iy+TIG8WJg9vlC
         mGjA==
X-Forwarded-Encrypted: i=1; AJvYcCVF4B+9K9FPMGYJclAQbYN8FzhJkDJSG0bkK+G+gwuUpCd57RPWEijH0LwWUMebCadK8xCy0adikw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwaJ4b5hlBc0OD4XvnJ8g0iRlUMKG2CuF0kbAo1ESiM3l4lq1HB
	l/hyR/RS71oipBg/Dg7+t91dMzdCwmH4vzRjr0IoQ4s78ihi0l0wy01J4sHQqLJBu9Lb5l2yzCI
	Q4XPmwwmCVEMHWrn7MfQ67ClhZAkMZSU=
X-Gm-Gg: AZuq6aIXQRH8zoDGiiUN2DZZyeHTF5OQ0sCKCI3VBfSsXNhhn4yjM2f4hS0mgCqaS9L
	7vJ5nqZo45uGBzIGRPMyHTjt5F3Q3eNdJHSmvKy+oiBLzSucmkbCr6olTnyUQ0b5SaA4ISsax6S
	XAjfuqUq/RTV544nEJtbETtVry4ucm3r9q6eRbfCQCS0AU6SNgPHh8LvvPNwi6u1Zwuy6/nj9Ck
	puYEXUHOXP02LZoLb/dlOtXHlxfcGZ3j5XB+gG2XqjgDQJ+F/zJH1DY9TXG9Mip3uiMDgT1N4M+
	q1B81ut5+Jw2zXaa3GdqEvs088zwN1llKzSxHn19cX0J1Ld/AbVUV42rEIJ5PRBO9OqKiAGMAMN
	DDlrS5Jh0A5+bU7mYY8C0HryHBp/TWBwGunY=
X-Received: by 2002:a05:693c:3747:b0:2b7:f145:a98 with SMTP id
 5a478bee46e88-2baba010c63mr1740180eec.2.1771159637646; Sun, 15 Feb 2026
 04:47:17 -0800 (PST)
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Feb 2026 13:47:05 +0100
X-Gm-Features: AaiRm52xhFAYmyYTEXemxfhC4DHyUHZ4W6znoAlEOviZgMAfjb63hI2InUlCZ8g
Message-ID: <CANiq72khOYkt6t5zwMvSiyZvWWHMZuNCMERXu=7K=_5tT-8Pgg@mail.gmail.com>
Subject: Mainline UML Rust stable io.rs unused imports
To: David Gow <davidgow@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, driver-core@lists.linux.dev, 
	linux-um <linux-um@lists.infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260215_044718_889577_F1DA33A2 
X-CRM114-Status: UNSURE (   3.74  )
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

Hi all,

In mainline and next, for UML with Rust stable (but not with Rust
minimum), I am seeing:

      RUSTC L rust/kernel.o - due to target missing
    error: unused import: `define_read`
       --> rust/kernel/io.rs:229:16
        |
    229 | pub(crate) use define_read;
        |                ^^^^^^^^^^^
        |
        = note: `-D unused-imports` implied by `-D warnings`
        = help: to override `-D warnings` add `#[allow(unused_imports)]`

    error: unused import: `define_write`
       --> rust/kernel/io.rs:262:16
        |
    262 | pub(crate) use define_write;
        |                ^^^^^^^^^^^

Cheers,
Miguel

