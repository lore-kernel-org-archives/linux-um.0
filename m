Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B880CC7EE37
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E1OFXV0IS4fzFv7uKo7k3RBG9f5WRT17rw5GTnP1GD8=; b=QE9KVONmKd6opT
	CD/zbIm0oowTfKD8VyarKE1SNvdAaXnNfbG1Bg5o7L/Z7NWeNMd1S9seO19TrNYYn33r5f2BxXsz9
	s6HOdPJPMpJ1Rhxk70G3lCmKXd9P9hp0SWOHHevsdMMaU4+dT00KzXkNHW597mn5UvqFFm3favEPK
	TqUYf6+g90UkH9CU9xE8DDWnnnaDHsC6OKIn03BwCnhxRaW+ltVmGKxgPtHx4uJajokQ4iiBmB8hN
	vbAX88/tc9Zs6Bh0QDO+F7o7UcDmRTOs3zhmSAln3UU/kj16PyajY/2e75lC2ZHn7uEkoZ57Xh3nH
	9sxb1Vux+H7O93NXMcWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZI-009cFQ-1L;
	Thu, 08 Jun 2023 14:24:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZF-009cDN-1m
	for linux-um@lists.infradead.org;
	Thu, 08 Jun 2023 14:24:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 24B2164E21;
	Thu,  8 Jun 2023 14:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D36C4339E;
	Thu,  8 Jun 2023 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686234288;
	bh=Ap3GuMqINZf2WdIT1xsNL1OzEvsLgkbr6RhrjaSFN2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/ppkNpUa1T5/FB+OZN82dq2UDzQIyU5Cbo8U3TTO4UUNzBPXl51gEj6FYXPHd0C0
	 B8fBUUD/WnNo6CND5zxE7A91YlNR8D75vEQqCmvaXDREUZMvckx6QEyeAr2D8LRUg6
	 mTEF3tCzZrWR/Bz+RWDK09Bl8RxWyDtiAseu46h6FEXk+pM2XpyEbH01OEkUhVaYt3
	 N6AWER4bq6Z6hZwWxZc4TOIfkzhSS9PaCantt/xrBbkDTIhgc/96+WPERBmKn2RSCz
	 ItV8rK4Zh871ZfPPMNhWASgocY09hJn0uporPngp75NKd2+x//eEWrcaAry+aGCdFy
	 ehyl0GtZu4Lag==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 07/11] modpost: use null string instead of NULL pointer for default namespace
Date: Thu,  8 Jun 2023 23:24:24 +0900
Message-Id: <20230608142428.256985-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_072449_672761_0880F9AB 
X-CRM114-Status: GOOD (  15.10  )
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

The default namespace is the null string, "".

When set, the null string "" is converted to NULL:

  s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;

When printed, the NULL pointer is get back to the null string:

  sym->namespace ?: ""

This saves 1 byte memory allocated for "", but loses the readability.

In kernel-space, we strive to save memory, but modpost is a userspace
tool used to build the kernel. On modern systems, such small piece of
memory is not a big deal.

Handle the namespace string as is.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4b0a009de0fb..7044b257424a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -300,6 +300,13 @@ static bool contains_namespace(struct list_head *head, const char *namespace)
 {
 	struct namespace_list *list;
 
+	/*
+	 * The default namespace is null string "", which is always implicitly
+	 * contained.
+	 */
+	if (!namespace[0])
+		return true;
+
 	list_for_each_entry(list, head, list) {
 		if (!strcmp(list->namespace, namespace))
 			return true;
@@ -369,7 +376,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s = alloc_symbol(name);
 	s->module = mod;
 	s->is_gpl_only = gpl_only;
-	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
+	s->namespace = NOFAIL(strdup(namespace));
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
 
@@ -1823,8 +1830,7 @@ static void check_exports(struct module *mod)
 		else
 			basename = mod->name;
 
-		if (exp->namespace &&
-		    !contains_namespace(&mod->imported_namespaces, exp->namespace)) {
+		if (!contains_namespace(&mod->imported_namespaces, exp->namespace)) {
 			modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
 				    "module %s uses symbol %s from namespace %s, but does not import it.\n",
 				    basename, exp->name, exp->namespace);
@@ -1910,8 +1916,7 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 	list_for_each_entry(sym, &mod->exported_symbols, list)
 		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
 			   sym->is_func ? "FUNC" : "DATA", sym->name,
-			   sym->is_gpl_only ? "_gpl" : "",
-			   sym->namespace ?: "");
+			   sym->is_gpl_only ? "_gpl" : "", sym->namespace);
 
 	if (!modversions)
 		return;
@@ -2179,7 +2184,7 @@ static void write_dump(const char *fname)
 			buf_printf(&buf, "0x%08x\t%s\t%s\tEXPORT_SYMBOL%s\t%s\n",
 				   sym->crc, sym->name, mod->name,
 				   sym->is_gpl_only ? "_GPL" : "",
-				   sym->namespace ?: "");
+				   sym->namespace);
 		}
 	}
 	write_buf(&buf, fname);
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
