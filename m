Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F54EF587E
	for <linux-um@archiver.kernel.org>; Sun, 15 Feb 2026 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ABeDiezQDLnVh+YeCRm+MqNQxddgh777bvsSpmm8Jk=; b=k+6c6X2+li9z5Wg+JXNfxea7yP
	IzOEqc6x7JflLyjdAH97Z/LzSLJMIaPn6kYNPV0GPkc7N2jNdTJNUzsmcoHsWQ9AQyLrzpwZYdy/K
	tAQE1kOiRkiFFAj4d4bET+YWDlf6/hBTNlYJtptl9pWlLBSyl7ZnTostuJ42SxPX69wPcUmwBUC65
	yBKA5vLOqNPvTmhyv5ZFjMEZlfEDbNwFGhLk6epwONgxZei9HLXibOGbgY9FrRHbUXXs9+sG7bx0a
	IBDb72HOi6WBm+b6sOkk5wErpWvHTXU1HrEVpUTt+MX5TkzQrTguy6AkN/WUetM3fksoX1HDJmfFZ
	WNz++2LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrd6l-00000005RRK-3IXw;
	Sun, 15 Feb 2026 14:28:23 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrd6i-00000005RQe-46Ty
	for linux-um@lists.infradead.org;
	Sun, 15 Feb 2026 14:28:22 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2a929245b6aso26014115ad.0
        for <linux-um@lists.infradead.org>; Sun, 15 Feb 2026 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771165700; x=1771770500; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ABeDiezQDLnVh+YeCRm+MqNQxddgh777bvsSpmm8Jk=;
        b=k5Ql++5rcinf/9O5FK1gW2drP9T6NRbH53biI9O1sKSoP84fRexOYru1wiq8oAO2gT
         Pq7GFRaIIB7hYQQVdGCnLJCmHVV6YTPdqmy36LnKZvbw+L7TGor6il3Ii2izgDEUH3UH
         dP20lJGFPWNchTNo1xJybbJvvxcEO8Bdf+s3mDB7/CnQHQfSKGcewRIFKB3ti7SsgLoK
         TbZqnHlXOeQfZXp9a5ZH7jRkZ99OoR/FhJG7FFnI3r1uiWGqsl4IXD2TeUI3KvAuD5Ik
         yOqZ/tRB6k0FtMJZbvB9s2oio3aSI3NbtIxHQ+JhI/oIay7GVqjT3IUSs5cCJG10tUIY
         KbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771165700; x=1771770500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ABeDiezQDLnVh+YeCRm+MqNQxddgh777bvsSpmm8Jk=;
        b=PMRF4het8Smh8ktHEzbDMiKF+ecQ5XYkIyeeA6PuphAF4VyYgwop0z4aepD2BI8fKe
         rcGYAvZOGwCAX6XbGkrH7XN1vtc2Lz/9ou76ORQaOpP8wrYrOm98ZIfTyUv9MUxxGHrt
         2n4y0Muk0MGWZK6wSA672hHVneqiEuhXx4DUZ+0uy+E8vUActcLwvvP4Hq3EdyPtyRX7
         gFB4wsP7YbeBAdA6l1kV5d2N3rKQwTLANX7oplP41QpfbrzyaWaXoRCJXGQZfs9cplkt
         bJqyZdx3J0ulsx0MOt52ULVvWB1MXiBnH3KJ0cWxkLWs+vd9PIClK1UkiiOy700yheKE
         HWZQ==
X-Gm-Message-State: AOJu0YxG9kPmS5Z8Mgni7gppbtWT4dJAuJWpoy41x9C1QaDbASxGvYgq
	xhu+55WDuoAqT/y9rG86U2b+YhIsnWbppItZnu9jzgbYNqmMbOJQ95p5
X-Gm-Gg: AZuq6aLAnYgAR+qotXUT13aZjMpWr6pMjD3GdN4UWxYnhyQrg3mPDs9lG5kr4O5vHNZ
	6H6GJef7kY1w0dNvh/29aagxNWrUjvqaVyHkhEyBwdXcpss8XwiOqbTHSwy8tr8jZE7DYfDLpfn
	a2hc1FpsCYdHk8D2f+DZK9XMx9fxPNAqLWKZqW7BEQKl4Bc+qlqD9GwSEGL4wepvTQZAzynJ/H1
	LC2Lf1gs3I+sOtbgoZxC+0U61WsUyfzHqfxv2jQ9Fdnf/iV6r9XAcJDkl1Ug+c3oj18Ok4Te86a
	m8NpxxGiXrJ3l/ParZiBLvvtJwKgXoMYlUjotW6CcDZ1lWcdQYa8xDz0EULJ7A+N0eY3mlAmive
	EY2mTDXLLfWJJ66/oUpcSzZl+orjGld5l3iqw4gNAwdImxx+Igjvc6Xe4VEbRHc8kRHjhB5YJET
	ks09fvd6t05auVBYjZDrtrk/7AS/tYV2M9sKckq+T0WaQ+9HORw7wChEjI
X-Received: by 2002:a17:903:1b67:b0:2a0:c35c:572e with SMTP id d9443c01a7336-2ad17501af0mr57032485ad.30.1771165699900;
        Sun, 15 Feb 2026 06:28:19 -0800 (PST)
Received: from speedy3.lan ([116.197.216.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1ace5bd1sm45617415ad.90.2026.02.15.06.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 06:28:19 -0800 (PST)
From: "Marcel W. Wysocki" <maci.stgn@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Marcel W . Wysocki" <maci.stgn@gmail.com>
Subject: [PATCH 2/2] um: avoid struct sigcontext redefinition with musl
Date: Sun, 15 Feb 2026 22:28:03 +0800
Message-ID: <20260215142803.1455757-2-maci.stgn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260215142803.1455757-1-maci.stgn@gmail.com>
References: <20260215142803.1455757-1-maci.stgn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260215_062821_016576_67AB5096 
X-CRM114-Status: GOOD (  10.44  )
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

mcontext.c includes both <sys/ucontext.h> and <asm/sigcontext.h>.
With musl libc, this causes a struct sigcontext redefinition error:

  <sys/ucontext.h> pulls in musl's <bits/signal.h>, which defines
  struct sigcontext directly.  The kernel's <asm/sigcontext.h> then
  provides a second, conflicting definition of the same struct.

With glibc this does not conflict because glibc's signal headers
source their struct sigcontext from the kernel's own UAPI headers,
so the include guard in <asm/sigcontext.h> makes the second
inclusion a no-op.

mcontext.c does not actually use struct sigcontext by name -- it
only needs the FP-state types (_fpstate, _xstate, etc.) that are
defined in <asm/sigcontext.h> independently of the sigcontext
struct.

Temporarily rename sigcontext to __kernel_sigcontext during the
inclusion of <asm/sigcontext.h> so that the kernel's definition
does not collide with musl's.  The #undef restores normal name
resolution immediately afterward.

No functional change with glibc; fixes the build with musl.

Signed-off-by: Marcel W. Wysocki <maci.stgn@gmail.com>
---
 arch/x86/um/os-Linux/mcontext.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -4,7 +4,13 @@
 #include <linux/string.h>
 #include <sys/ucontext.h>
 #include <asm/ptrace.h>
+/*
+ * musl defines struct sigcontext in <bits/signal.h>.  Rename the kernel's
+ * copy to avoid redefinition while keeping the FP-state types available.
+ */
+#define sigcontext __kernel_sigcontext
 #include <asm/sigcontext.h>
+#undef sigcontext
 #include <sysdep/ptrace.h>
 #include <sysdep/mcontext.h>
 #include <arch.h>

