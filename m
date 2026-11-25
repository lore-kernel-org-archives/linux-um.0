Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E94606A321
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gZRgWG8O;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SdcVJfBC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=OkVXy7vaMlgWTZnVIghefxRfwct0ouu4X6Eok4eEAXE=; b=gZRgWG8OBdqAh3gQu3R7mKWnfK
	oCbsXIMBDDNo7etgij67TKQhYX/Ek+Zb80cKrslhBCzLfrEWji5MoG2B0jXjQRs6z8uMPlsClL6IY
	WBwR2otPaRZoTy7thAeXCbXAcjQgGRr8sgigbRoX69lAuCMNbyEm4jifduz8JHT0d4d4HMD88eznU
	JD7HYjoLloAnoXaJTGkkH2vdHPaVgQIkCq03hUMlejXCTtQtLxqGCXjiLefPR96L6xK0A66oBxDUt
	hbj3r4rf0hT7D+tSYOZuWieEUDoVS1fu+4kKcsSpqVrxu4jl+TrXgwNQSpwsf6BmcnUtXc/Do5lcI
	VI/gmIvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFnJ-0000000AY1b-2wf6;
	Wed, 25 Nov 2026 16:24:29 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFnB-0000000AY0W-2Y2W
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 16:24:25 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-c505994e5f5so91243166b.1
        for <linux-um@lists.infradead.org>; Wed, 25 Nov 2026 08:24:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795623859; cv=none;
        d=google.com; s=arc-20260327;
        b=Z19/aNBD8EKFnktAz8AbubhlBISN1aSN7+5lCDTp+qz9MCp8ncKterl5tuHsjvdH75
         iOq+WzO+RzCJRsa9BpPjUe9vgxhVaG0tRkKMmr87LuMCKvHyPxOqWzQuNrWVMgjtID9t
         lyGP6bEK2y/uKKZoFYV7uNarVaaASqZNOZwTrTUgKHELXSUo21x75vfWbsgrNAEYpZa3
         QF3rnjEcDhaHxgVzNyEHiTCaX0phcc8VBTtatNVPKp7VyDx5E23F/zeLvekC9UJdv/YE
         AGms5+bfkwXr5uhVeC4vFbrWiZPO1t50ET3VB9xG3AHsApUmiW6E6pRNHaEbE1grG0pH
         A0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=OkVXy7vaMlgWTZnVIghefxRfwct0ouu4X6Eok4eEAXE=;
        fh=8Ws1xr+ah90hLP+SDEJLjCvE2D7OmRBktxuBoJRLg+E=;
        b=b/3uMsoTB7kNxaGW6Jhy1HC7vnX392tCCZ/NSPbgF27UtyV8eU66oMmcUIoiK9WPKp
         EpzFDcX/2XT8piSNISn61OBM/TbWLy4/fM81KPE2ENDkuzSjJUwCgfcxDsxoEms0IWI7
         iVAZ4NHn5CSD+kBWrOZjAHm9gCymlSr07mDBNln3dXcgKJfsbXnAWpPjkVMdfYZ09Pw8
         HjC3LJpLddBSj+AEAwOnSOiBdbEC9ri6YL3+LH+ckC+BpSwBFCW9/Tx3wm9MsYipWoVQ
         f/N5YhxJwjHzfhz0LSvR7hHu4Vmrwi0ot8fSxZEfYJV2A7DP7OaUP9wFvqSbBIQCzW3K
         NCTw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795623859; x=1796228659; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OkVXy7vaMlgWTZnVIghefxRfwct0ouu4X6Eok4eEAXE=;
        b=SdcVJfBCa4/Qq2v2CWPS3wJmF0EybfT6RR1M96VjdW8yZbF14j1PDpdFdC8EhnD8zg
         EfZhOa9uXY0d2gPrYE/gdApIpxnOWeauf3wt2NhoavjLFK+FTAkQzIqfE5uorF0k/IDB
         AQCw26p3TNTkSOXAluIH2945An2yz/igkpark9tSnrrDx2JuPV5+UQJl0gCCIK1cDhN2
         IYHFrUo38BrhYy9FRS0JG12NCGib20CDacnabM0FsMBoWPAO8xyc7CIZ31RYRjMo0nRb
         CIG5SpnF5BltE17h4lnveKQrZ2r0TqnM+jdVSxubLtOHmzEhiB7RayISlGvVMfvco+Fx
         GySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795623859; x=1796228659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OkVXy7vaMlgWTZnVIghefxRfwct0ouu4X6Eok4eEAXE=;
        b=amxDoeObGjLQQKtnPXW/rpDw8uA3bsNCHijLuOKD/EeDShVSHY61Wp65yz73p/iwca
         KI+QdXGCmSZ/zstswrwgXsfE2GEbbpjDwELmY9qaNmnzLlWpWSKWHtZyIn2/ZkqB0rj1
         Gmzk+W6/xzGKsR6Ma8H6fc04prVvDMqZEHjkVkL0miZ+rPuEN8OI4dG+O9UsuPcmzsCd
         6xBqVzHWp7VW0H9ash2VQ8c0O3yhuEVNrzGP0ZDIUD6BXzaoai2hj8ndg03pmIlUo5Sr
         /huHPdz/yXAVuPTy4kUHbd/CQMHOjE7LuE2sx5C8mT5Wv7o5kcoVhe19UfHWYYAb7YTf
         LjvQ==
