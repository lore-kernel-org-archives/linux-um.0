Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67719C7EE23
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2F66kamkfWm2MjHNggCU7o9JJqeiofGZHYXZKvLU0Uw=; b=O789a0VxExW6q0
	P0STAVKkl/JOVR3l11xa1VzHgAjV6fAVwIJdlOYz0IMqe2D/q4j2B9kxdKrtX2agGtFZy2HTtvGIM
	0PsQETQJBkNCXroY3Pcca5nNDdo+kHycs2cR+JYAVUcWZSqRII6lMRy+0rAJsnxrLb7KBpOMkZQ+G
	KawfQ7kkAil15gqfFKDbTsoDQ3lB82HOUo13YypdEZ0TrlLaWpExFJ+lTNLDNWTFerb2BUqO8yXnv
	wArfcGqoD+p80fhHpqmToxF0cQny7oIjgyRgB33S4WUcweaIpfkpkNHYORsQHP3CFXS3Ra3HLNzRe
	FxfTeTK/Q9ewaVdvs7Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZH-009cEI-00;
	Thu, 08 Jun 2023 14:24:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZD-009c9c-1y
	for linux-um@lists.infradead.org;
	Thu, 08 Jun 2023 14:24:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 764A763CDC;
	Thu,  8 Jun 2023 14:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7A8C4339C;
	Thu,  8 Jun 2023 14:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686234286;
	bh=WxsbZJQWaT5jCsrdDCJG6B1Ekj8QHp6BWQx+hm3BcWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLIntpqlzV0PbXTunOMMpYAbiC5B7RzbxYYbqvwtEwLaTiLF7ZmPeFO95GFKba0Jn
	 VDBNtT3wUnFHvkz15AIr0Ai5TNfHAI/lbUuC+c4mNVdJBdWb5Iqe4xdGRMiRdfLo/1
	 CRns73rILLWLvRiOL6YgKsthMyMgWdYkt8g3fOp8AP1k9KuD7dXbxiWSzXY4krmNMt
	 zMtu3NkGpcWa+uORL5M3NxCMz4lchkYojjnC73CKuXufUnMCicLrLynGbKgrjrqMNm
	 q7Gqju5e7XwhWorTDS7a7oRqX0fWkmVJ1N7umFCs3hUp6ZztOGcG9pkYU1XPr4McHa
	 J+eAPcqHWH8Vw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 06/11] modpost: squash sym_update_namespace() into sym_add_exported()
Date: Thu,  8 Jun 2023 23:24:23 +0900
Message-Id: <20230608142428.256985-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_072447_691120_C77B7B93 
X-CRM114-Status: GOOD (  13.05  )
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
