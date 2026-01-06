Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17469CD0435
	for <linux-um@archiver.kernel.org>; Tue,  6 Jan 2026 03:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RNrPWh5AE3rAmQHMWYYn+VrBXM2trm2Kn9xoWyeBbVA=; b=lfDAMpMj8a59y4M4ynnUPLR31B
	Bs52TnYr58foH/YpET1lWNO4HuPQdz+ydFMP0H4YHT/VwJCO3wBJQ3jVdtZTTyONlpfVTxvKcl/bY
	xRSUxely2eD/EEK5WYCXPOpn6VSX+UnIY7JuPdWlbZvgga/FcxTWkGmPmI7YoIA75iKbwJ0DUiA2Z
	zc6fJLLC+WBoiJ9qWedEn8dtLGYyX98EqmX467XMkG4AhSoMfa3HbxMsxtbqVz7QCDZ+97YGDKX31
	YhGzNj+a/cKR9+r8iFubczBifbDYpavmDn0Hh6aQ9sDUAvlTNYz4qLONuYUqiCOtOEeklKA8TLAb1
	z1lK4zjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcxw7-0000000CNoD-1psZ;
	Tue, 06 Jan 2026 03:40:47 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcxw5-0000000CNnj-0v2z
	for linux-um@lists.infradead.org;
	Tue, 06 Jan 2026 03:40:46 +0000
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-890228ed342so5691726d6.2
        for <linux-um@lists.infradead.org>; Mon, 05 Jan 2026 19:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767670844; x=1768275644; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RNrPWh5AE3rAmQHMWYYn+VrBXM2trm2Kn9xoWyeBbVA=;
        b=P8/xksAT5yKm/NmlHLkfStthYiBsRnhrmYtaV8ROmf8gYXaTjAEOEocBUMJhj+o3uo
         IuAl130pcaK46eNJTAd3QvqoRzk38wbXCeXEQkjizzq2Kt5bgsx1tb94u708sZ463Pvc
         ueqd3O8Cz7BZ0OkTAM3sty4jVeI3SrYmeQoNQXKOUVHRGONODvCZHTJTgD1L9BaPsaVC
         8WWtZAGSFbRPXD2V0nIazAPWzwEi0mK/51wNhzkYmAsHiSZ8nJWfIYULU1grBufWr4d/
         X1pR4b+F4vAF34SSIV4cROHRy8NH7czJeW1ktZ7piQc4OVsQ4GOIAI6jS18Y2mscBDfx
         /TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767670844; x=1768275644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNrPWh5AE3rAmQHMWYYn+VrBXM2trm2Kn9xoWyeBbVA=;
        b=jYMcfqLe/rbXYIyK0xbWBwVI3C3sROtXPWTwXvUizuqKLyIvBTzbeR0E9AygEkboDg
         0CKyJEiogWJOWx8Yrtg6jDIsOFJ2ICuNWbhp0gsWvmx+0FkUvnRgbWGVSSCb3P6oarho
         tXsCso6EVyQ3vix8phK7XdQuzlpVMOje92wYLTgEb+CRuAPkey0MnDCZy5bqRssHLpKV
         lIboNuPirqhj5bkMKHERHOJcjBHMe+hm8TBC/AB5jIw2bKs2Yqhlr37J6T/R41Zi5Enq
         j+YlMrD2xPVrkiF1uK2x1B1dYeD4N/33GU2wauJ82EyZdiO41qy2NYNaYTVSOM/4hG1p
         Q/kA==
X-Gm-Message-State: AOJu0YxkcwlLb9YvCkhX4xURbQDqaejmOV2MkENNaTMWZ1tXBZx3Gb8L
	HCtVi3ZIeFLzj94LWK4HZelLB+PEooZZz38IbL7lXQeZwj5aeAs1upbp
