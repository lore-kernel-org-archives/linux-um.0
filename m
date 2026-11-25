Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7177B606A31E
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WL6H/JXH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ba/7Mj5S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Subject:Cc:To:From:Message-ID:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=LnCCBDXRQIYv5Cg1tccoEkHx/G70j3b4/jKlGrUgtA4=; b=WL6H/JXH4Kl+4pV0DIBWLWqmzw
	NY3AGVlNDr7Mi/YFFYf5TonC2vIG2VhVD4H+qfn0tdtkur1DxHxw13qvintQJYL58i/XET4MLb35a
	Tw5ajD8diIv1QLnOwT74qOoy9D80rsXaHyKP4/E3yRC/kpl1z+hADFshCE0FzKXnaYd00/7GVP7/E
	qGk/x8xQ5jgW/5utZOwymttG8jYv0EpkAhDXzWvoC58tTxKBOPxoXptLl0f2J6GXPJSnLmrb1TsY1
	GiLbBSbAceIg1d48TUbqWOKT1+vXdbdYjjjQekWXXPW1Qtc4h23JKVBFefpxJ2hdE0TEAkL1bq5xM
	cdTW6POg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW58J-00000008R4j-0rQk;
	Wed, 25 Nov 2026 05:01:27 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW58E-00000008R3n-2jPR
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 05:01:25 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-15ea896ddc8so8952379c88.0
        for <linux-um@lists.infradead.org>; Tue, 24 Nov 2026 21:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795582881; x=1796187681; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LnCCBDXRQIYv5Cg1tccoEkHx/G70j3b4/jKlGrUgtA4=;
        b=Ba/7Mj5SZXQVEgFezRaZa7eCBf5f0Iiimv0/VTE0QbD9gv90tLmUjo9HBRhtg6xbHi
         hpxtM8F2rDGVGJLUa0qEOH12/2S9cPXY+zV0vJT8ji2TqNds3JehDBK3CAK92FvpY+1/
         BrP41lKSN8zDKp63NIyS3iWZIf9QQOgd58R8sQhrM+incg5B3TE6fWGwq03xhuHdnVI4
         1TszJb88F64fN8/YsDbknVa6ROlzxbfdkxAQA3liF8SHNHNFQeOvOQonKrNCRoS9kPmY
         Jc/C4mh+Xa3TRJ+JG5Ece2bmU1FSh3VVeb77cjlPfIAxzwvKbI8RfqA1wEGoxBZtso1B
         BqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795582881; x=1796187681;
        h=content-type:mime-version:user-agent:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LnCCBDXRQIYv5Cg1tccoEkHx/G70j3b4/jKlGrUgtA4=;
        b=TS/EdXnByQAP4+sVA6MPeZCEER/6MZLqXkT+55GjKJtJcEfC+ITq2Z3X1WVHtmB9yA
         E+e2yykgTt5/twXQWLmQVj93zOqp6DrfxWsuufigQjXQ7eKfB9pAUjgOTCdypVbOzh5g
         pXSYY7JwVfhZ5x1RihSmCqe2YwifDz4tB0aICvwudQ8J8EF62UklyGRhBLa8BBz7cI3N
         oqkf+zPz4dg5WfFb2VkWC5RqlAAk3PWhvrsj8dJwkVBRO0JXjMiKHligX/s+3qbaXSNL
         EibFGaT264qL5jN5EWQy4xlX10B+Tl3SThKRohTkjHZkXwK4QC9HcxQznyKzXTbS9fPX
         iNaA==
X-Gm-Message-State: APuU4Z9b8dy+B3t75iATV16QHrbnPAUSrWiLkl4HgPt0VYzBuOYSz18E
	3KGHaai1dLzlL+M+JR6a1Yqs2OSkWEvlPC0COTEmRaal6GR2i0lAW4K3I9/jh2Rl
X-Gm-Gg: AZFdTZfjsnFEliVTliguwBhbfpR+tc1dveGQ+oXNTSIRoZHWGHSyUiEC91cZEXqKTxk
	e/BAJCxB0XfaA38TzCu3+Y47kQNkq6hVx+JAyYd+jENXpXj4tfT6/dCUgC520R2m7vd8xp3v/dT
	CPIjguNo3SDRxRgsB70zhPPjFn8cLSD2FOhxe50fPP7T4B1vhn/T7x0cFXAjav0DNf6nmls+D3v
	BXKr2Sun5TEfiO5LYffjvgB8zJY79Q2+9l953Z5/Vngag/LdIyOttBuCHo1u4GhwFWilv59vTJ5
	MRP+PhLeRQDiXkD2fOiervu+Qx/zW4KNhhyEyGC7M8AmGEhxfi8AVgran7emp8cDO3BFL9v+tg/
	Qy+ArRgftI9PbaqNuko83VgBB6YVzMFz2gijS5vQwCeSKRp5TH2k0SXoonrvn+0Kj9wFahf829c
	B5jpZiT+pMfgIA5/f1Tj4ZcIlAijD6x/os6tujI39XibjBwkDMBF3alqDbzxHELyCA2x7pxwZmM
	+8tamrClHB8yo8MiQ9T/4e7AcQ9j3F9jijDNXh6izYHD/gfYTtycXUkSINbcg1B3aBXw+wQnMSk
	t0k4rAg5K6c32t9VKra3kfYh43zvuI6xbdtSS6zZrG13O3YV68qUH2urq9vQjuTyOWnqoeo2ycy
	gibUUbOe5Ku2TYIba7tvFcw/DUJviKWj36btXA2kD+obiIrF9yTfZoPJr6zJ4rZ2cY+D6vTF7cE
	xtx/tTfxIRqkCKSZlUmQ==
X-Received: by 2002:a05:7022:7f01:b0:1b2:490b:6fdd with SMTP id a92af1059eb24-1b5568aeb2bmr14601447c88.24.1795582881145;
        Tue, 24 Nov 2026 21:01:21 -0800 (PST)
Received: from mercury.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm39551159c88.12.2026.11.24.21.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:01:20 -0800 (PST)
Date: Wed, 25 Nov 2026 14:01:18 +0900
Message-ID: <87pkvtsdwh.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net, anton.ivanov@cambridgegreys.com, richard@nod.at
Cc: linux-um@lists.infradead.org
Subject: [RFC] regression testing for UML
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/31.1 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_210122_733789_3D46F130 
X-CRM114-Status: GOOD (  11.61  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hello,

as a follow-up to the NOMMU patchset, I've put together a small CI
tool for UML.

Because UML now supports ptrace and seccomp, MMU and NOMMU, and
several clock modes, SMP/UP, I'd like to make it easier to catch
regressions across these combinations when new patches are posted.

https://github.com/thehajime/uml-ci

features:

- poll lore every 15 minutes for new patches and complete series
- apply the patches to uml/next and run checkpatch.pl
- build two x86-64 UML kernels and run 16 boot profiles:
  (mmu/nommu) x (ptrace/seccomp) x (normal/tt/inf-cpu/ext)
- publish a web summary and preview a reply on failure

examples:

- apply failure: https://github.com/thehajime/uml-ci/actions/runs/45548009839
- 16/16 boots passed: https://github.com/thehajime/uml-ci/actions/runs/45548014468

# you need to login to github if you wish to see detail of above.

questions:

- would one email reply per series on apply, build or boot failure be useful ?
  for now the bot only drafts the reply.  checkpatch warnings stay in CI.
- is there similar work/attempt this could build on ?
- would KernelCI or another project be a good home for the code or runners ?
- what other profiles or tests would you like as a baseline ?

any suggestions are welcome.

-- Hajime


