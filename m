Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F97C4167B
	for <linux-um@archiver.kernel.org>; Wed,  6 Dec 2023 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0sqQiX4jidKSYz72HUI2YSV1qZhNi8KKqcjXPXGACMQ=; b=b6w76YSRU3rbM7
	PJ2muRsQccJDxJ0PQaSjupdrGTI0L44tD03m8oTe81ec4sW+s9V/YUpw+9Pu22vzavWaIZdEAMJuT
	Q/VR7TeGlfxOHat2zSxG3aGzPTSrnC7XZ2/vAbiDxVKK8iIZjRqMkJoOh/cf1FLl9RjzEQF/WFo/e
	jmSnga5cWcXT3vxJ2h8tYmUjpqd5U419qAMvL7w11n9RVuE6okYeW7I5IL55CNYmjQy0XeN7o6uJU
	z1HBuCn/BL+70tkm8lhdbvmKqIyOUneGyb6nEXNoEs/5zPmuJbybTGaFMiGtqftsSbc4k1SIaHc7m
	KbhCZUkc8xB2Bc+tUyHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAv5z-00AoDA-1M;
	Wed, 06 Dec 2023 16:49:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAv5x-00AoCC-0p
	for linux-um@lists.infradead.org;
	Wed, 06 Dec 2023 16:49:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3CF5D61DD8;
	Wed,  6 Dec 2023 16:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6A5C433C7;
	Wed,  6 Dec 2023 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701881396;
	bh=NSUOAVeSOFQWxSdqEOoUPgeLtKumWFEG5ZtMNjOmQwg=;
	h=From:Subject:Date:To:Cc:From;
	b=X+VQxK1xzmrzWqwWzGcG/rb9BcUkRKWGvxpFySO7SPTSHFMBF6LVTTBIPT8WacvUu
	 kTF49NDmDEQ6HaBW0DZU+M4gBDkFAfBV48JGyILbSIq2J1d/TGtK4WwwZ524+bCI5h
	 IvOAbGNE3xosJ4nAlmIjQp2tTHDoBO0Bhfpj8rq3Bhwt2AKdmQGBjI9OxFXECM2uGR
	 8jbgz33ObyGucgW5UumUJa/KYC1Y2/JWrQh6KE1us8qIuva4wfcDzkLbwDuacIAbpn
	 lV2VJAIzwVYnvR4NTsNYtlCgHOkIOvklOHnzxP2TBsEnCrutOkSiMvhGVwsgQx0o1b
	 1L6sHs2pa39lQ==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 0/2] Enable -Wincompatible-function-pointer-types-strict
 under W=1
Date: Wed, 06 Dec 2023 09:49:45 -0700
Message-Id: <20231206-enable-wincompatible-function-pointer-types-strict-w-1-v2-0-91311b4c37b0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACmmcGUC/6WOTQ6DIBCFr2JYdxqgarSr3qNxgTjqpBYIUK0x3
 r3oFbp5yfeS97OxgJ4wsHu2MY8zBbImgbxkTI/KDAjUJWaSy5vgXAIa1U4ICxlt305FOqj/GB1
 TEpwlE9FDXB0GCNGTjrCAgFwVZVvXbaXLnqVy57Gn7zn8bBKPFKL16/ljFof79+QsklS8Um1dF
 F0uu8cLvcHpav3Amn3ffz+sMbP9AAAA
To: masahiroy@kernel.org
Cc: ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
 keescook@chromium.org, samitolvanen@google.com, nicolas@fjasle.eu, 
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 kernel test robot <lkp@intel.com>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Nathan Chancellor <nathan@kernel.org>, richard@nod.at, 
 johannes@sipsolutions.net, linux-um@lists.infradead.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=nathan@kernel.org;
 h=from:subject:message-id; bh=NSUOAVeSOFQWxSdqEOoUPgeLtKumWFEG5ZtMNjOmQwg=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKkFy4zE9+79nxRYHv6xenZkNP+cmLnfvLg/FK0IdfPVd
 Z7F15fRUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACZiZsfwVyr1cPVloQ0heyTq
 JBvXep3p/h7kPHVnhHLZlbLbWydVxDAydP1v2HH+7MHdweePmx2+0jzlzprrR5g+P2Hi3ppzPY3
 /MBsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_084957_334302_4FB7886F 
X-CRM114-Status: GOOD (  12.16  )
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

-Wincompatible-function-pointer-types-strict is a warning in clang-16
and newer that is designed to catch potential kCFI failures at runtime.
There is one set of warnings in drivers/counter that I have not been
able to figure out a solution for so this cannot be enabled for a
default build but adding the warning under W=1 will allow various CI
systems to catch and report new instances so it will be easier to
enable in a default build in the future.

The kbuild test robot reported one instance in arch/um, which is cleared
up by the first patch and has an ack from an arch/um maintainer, so this
should be able to go in via the kbuild tree.

---
Changes in v2:
- Rebase on latest kbuild tree.
- Pick up Nick's reviewed-by tag.
- Include arch/um patch with Anton's ack to clear up warning reported by
  kbuild test robot on v1.
- Link to v1: https://lore.kernel.org/r/20231002-enable-wincompatible-function-pointer-types-strict-w-1-v1-1-808ab955d42d@kernel.org

---
Nathan Chancellor (2):
      um: net: Fix return type of uml_net_start_xmit()
      kbuild: Enable -Wincompatible-function-pointer-types-strict in W=1

 arch/um/drivers/net_kern.c | 2 +-
 scripts/Makefile.extrawarn | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 4b391dcb7cda8d1353d3bd123d0989550d48c0c9
change-id: 20231002-enable-wincompatible-function-pointer-types-strict-w-1-4a56b99b8c6f

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