X-Gm-Gg: AY/fxX4Hg9m7QEIM+/ash43b3HIFiSR4GhC8X8kpIWqUzr+gUXuSh3Da0X6r5Pp6Pfr
	iyQKde0wS3aI5fs9vUB9Yxp96G2E7TtzMfgu+fycCRt7+DTznr6uDNJPRUFNhntq/WC0Wf4RGWf
	vtFuFo3XQfYC5v2GpniAB26sKffIR4oLC1jVAeOgnVrwbICUDmQIhlM0uPp+9MXuOsLdRJ4Hg7a
	Ry984u3fLkZosvxENfTgdaxHj7HM7Adoc2bY5f0SD5CBJLgr9OCc1zwNibQRK7Rmu4R4VU6CTX5
	JVotD1qJlggxX8OZTCyzQVVzSpfjJSLUz2zhVUDbmV7K1Hh+vpJYlCYiBAMCb9w11cA/+xojCDd
	2A3XRxw/El24aX0xTr5ldyxIyK1GWOt7oVmQ1NHAuYWv4BGPM9k35zibT1G27NHAbZaWki+1GwH
	+HBl/20LH9jKGw4oPaRxDqoYq5SdooN1XmVmEj6kGEKnJb9X7R5SQuSZ2T2egtgZQUJcYnKv6O/
	5ya/7SShsPO1E0=
X-Google-Smtp-Source: AGHT+IHxC3GLxP2uU71mYCKNA9W30x5Cz81+kFYZ7QfeUSFgXUvH7ja/9RuB546wY6MNOWsmqOyxjQ==
X-Received: by 2002:a05:622a:418a:b0:4ee:1ed1:43c6 with SMTP id d75a77b69052e-4ffa7699f97mr21800511cf.10.1767670843731;
        Mon, 05 Jan 2026 19:40:43 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907727c6besm6387786d6.54.2026.01.05.19.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 19:40:43 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B58FF4006C;
	Mon,  5 Jan 2026 22:40:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 05 Jan 2026 22:40:42 -0500
X-ME-Sender: <xms:OoRcaUf8R5TYFlU7eU_xOJfr1hoD_M84P-GdtJNIB7Kflr2906EuMw>
    <xme:OoRcaWr7Lg7gzhN_jv5IL4SY8T7YTT8L3Nmj_IRNyZ2zm6Via9GS6jEwWQF4rkfwP
    Ih_AcqaXCZv5cmNtzm6uAWDwxlm0PDBOXbhqkyiH8hG3pEpn7UgbQ>
X-ME-Received: <xmr:OoRcaa-LWMbgNk4lTtFFBw1_ybH2pj9DnnZm-EUQVuW6C8TuEa4avQ49>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelledufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidquhhmsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghruges
    nhhougdrrghtpdhrtghpthhtoheprghnthhonhdrihhvrghnohhvsegtrghmsghrihgugh
    gvghhrvgihshdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshesshhiphhsohhluhht
    ihhonhhsrdhnvghtpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpd
    hrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegr
    lhhivghnkedruggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrih
    hnthgvlhdrtghomh
X-ME-Proxy: <xmx:OoRcaX4Kv57O0rk0RhqC5Xxvyi9QdLZFyl_Gq76Oga3txO7TDN57QQ>
    <xmx:OoRcaUgkpCJaMiVQyAWj_JDSf8RxsUPhdIDiBBNoNWzVcBbGU0lT2A>
    <xmx:OoRcaeoppTBz5qtC1J4Yz33_hiwLutSkQNMHmB4yjTmvAsBGZXrYbA>
    <xmx:OoRcaQL6dBClgSp70KgbCbA3R-tmK3Ybs9qT7_BeQnO0t8zgVB118w>
    <xmx:OoRcabvlVRZAMpBmzSLua6UK3OGP8Q-stAcwkCU0JbZn02kXwJQRalPE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 22:40:41 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-um@lists.infradead.org,
	x86@kernel.org
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH] arch: um/x86: Select ARCH_SUPPORTS_ATOMIC_RMW for UML_X86
Date: Tue,  6 Jan 2026 11:40:34 +0800
Message-ID: <20260106034034.60074-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aVxcAZe6AEXEfx3G@tardis-2.local>
References: <aVxcAZe6AEXEfx3G@tardis-2.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_194045_273445_F0602F8E 
X-CRM114-Status: UNSURE (   9.09  )
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

x86 atomic instructions are used for um on UML_X86, therefore atomics
on UML_X86 support native atomic RmW as x86 does, hence select
ARCH_SUPPORTS_ATOMIC_RMW.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
UM & x86 maintainers,

I need this to avoid a build error for Rust atomics since Rust currently
only support Atomic<i8/i16> on ARCH_SUPPORTS_ATOMIC_RMW archs. I will
add it to my upcoming PR if I get some Acked-by, thanks!

 arch/x86/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index bdd7c8e39b01..44b12e45f9a0 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -9,6 +9,7 @@ endmenu
 config UML_X86
 	def_bool y
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select DCACHE_WORD_ACCESS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-- 
2.51.0