X-Gm-Message-State: APuU4Z/LY6qSbRV68UGydTMRP8/KdySZqsOzb960DujZK6rFCZCkW3Si
	mEm9fRD52YuLfY7pvzNOggivoIaHjSoh11xki+UcAECoFKkoGswGRbqgg1csGF/fBPUCSmiUAzn
	hR3Q5e60OsXAIRAS1igm0uMezWtRXQTDI6StiRb0=
X-Gm-Gg: AZFdTZcqghnSjuVUA7LpQc749SfXw+CfGv3e4qD4W4PEcp1fwwC+RwS5G+0bjz2k06B
	zxUOhuZgTOqYvaNR8KMrPXPDQHHZevyPwdTUkogDLwQ8RKJgHl27GRKRuLTJsrVI+k7z6swsLgx
	lqSuADqWIcQtZdm1qORviB7XmYo8wE1vHWK5IuoJpXPCpHIfmqu8EaDPNdLQOsgdo1jfVsg+vlP
	Mf7VrkKFNwQpDaojGNwG1ovgJTgWLB3rJHt6zHYgNbH1XdDCn4Ab0HY3M4eyEpT+DaMjk3OITOQ
	/0Nlp/7el7lUkHCYqj9L6wsdrQ+KcbWn7XYGhtmsRyYVzCHlOpE/L+2FIgg5jqfy46NH53B96yV
	auZQR++/o6AkTN5XEZFWbwwvZJq4i2KI4uqYuOClx4bkm0FeEcCRBltkZqwc735SEq0+4pT+Hef
	kCNX46XemCNu4WXVND3tq1RpXB15/ij0l2WyIoLNVrWYzKqxQX9E8QhjX3occm0QTbLLVudA==
X-Received: by 2002:a17:906:26c5:b0:c51:3b84:6fb8 with SMTP id
 a640c23a62f3a-c513b84886cmr1340615566b.4.1795623859387; Wed, 25 Nov 2026
 08:24:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Johan ter Mors <johan.termors@gmail.com>
Date: Wed, 25 Nov 2026 17:24:07 +0100
X-Gm-Features: Aa3M54rhn0OhvnvNcBJXJygsEcL3oqYtUbjpsey4x_JbRXv9ZBO2KUyVc0eiFJo
Message-ID: <CAPM+r-Jaz9c0d1F3QP_5aZDnRMGVmzWDrp-FMUcvUv5e2RpB_g@mail.gmail.com>
Subject: =?UTF-8?Q?UML=3A_=2Fproc=2Fnet=2Fnetstat_silently_mis=2Dread_by_stdio_li?=
	=?UTF-8?Q?ne_readers_=28fgets=2Fgetline=29_=E2=80=94_raw_reads_of_every_size_are_b?=
	=?UTF-8?Q?yte=2Dexact=2C_all_other_=2Fproc_files_are_unaffected?=
To: linux-um@lists.infradead.org
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_082421_688771_6EC88F1D 
X-CRM114-Status: GOOD (  16.28  )
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[Quick note before the report: my earlier mail of today carried a
mangled Subject header =E2=80=94 my mail client put the intended maintainer
Cc addresses into the subject line, so the report went out without a
usable subject and without the maintainer Cc. This thread is the same
report with a corrected envelope; please treat this copy as the
report. The mangled original is archived here, for the record:

https://lore.kernel.org/linux-um/CAPM+r-+XCeM01ZXAj8Cti5qL1iaFrGrV+dYSumWD8=
585O3swew@mail.gmail.com/
]

Hi,

While parsing TcpExt counters inside our lab guests (own lean UML
builds), we hit a reproducible case where stdio line readers (fgets
and getline) silently mis-read /proc/net/netstat =E2=80=94 while every raw
read of the same file, on the same boot, is byte-exact. The same
statically linked binary behaves correctly on a non-UML host kernel.
We have not found an earlier report, so here is the full picture. We
could not pin the final mechanism; the data is attached so you can
judge it directly.

