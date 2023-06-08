Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87334C7EE45
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LZpJLhI9WINhyFknVzSBveT5JHpnnNGtl99LVky3dmE=; b=wASCkqwRIf4Gop
	bD++QFO1EyLwKDelO6A3YXk+dug9jFdqG1cSDKwfkekbgmfuOADUhgEzf1dHPMqZhg9qY2vRI0XRi
	A8Wzh2Egt85aqAGmX7NcGg1AdMuUhs1blRD5P06VQLuHuQSZoBm7Ugvnsl3hZ+Yr4wD5I3XscguOP
	gWuPPI2HwgvWuwrtQYubpW5nV/zv6t+K92Ne62VMCj9lO1wHLEqqkXWqbWpTyXjIEh4sbrEl+baez
	/Vf/daQHZRKTKIcNpuDTENjsNc6du66Ox2Ny6gTV8QjPWQWCc8jBI1hMEWSKpGcSwqE2bCXRu/6eF
	RnMTx+0aX8pHVpBH02EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZA-009cAH-0W;
	Thu, 08 Jun 2023 14:24:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZ7-009c90-0e
	for linux-um@lists.infradead.org;
	Thu, 08 Jun 2023 14:24:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8942464E1D;
	Thu,  8 Jun 2023 14:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05E9C4339E;
	Thu,  8 Jun 2023 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686234280;
	bh=Ly+sWm6TM1FV97DnfVYc+edRAEXC0kuE80+arR4Mn2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIEqPaQTLVy0UhU1ANwEfuEfbfEPgIno+/ovrkvx9dnO45qiOUOgsUsy0jl+9Gnhh
	 izr28sadiVKgyl1es0lpCzCTM1+wBX++R7Wo0xkIdY4inVzGOpE945pi/ckygQNpwJ
	 H1kS13OF2pGCT1NrMKtWJj7HhYrZ6iOMBF0tZAYK/keO3xz6XJFbaSq9tA87gkOz0/
	 Xqu7W0u4tu4GE85hoZP+Eb0S6BC9kNRmPdvobLpSqIyBkeoijjkqtVQlCRLGkr9sO0
	 izcqZemm2v3L+Zz8NmAwS2k6MKDXYl4vDVhhi/mSSmGdIlZ1k1jfXMVLDhYGJdAOti
	 RLXebP6yE/j0g==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 02/11] modpost: pass struct module pointer to check_section_mismatch()
Date: Thu,  8 Jun 2023 23:24:19 +0900
Message-Id: <20230608142428.256985-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_072441_320063_552787B0 
X-CRM114-Status: GOOD (  13.74  )
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

The next commit will use it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 8decf04633bc..403ba4d923f5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1211,7 +1211,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	}
 }
 
-static void check_section_mismatch(const char *modname, struct elf_info *elf,
+static void check_section_mismatch(struct module *mod, struct elf_info *elf,
 				   Elf_Sym *sym,
 				   unsigned int fsecndx, const char *fromsec,
 				   Elf_Addr faddr, Elf_Addr taddr)
@@ -1222,7 +1222,7 @@ static void check_section_mismatch(const char *modname, struct elf_info *elf,
 	if (!mismatch)
 		return;
 
-	default_mismatch_handler(modname, elf, mismatch, sym,
+	default_mismatch_handler(mod->name, elf, mismatch, sym,
 				 fsecndx, fromsec, faddr,
 				 tosec, taddr);
 }
@@ -1406,7 +1406,7 @@ static int addend_mips_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 #define R_LARCH_SUB32		55
 #endif
 
-static void section_rela(const char *modname, struct elf_info *elf,
+static void section_rela(struct module *mod, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
 	Elf_Rela *rela;
@@ -1452,12 +1452,12 @@ static void section_rela(const char *modname, struct elf_info *elf,
 			break;
 		}
 
-		check_section_mismatch(modname, elf, elf->symtab_start + r_sym,
+		check_section_mismatch(mod, elf, elf->symtab_start + r_sym,
 				       fsecndx, fromsec, r.r_offset, r.r_addend);
 	}
 }
 
-static void section_rel(const char *modname, struct elf_info *elf,
+static void section_rel(struct module *mod, struct elf_info *elf,
 			Elf_Shdr *sechdr)
 {
 	Elf_Rel *rel;
@@ -1507,7 +1507,7 @@ static void section_rel(const char *modname, struct elf_info *elf,
 			fatal("Please add code to calculate addend for this architecture\n");
 		}
 
-		check_section_mismatch(modname, elf, elf->symtab_start + r_sym,
+		check_section_mismatch(mod, elf, elf->symtab_start + r_sym,
 				       fsecndx, fromsec, r.r_offset, r.r_addend);
 	}
 }
@@ -1524,19 +1524,19 @@ static void section_rel(const char *modname, struct elf_info *elf,
  * to find all references to a section that reference a section that will
  * be discarded and warns about it.
  **/
-static void check_sec_ref(const char *modname, struct elf_info *elf)
+static void check_sec_ref(struct module *mod, struct elf_info *elf)
 {
 	int i;
 	Elf_Shdr *sechdrs = elf->sechdrs;
 
 	/* Walk through all sections */
 	for (i = 0; i < elf->num_sections; i++) {
-		check_section(modname, elf, &elf->sechdrs[i]);
+		check_section(mod->name, elf, &elf->sechdrs[i]);
 		/* We want to process only relocation sections and not .init */
 		if (sechdrs[i].sh_type == SHT_RELA)
-			section_rela(modname, elf, &elf->sechdrs[i]);
+			section_rela(mod, elf, &elf->sechdrs[i]);
 		else if (sechdrs[i].sh_type == SHT_REL)
-			section_rel(modname, elf, &elf->sechdrs[i]);
+			section_rel(mod, elf, &elf->sechdrs[i]);
 	}
 }
 
@@ -1707,7 +1707,7 @@ static void read_symbols(const char *modname)
 					     sym_get_data(&info, sym));
 	}
 
-	check_sec_ref(modname, &info);
+	check_sec_ref(mod, &info);
 
 	if (!mod->is_vmlinux) {
 		version = get_modinfo(&info, "version");
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
