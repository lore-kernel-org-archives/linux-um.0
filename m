Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F219C001B0
	for <linux-um@archiver.kernel.org>; Fri, 14 Jul 2023 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eBxriuyjgkm+d3YlxJNrpjWsaQbZtyAm3KlDliMXi9I=; b=ljIPtjfTEjuovx+bo6Mop5e30m
	hpglchupv0qtMOd4p1jPCaLumd/auOCCH4zwNLBVLtnXRyswQa9Z8X+8d/5fXBpgpdL5itxbaGF0z
	zpotWhHUgsDJZ4jzaOR2Yg8CPWuRrx/oOxb0+Kilf7skARY2PEoB4AIhWDt2PyZ9Mkt0mFIYYv1b8
	sTHFCjiwSVEg997MsLhBbtbV+C7Ns2ab+0kE4Y4Vux/y1UuTftjVbgoD/Ee8iPKhfKGeQMvXOzckh
	Hb/uJLa9EcgBxxhjDl3OHpoeLkht/1GR2oB67gKpsNU8VLTkuUsqveyM733aWX+fkhT7E2UC804Da
	4c1tOB/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qKRj7-007PGO-2a;
	Fri, 14 Jul 2023 22:57:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qKRj3-007PET-28;
	Fri, 14 Jul 2023 22:57:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B29F661DF2;
	Fri, 14 Jul 2023 22:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C28C433C8;
	Fri, 14 Jul 2023 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689375444;
	bh=P8clI5KtqQRzgFfns22g81I3g6E4+6MLCwEqWyZYU68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjATGNeW2AnMB8iSVCidFlZhH9OfkN7bAt2p7ldacOlxk00MBC0K43n0wGgdC/kES
	 5er615dq9DLL0q9cE1VNLaWlbFSi2IfYsicV7umDzTZyH4W2s60ky3l5tGI2zapesZ
	 a6IFRb5wsW2IyAbgdPu3qj324ZAqxXKa5uD5MSOHkbg0ycP0RX1WKos7Wx9s9h14c7
	 mr09nK6DvKTxBa912H2K859rBf/1exfAJQyuctMgVjw5UcRvPGqHIzg/7kZ1W2WHDS
	 fPdS6OedIvs2Ff2PDWFgTKxBrTglm+398FEIc7xd983iXS7+gUDgWarryvZetDtEg3
	 d1Xp1VJIV7NTA==
Date: Fri, 14 Jul 2023 23:57:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eugene Syromiatnikov <esyr@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	"H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Weijiang Yang <weijiang.yang@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	John Allen <john.allen@amd.com>, kcc@google.com, eranian@google.com,
	rppt@kernel.org, jamorris@linux.microsoft.com,
	dethoma@microsoft.com, akpm@linux-foundation.org,
	Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
	david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
	torvalds@linux-foundation.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Message-ID: <b389274a-abed-40dc-8e33-7ce922ea9b61@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
X-Cookie: Preserve the old, but know the new.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230714_155725_810157_3D560970 
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
Content-Type: multipart/mixed; boundary="===============4759763630573289230=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


--===============4759763630573289230==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Om+vkuYZS0OLKEiC"
Content-Disposition: inline


--Om+vkuYZS0OLKEiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 05:10:27PM -0700, Rick Edgecombe wrote:
> The x86 Shadow stack feature includes a new type of memory called shadow
> stack. This shadow stack memory has some unusual properties, which requires
> some core mm changes to function properly.

This seems to break sparc64_defconfig when applied on top of v6.5-rc1:

In file included from /home/broonie/git/bisect/include/linux/mm.h:29,
                 from /home/broonie/git/bisect/net/core/skbuff.c:40:
/home/broonie/git/bisect/include/linux/pgtable.h: In function 'pmd_mkwrite':
/home/broonie/git/bisect/include/linux/pgtable.h:528:9: error: implicit declaration of function 'pmd_mkwrite_novma'; did you mean 'pte_mkwrite_novma'? [-Werror=implicit-function-declaration]
  return pmd_mkwrite_novma(pmd);
         ^~~~~~~~~~~~~~~~~
         pte_mkwrite_novma
/home/broonie/git/bisect/include/linux/pgtable.h:528:9: error: incompatible types when returning type 'int' but 'pmd_t' {aka 'struct <anonymous>'} was expected
  return pmd_mkwrite_novma(pmd);
         ^~~~~~~~~~~~~~~~~~~~~~

The same issue seems to apply with the version that was in -next based
on v6.4-rc4 too.

--Om+vkuYZS0OLKEiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSx0sEACgkQJNaLcl1U
h9Cgsgf+I5DDysBO4SJ+jmxeXww6HYCycJsoc6oA/wVf/wO7aTv89RFcAPpwMOoq
jZKiD/xiUtCMUcNE+ZtCQIYVymIrK1BBcNPzgflt5fa50gm53Hp2mcNFaUeriWjC
x2DfyH1wsfgAjwv14aKu1m59Y7xdhIQWZ4HTezaEFND/3GQTrvGy8tHMDL07GKWz
qL1gMkJ7kYVKEAf86IsSwbDBcSa/SV5cLbsL4S5GEm5K/hQcLwUqSw4WYuMLfNip
Eb4Napl5JYGKJcb/IQIm/PGQbmnKgijPg7mR0lvF6RWZk39wCFxKQizahf6cRCwv
HSMmlXJHILeOK57vaStYZJvapWZzdg==
=/plS
-----END PGP SIGNATURE-----

--Om+vkuYZS0OLKEiC--


--===============4759763630573289230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============4759763630573289230==--