Observed:

  - Which stdio call mis-assembles varies per process instance of the
    same binary; within one instance it is deterministic per fopen.
    Captured byte-exactly across instances on 7.3.6 and 6.12.117:
      * fgets(buf, 16384) mis-assembles in most instances. Two shapes:
          (i) the TcpExt *names* record is lost except its first byte,
              which fuses onto the next record: the stream starts
              "TTcpExt: 0 0 ...". 2002 of 4197 bytes on 7.3.6; 1718 of
              3862 on 6.12.117 =E2=80=94 exactly the names-line length is
              missing, and memcmp proves the output is the pure
              subsequence "T" + rest-of-file;
          (ii) full-length output (4197/4197) in which the names
              string is absent and 16-byte windows exist that appear
              NOWHERE in the file =E2=80=94 the reader's own stale process
              memory mixed into the assembled stream.
      * In other instances fgets(buf, 4096) mis-assembled (names-line
        length missing, plus foreign windows) while fgets(buf, 16384)
        was byte-exact in the same process; in another instance
        getline() returned full-length output with foreign windows.
        So no fgets size is a safe workaround.
      * Three fresh fopen() repeats of fgets(16384) in one instance
        where the earlier calls were all byte-exact stayed correct =E2=80=
=94
        but we have not seen a rule predicting which instance fails.
  - Scope sweep, both UML kernels: 20 /proc files (net/netstat, snmp,
    dev, sockstat, softnet_stat, tcp, udp, unix, mounts, cpuinfo,
    version, self/limits, self/status, vmstat, meminfo, stat, uptime,
    loadavg, ...) x 6 reader patterns (getline, fgets 512/4096/16384/
    65536, fread 16384): every file reads byte-exact with every
    pattern EXCEPT /proc/net/netstat.
  - fread(buf, 16384) and explicit setvbuf() configurations (4096/
    8192/16384-byte buffers, _IONBF, _IOLBF) have so far never
    mis-assembled (limited number of instances observed), and raw
    read() is byte-exact in every pattern we tried: single reads of
    18 sizes (2048 .. 131072) at offset 0, sequential pairs, and
    lseek(K)+read() sweeps across the record boundaries =E2=80=94 on the sa=
me
    boots where stdio mis-assembles.
  - The identical binary on a non-UML host kernel (5.10.134) is
    correct for every pattern in every instance.
  - Reproduces on 6.12.117, 7.3.5 and 7.3.6 UML (own lean builds;
    defconfig + MPTCP/HOSTFS/BLK_DEV_INITRD/RD_GZIP/VETH/NET_NS, and
    SYN_COOKIES/IPV6 on 7.3.6; DEBUG_INFO/BTF off; two small
    ptrace-only lab patches that do not touch procfs).
  - We do not have a non-UML kernel >=3D 6.12 in this lab (no
    hypervisor), so a stock-kernel control is still open =E2=80=94 running =
the
    reproducer on any regular 6.12/7.x box would pin the scope nicely.

Security note: we checked this explicitly before reporting. The
mis-assembled output contains only file bytes plus, in the mixing
shape, the reader's own stale process memory =E2=80=94 never anything outsi=
de
the reading process (the kernel's raw read path is byte-exact on the
same boots, verified down to writes into stack buffers; memcmp
controls prove the file content was stable). No crash, no splat, no
privilege effect in any run; the reader is its own only victim. So we
do not consider this a security issue =E2=80=94 it is a correctness bug for
common parsing patterns, and monitoring agents parsing
/proc/net/netstat with stdio on UML silently lose the TcpExt field
names.

Minimal reproducer (static glibc, reads the file, prints three
numbers):

#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
int main(void) {
    FILE *f =3D fopen("/proc/net/netstat", "r");
    static char line[16384], all[65536];
    int tot =3D 0, l1 =3D -1;
    while (fgets(line, sizeof line, f)) {
        int n =3D (int)strlen(line);
        if (l1 < 0) l1 =3D n;
        if (tot + n < (int)sizeof all) { memcpy(all + tot, line, n); tot +=
=3D n; }
    }
    printf("first-line=3D%d total=3D%d names=3D%s\n", l1, tot,
           tot > 0 && memmem(all, tot, "SyncookiesSent", 14) ? "yes" : "NO"=
);
    return 0;
}

On UML 7.3.6, failing instance A:  first-line=3D1 total=3D2002 names=3DNO
                                   (names lost, fused)
On UML 7.3.6, failing instance B:  first-line=3D2196 total=3D4197 names=3DN=
O
                                   (full length, stale-memory mixing)
Correct instance of the same binary on the same guest:
                                   first-line=3D2196 total=3D4197 names=3Dy=
es

Because every raw read of the same file is correct on the same boots,
we suspect the fault sits in the interaction between the UML
syscall-return delivery and glibc stdio's line assembly rather than in
seq_file's data path; the per-instance randomness (same binary, same
pattern, byte-exact in one instance and mis-assembled in the next)
suggests the failure depends on the reader process's layout/state. We
cannot split that further from user space, and a ptrace-based tracer
on UML is not a reliable witness (the guest kernel already ptraces its
own user processes for syscall emulation, so a second ptrace layer
distorts what it observes).

Kernel log clean on all runs; happy to provide the full diagnostic
sources, serial logs and the saved UML vmlinux files, and to test
patches or hypotheses.

Thanks,
Johan ter Mors =E2=80=94 independent researcher

