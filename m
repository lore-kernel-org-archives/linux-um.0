Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE56C7EE45
	for <linux-um@archiver.kernel.org>; Sat, 10 Jun 2023 09:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2F66kamkfWm2MjHNggCU7o9JJqeiofGZHYXZKvLU0Uw=; b=jAs9/tFHfmokgE
	n4VFzmIgT7l/aB0dJFLt7oGCRAjJLnu8T4Hf9lO7atf/4YIbWFsreiZgeVb89Uk/vllHH8Gkv1May
	fL2igW6939AeXk8JD/OuQmUcz8zF/aTIBUWf2ICzzWq6K8eMn3Lsdvdb7gdo5RGnJcFRgXXbq7SMl
	FzEEAnM92yhT48YzZpXUSSCjW+ERRHlc/nSYHjpFgyYK/vO04znFX1fMXTJopxiiWD6LsrO9UE0BO
	3nM8aMzL882bEgQbrpSdKzVOrhP6mXt8MBFxNdmStGY65EGSQkSwv9hi6FG7nxrTn0Y2pNw+GRneC
	8WavShTBO1Q/Wiq1z16w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ufQ-00Fcio-0o;
	Sat, 10 Jun 2023 09:13:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ufN-00FchK-1N
	for linux-um@lists.infradead.org;
	Sat, 10 Jun 2023 09:13:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 059B36112F;
	Sat, 10 Jun 2023 09:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F9EC433D2;
	Sat, 10 Jun 2023 09:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686388428;
	bh=WxsbZJQWaT5jCsrdDCJG6B1Ekj8QHp6BWQx+hm3BcWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IiVRdteGCFlLKvr6PB4BCZgVXVjEWdD61C3XUb06yo/CsMmc4UWgAdOTV5m1U2nhB
	 zWm617SOqSOTnqPDMiX2W7FX1GzhNVhTWvbKLleGHtqtftwS/Yl++6e7FhyL1r4d4Y
	 eu+XqhXwGgPROTiKzc6lYC3ZK6idH6uEN5g0m68Gd4HqC4wh9FNJNU7/S/7TfXYYzF
	 yL/Y/KQcDirTKqUUhGJLwR2NFl+yT36PPuaQlDjWjfD5VmUeX6vCtP9TSBXxwAWQyL
	 8YTlhHv6426s6URkTD/oOmtFU4fN383j74r9PCZ0VS+9E0F7v4enw4Ble3k0LjncGh
	 +7euzpAbwJkig==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v8 06/11] modpost: squash sym_update_namespace() into sym_add_exported()
Date: Sat, 10 Jun 2023 18:13:15 +0900
Message-Id: <20230610091320.1054554-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610091320.1054554-1-masahiroy@kernel.org>
References: <20230610091320.1054554-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230610_021349_501972_897A7314 
X-CRM114-Status: GOOD (  13.14  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Pass a set of the name, license, and namespace to sym_add_exported().

sym_update_namespace() is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a3185ee6ec1a..4b0a009de0fb 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -355,26 +355,8 @@ static const char *sec_name(const struct elf_info *info, unsigned int secindex)
 
 #define strstarts(str, prefix) (strncmp(str, prefix, strlen(prefix)) == 0)
 
-static void sym_update_namespace(const char *symname, const char *namespace)
-{
-	struct symbol *s = find_symbol(symname);
-
-	/*
-	 * That symbol should have been created earlier and thus this is
-	 * actually an assertion.
-	 */
-	if (!s) {
-		error("Could not update namespace(%s) for symbol %s\n",
-		      namespace, symname);
-		return;
-	}
-
-	free(s->namespace);
-	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
-}
-
 static struct symbol *sym_add_exported(const char *name, struct module *mod,
-				       bool gpl_only)
+				       bool gpl_only, const char *namespace)
 {
 	struct symbol *s = find_symbol(name);
 
@@ -387,6 +369,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s = alloc_symbol(name);
 	s->module = mod;
 	s->is_gpl_only = gpl_only;
+	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
 
@@ -1230,8 +1213,7 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 		return;
 	}
 
-	s = sym_add_exported(name, mod, is_gpl);
-	sym_update_namespace(name, sym_get_data(elf, label));
+	s = sym_add_exported(name, mod, is_gpl, sym_get_data(elf, label));
 
 	/*
 	 * We need to be aware whether we are exporting a function or
@@ -2174,9 +2156,8 @@ static void read_dump(const char *fname)
 			mod = new_module(modname, strlen(modname));
 			mod->from_dump = true;
 		}
-		s = sym_add_exported(symname, mod, gpl_only);
+		s = sym_add_exported(symname, mod, gpl_only, namespace);
 		sym_set_crc(s, crc);
-		sym_update_namespace(symname, namespace);
 	}
 	free(buf);
 	return;
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
